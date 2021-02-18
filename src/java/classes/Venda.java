/*                                                  /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import utils.Conexao;

/**
 *
 * @author Janine
 */
public class Venda {

    private int idVenda;
    private Cliente cliente;
    private Cardapio cardapio;
    private LocalDate dataOrcamento;
    private LocalDate dataPedido;
    private LocalDate dataProducao;
    private boolean producao;
    private List<CardapioVenda> itensCardapioVenda = new ArrayList<>();

    public void salvar() throws Exception {
        Connection con = Conexao.getInstance();
        //não permite gravar a compra sem os itensCardapioVenda da compra
        //desabilita a conexão para a gravação da compra sem os itensCardapioVenda da compra
        //garante que desfaz a gravação de item e/ou compra no caso de algum erro no processo de gravação
        con.setAutoCommit(false);
        String sql = "insert into venda (idCliente, dataOrcamento, dataPedido, "
                + "dataProducao, producao) values(?, ?, ?, ?, ?)";
        try {
            PreparedStatement stm = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stm.setInt(1, cliente.getIdCliente());
            stm.setObject(2, this.dataOrcamento);
            stm.setObject(3, this.dataPedido);
            stm.setObject(4, this.dataProducao);
            stm.setBoolean(5, this.producao);
            stm.execute();
            ResultSet rs = stm.getGeneratedKeys(); //recupera o serial gerado no idcompra
            Integer idVenda = 0;
            if (rs.next()) { //confere se tem retorno em idcompra
                idVenda = rs.getInt(1); //grava o valor retornado
            }
            String sqlCardapio = "insert into cardapio_venda (idVenda, idCardapio) values (?, ?)";
            for (CardapioVenda cardapioVenda : itensCardapioVenda) {
                cardapioVenda.setIdVenda(idVenda);
                PreparedStatement stmCardapio = con.prepareStatement(sqlCardapio, PreparedStatement.RETURN_GENERATED_KEYS);
                stmCardapio.setInt(1, cardapioVenda.getIdVenda());
                stmCardapio.setInt(2, cardapioVenda.getIdCardapio());
                stmCardapio.execute();
                rs = stmCardapio.getGeneratedKeys();
                Integer idCardapioVenda = 0;
                if (rs.next()) {
                    idCardapioVenda = rs.getInt(1);
                }
                String sqlItem = "insert into item_venda (qtdeVenda, valorVenda, idCardapioVenda, "
                               + "idPrato) values (?, ?, ?, ?)";
                for (ItemVenda item : cardapioVenda.getItens()) {
                    item.setIdCardapioVenda(idCardapioVenda);
                    PreparedStatement stmItem = con.prepareStatement(sqlItem);
                    stmItem.setInt(1, item.getQtdeVenda());
                    stmItem.setFloat(2, item.getValorVenda());
                    stmItem.setInt(3, idCardapioVenda);
                    stmItem.setInt(4, item.getPrato().getIdPrato());
                    stmItem.execute();
                    for (Ingrediente ingrediente : item.getPrato().getIngredientes()) {
                        Produto.atualizarSaldoEstoque(ingrediente.getIdproduto());
                    }
                }
            }
            con.commit(); //confirma que não houve erro e executa a gravação de todos os dados no banco
        } catch (SQLException ex) {
            con.rollback(); //desfaz o que foi feito parcialmente
            throw new Exception(ex.getMessage());
        } finally {
            con.setAutoCommit(true);
        }
    }
    
    public void editar()throws Exception {
        Connection con = Conexao.getInstance();
        //não permite gravar a compra sem os itensCardapioVenda da compra
        //desabilita a conexão para a gravação da compra sem os itensCardapioVenda da compra
        //garante que desfaz a gravação de item e/ou compra no caso de algum erro no processo de gravação
        con.setAutoCommit(false);
        String sql = "update venda set idCliente = ?, dataOrcamento = ?, "
                + "dataPedido = ?, dataProducao = ?, producao = ? where idVenda = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, cliente.getIdCliente());
            stm.setObject(2, this.dataOrcamento);
            stm.setObject(3, this.dataPedido);
            stm.setObject(4, this.dataProducao);
            stm.setBoolean(5, this.producao);
            stm.setInt(6, this.idVenda);
            stm.execute();
            String sqlItem = "delete from item_venda where idCardapioVenda in "
                        + "(select idCardapioVenda from cardapio_venda where idVenda = ?)";
            PreparedStatement stmItem = con.prepareStatement(sqlItem);
            stmItem.setInt(1, this.idVenda);
            stmItem.execute();
            String sqlCardapio = "update cardapio_venda set idVenda = ?, idCardapio = ? "
                               + "where idCardapioVenda = ?";
            for (CardapioVenda cardapioVenda : itensCardapioVenda) {
                cardapioVenda.setIdVenda(idVenda);
                PreparedStatement stmCardapio = con.prepareStatement(sqlCardapio);
                stmCardapio.setInt(1, cardapioVenda.getIdVenda());
                stmCardapio.setInt(2, cardapioVenda.getIdCardapio());
                stmCardapio.setInt(3, cardapioVenda.getIdCardapioVenda());
                stmCardapio.execute();
                sqlItem = "insert into item_venda (qtdeVenda, valorVenda, idCardapioVenda, "
                        + "idPrato) values (?, ?, ?, ?)";
                    for (ItemVenda item : cardapioVenda.getItens()) {
                        item.setIdCardapioVenda(cardapioVenda.getIdCardapioVenda());
                        stmItem = con.prepareStatement(sqlItem);
                        stmItem.setInt(1, item.getQtdeVenda());
                        stmItem.setFloat(2, item.getValorVenda());
                        stmItem.setInt(3, cardapioVenda.getIdCardapioVenda());
                        stmItem.setInt(4, item.getPrato().getIdPrato());
                        stmItem.execute();
                        for (Ingrediente ingrediente : item.getPrato().getIngredientes()) {
                            Produto.atualizarSaldoEstoque(ingrediente.getIdproduto());
                        }
                    }
                }
            con.commit(); //confirma que não houve erro e executa a gravação de todos os dados no banco
        } catch (SQLException ex) {
            con.rollback(); //desfaz o que foi feito parcialmente
            throw new Exception(ex.getMessage());
        } finally {
            con.setAutoCommit(true);
        }
    }
    
    public void excluir() throws Exception {
        Connection con = Conexao.getInstance();
        con.setAutoCommit(false);
        String sqlItem = "delete from item_venda where idCardapioVenda in "
                + "(select idCardapioVenda from cardapio_venda where idVenda = ?)";
        String sqlCardapio = "delete from cardapio_venda where idVenda = ?";
        String sql = "delete from venda where idVenda = ?";
        try {
            PreparedStatement stmItem = con.prepareStatement(sqlItem);
            stmItem.setInt(1, this.idVenda);
            stmItem.execute();
            PreparedStatement stmCardapio = con.prepareStatement(sqlCardapio);
            stmCardapio.setInt(1, this.idVenda);
            stmCardapio.execute();
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, this.idVenda);
            stm.execute();
            con.commit();
        } catch (SQLException ex) {
            con.rollback();
            throw new Exception(ex.getMessage());
        } finally {
            con.setAutoCommit(true);
        }
    }
    
    public void adicionarCardapio(CardapioVenda cardapio) {
        itensCardapioVenda.add(cardapio);
    }

    public static Venda consultar(int idVenda) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from venda where idVenda = ?";
        String sqlCardapio = "select * from cardapio_venda where idVenda = ?";
        String sqlItem = "select * from item_venda where idCardapioVenda = ?";
        Venda venda = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idVenda);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                venda = new Venda();
                venda.setIdVenda(idVenda);
                venda.setCliente(Cliente.consultar(rs.getInt("idCliente")));
                venda.setDataOrcamento(rs.getObject("dataOrcamento", LocalDate.class));
                venda.setDataPedido(rs.getObject("dataPedido", LocalDate.class));
                venda.setDataProducao(rs.getObject("dataProducao", LocalDate.class));
                venda.setProducao(rs.getBoolean("producao"));
                PreparedStatement stmCardapio = con.prepareStatement(sqlCardapio);
                stmCardapio.setInt(1, idVenda);
                ResultSet rsCardapio = stmCardapio.executeQuery();
                while(rsCardapio.next()) {
                    CardapioVenda cardapioVenda = new CardapioVenda();
                    cardapioVenda.setIdVenda(idVenda);
                    cardapioVenda.setIdCardapioVenda(rsCardapio.getInt("idCardapioVenda"));
                    cardapioVenda.setIdCardapio(rsCardapio.getInt("idCardapio"));
                    venda.adicionarCardapio(cardapioVenda);
                    PreparedStatement stmItem = con.prepareStatement (sqlItem);
                    stmItem.setInt(1, cardapioVenda.getIdCardapioVenda());
                    ResultSet rsItem = stmItem.executeQuery();
                    while (rsItem.next()) {
                        ItemVenda item = new ItemVenda();
                        item.setIdCardapioVenda(cardapioVenda.getIdCardapioVenda());
                        item.setIdItemVenda(rsItem.getInt("idItemVenda"));
                        item.setPrato(Prato.consultar(rsItem.getInt("idPrato")));
                        item.setQtdeVenda(rsItem.getInt("qtdeVenda"));
                        item.setValorVenda(rsItem.getFloat("valorVenda"));
                        cardapioVenda.adicionarItem(item);
                    }
                }
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return venda;
    }

    public static List<Venda> consultar() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from venda";
        String sqlCardapio = "select * from cardapio_venda where idvenda = ?";
        String sqlItem = "select * from item_venda where idcardapiovenda = ?";
        List<Venda> listaVenda = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Venda venda = new Venda();
                venda.setIdVenda(Integer.parseInt(rs.getString("idVenda")));
                venda.setCliente(Cliente.consultar(rs.getInt("idCliente")));
                venda.setDataOrcamento(rs.getObject("dataOrcamento", LocalDate.class));
                venda.setDataPedido(rs.getObject("dataPedido", LocalDate.class));
                venda.setDataProducao(rs.getObject("dataProducao", LocalDate.class));
                venda.setProducao(rs.getBoolean("producao"));
                listaVenda.add(venda);
                PreparedStatement stmCardapio = con.prepareStatement(sqlCardapio);
                stmCardapio.setInt(1, venda.getIdVenda());
                ResultSet rsCardapio = stmCardapio.executeQuery();
                while(rsCardapio.next()) {
                    CardapioVenda cardapioVenda = new CardapioVenda();
                    cardapioVenda.setIdVenda(rsCardapio.getInt("idvenda"));
                    cardapioVenda.setIdCardapioVenda(rsCardapio.getInt("idcardapiovenda"));
                    cardapioVenda.setIdCardapio(rsCardapio.getInt("idcardapio"));
                    venda.adicionarCardapio(cardapioVenda);
                    PreparedStatement stmItem = con.prepareStatement(sqlItem);
                    stmItem.setInt(1, cardapioVenda.getIdCardapioVenda());
                    ResultSet rsItem = stmItem.executeQuery();
                    while(rsItem.next()) {
                        ItemVenda item = new ItemVenda();
                        item.setIdCardapioVenda(cardapioVenda.getIdCardapioVenda());
                        item.setIdItemVenda(rsItem.getInt("idItemVenda"));
                        item.setPrato(Prato.consultar(rsItem.getInt("idprato")));
                        item.setQtdeVenda(rsItem.getInt("qtdevenda"));
                        item.setValorVenda(rsItem.getInt("valorvenda"));
                        cardapioVenda.adicionarItem(item);
                    }
                }
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaVenda;
    }

    public static List<Venda> consultarCliente(String nome) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from venda ven, cliente cli where ven.idcliente=cli.idcliente and cli.nome like ?";
        String sqlCardapio = "select * from cardapio_venda where idvenda = ?";
        String sqlItem = "select * from item_venda where idcardapiovenda = ?";
        List<Venda> listaVenda = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, "%" + nome + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Venda venda = new Venda();
                venda.setIdVenda(Integer.parseInt(rs.getString("idVenda")));
                venda.setCliente(Cliente.consultar(rs.getInt("idCliente")));
                venda.setDataOrcamento(rs.getObject("dataOrcamento", LocalDate.class));
                venda.setDataPedido(rs.getObject("dataPedido", LocalDate.class));
                venda.setDataProducao(rs.getObject("dataProducao", LocalDate.class));
                venda.setProducao(rs.getBoolean("producao"));
                listaVenda.add(venda);
                PreparedStatement stmCardapio = con.prepareStatement(sqlCardapio);
                stmCardapio.setInt(1, venda.getIdVenda());
                ResultSet rsCardapio = stmCardapio.executeQuery();
                while(rsCardapio.next()) {
                    CardapioVenda cardapioVenda = new CardapioVenda();
                    cardapioVenda.setIdVenda(rsCardapio.getInt("idvenda"));
                    cardapioVenda.setIdCardapioVenda(rsCardapio.getInt("idcardapiovenda"));
                    cardapioVenda.setIdCardapio(rsCardapio.getInt("idcardapio"));
                    venda.adicionarCardapio(cardapioVenda);
                    PreparedStatement stmItem = con.prepareStatement(sqlItem);
                    stmItem.setInt(1, cardapioVenda.getIdCardapioVenda());
                    ResultSet rsItem = stmItem.executeQuery();
                    while(rsItem.next()) {
                        ItemVenda item = new ItemVenda();
                        item.setIdCardapioVenda(cardapioVenda.getIdCardapioVenda());
                        item.setIdItemVenda(rsItem.getInt("idItemVenda"));
                        item.setPrato(Prato.consultar(rsItem.getInt("idprato")));
                        item.setQtdeVenda(rsItem.getInt("qtdevenda"));
                        item.setValorVenda(rsItem.getInt("valorvenda"));
                        cardapioVenda.adicionarItem(item);
                    }
                } 
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaVenda;
    }

    public static List<Venda> consultarCardapio(String cardapio) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from venda ven, cardapio menu where "
                + "ven.idcardapio=menu.idcarpadio and menu.desccardapio like ?";
        String sqlCardapio = "select * from cardapio_venda where idvenda = ?";
        String sqlItem = "select * from item_venda where idcardapiovenda = ?";
        List<Venda> listaVenda = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, cardapio + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Venda venda = new Venda();
                venda.setIdVenda(Integer.parseInt(rs.getString("idVenda")));
                venda.setCliente(Cliente.consultar(rs.getInt("idCliente")));
                venda.setDataOrcamento(rs.getObject("dataOrcamento", LocalDate.class));
                venda.setDataPedido(rs.getObject("dataPedido", LocalDate.class));
                venda.setDataProducao(rs.getObject("dataProducao", LocalDate.class));
                venda.setProducao(rs.getBoolean("producao"));
                listaVenda.add(venda);
                PreparedStatement stmCardapio = con.prepareStatement(sqlCardapio);
                stmCardapio.setInt(1, venda.getIdVenda());
                ResultSet rsCardapio = stmCardapio.executeQuery();
                while(rsCardapio.next()) {
                    CardapioVenda cardapioVenda = new CardapioVenda();
                    cardapioVenda.setIdVenda(rsCardapio.getInt("idvenda"));
                    cardapioVenda.setIdCardapioVenda(rsCardapio.getInt("idcardapiovenda"));
                    cardapioVenda.setIdCardapio(rsCardapio.getInt("idcardapio"));
                    venda.adicionarCardapio(cardapioVenda);
                    PreparedStatement stmItem = con.prepareStatement(sqlItem);
                    stmItem.setInt(1, cardapioVenda.getIdCardapioVenda());
                    ResultSet rsItem = stmItem.executeQuery();
                    while(rsItem.next()) {
                        ItemVenda item = new ItemVenda();
                        item.setIdCardapioVenda(cardapioVenda.getIdCardapioVenda());
                        item.setIdItemVenda(rsItem.getInt("idItemVenda"));
                        item.setPrato(Prato.consultar(rsItem.getInt("idprato")));
                        item.setQtdeVenda(rsItem.getInt("qtdevenda"));
                        item.setValorVenda(rsItem.getInt("valorvenda"));
                        cardapioVenda.adicionarItem(item);
                    }
                }
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaVenda;
    }

    public static List<Venda> consultarPrato(String prato) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from venda ven, item_venda itemv, prato pr where "
                + "ven.idvenda=itemv.idvenda and itemv.idprato=pr.idprato and "
                + "pr.nome like ?";
        String sqlCardapio = "select * from cardapio_venda where idvenda = ?";
        String sqlItem = "select * from item_venda where idcardapiovenda = ?";
        List<Venda> listaVenda = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, prato + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Venda venda = new Venda();
                venda.setIdVenda(Integer.parseInt(rs.getString("idVenda")));
                venda.setCliente(Cliente.consultar(rs.getInt("idCliente")));
                venda.setDataOrcamento(rs.getObject("dataOrcamento", LocalDate.class));
                venda.setDataPedido(rs.getObject("dataPedido", LocalDate.class));
                venda.setDataProducao(rs.getObject("dataProducao", LocalDate.class));
                venda.setProducao(rs.getBoolean("producao"));
                listaVenda.add(venda);
                PreparedStatement stmCardapio = con.prepareStatement(sqlCardapio);
                stmCardapio.setInt(1, venda.getIdVenda());
                ResultSet rsCardapio = stmCardapio.executeQuery();
                while(rsCardapio.next()) {
                    CardapioVenda cardapioVenda = new CardapioVenda();
                    cardapioVenda.setIdVenda(rsCardapio.getInt("idvenda"));
                    cardapioVenda.setIdCardapioVenda(rsCardapio.getInt("idcardapiovenda"));
                    cardapioVenda.setIdCardapio(rsCardapio.getInt("idcardapio"));
                    venda.adicionarCardapio(cardapioVenda);
                    PreparedStatement stmItem = con.prepareStatement(sqlItem);
                    stmItem.setInt(1, cardapioVenda.getIdCardapioVenda());
                    ResultSet rsItem = stmItem.executeQuery();
                    while(rsItem.next()) {
                        ItemVenda item = new ItemVenda();
                        item.setIdCardapioVenda(cardapioVenda.getIdCardapioVenda());
                        item.setIdItemVenda(rsItem.getInt("idItemVenda"));
                        item.setPrato(Prato.consultar(rsItem.getInt("idprato")));
                        item.setQtdeVenda(rsItem.getInt("qtdevenda"));
                        item.setValorVenda(rsItem.getInt("valorvenda"));
                        cardapioVenda.adicionarItem(item);
                    }
                }
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaVenda;
    }

    public static List<Venda> consultarProduzir(Boolean producao) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from venda where producao = ?";
        String sqlCardapio = "select * from cardapio_venda where idvenda = ?";
        String sqlItem = "select * from item_venda where idcardapiovenda = ?";
        List<Venda> listaVenda = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setBoolean(1, producao);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Venda venda = new Venda();
                venda.setIdVenda(Integer.parseInt(rs.getString("idVenda")));
                venda.setCliente(Cliente.consultar(rs.getInt("idCliente")));
                venda.setDataOrcamento(rs.getObject("dataOrcamento", LocalDate.class));
                venda.setDataPedido(rs.getObject("dataPedido", LocalDate.class));
                venda.setDataProducao(rs.getObject("dataProducao", LocalDate.class));
                venda.setProducao(rs.getBoolean("producao"));
                listaVenda.add(venda);
                PreparedStatement stmCardapio = con.prepareStatement(sqlCardapio);
                stmCardapio.setInt(1, venda.getIdVenda());
                ResultSet rsCardapio = stmCardapio.executeQuery();
                while(rsCardapio.next()) {
                    CardapioVenda cardapioVenda = new CardapioVenda();
                    cardapioVenda.setIdVenda(rsCardapio.getInt("idvenda"));
                    cardapioVenda.setIdCardapioVenda(rsCardapio.getInt("idcardapiovenda"));
                    cardapioVenda.setIdCardapio(rsCardapio.getInt("idcardapio"));
                    venda.adicionarCardapio(cardapioVenda);
                    PreparedStatement stmItem = con.prepareStatement(sqlItem);
                    stmItem.setInt(1, cardapioVenda.getIdCardapioVenda());
                    ResultSet rsItem = stmItem.executeQuery();
                    while(rsItem.next()) {
                        ItemVenda item = new ItemVenda();
                        item.setIdCardapioVenda(cardapioVenda.getIdCardapioVenda());
                        item.setIdItemVenda(rsItem.getInt("idItemVenda"));
                        item.setPrato(Prato.consultar(rsItem.getInt("idprato")));
                        item.setQtdeVenda(rsItem.getInt("qtdevenda"));
                        item.setValorVenda(rsItem.getInt("valorvenda"));
                        cardapioVenda.adicionarItem(item);
                    }
                }
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaVenda;
    }

    public int getIdVenda() {
        return idVenda;
    }

    public void setIdVenda(int idVenda) {
        this.idVenda = idVenda;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Cardapio getCardapio() {
        return cardapio;
    }

    public void setCardapio(Cardapio cardapio) {
        this.cardapio = cardapio;
    }

    public LocalDate getDataOrcamento() {
        return dataOrcamento;
    }

    public void setDataOrcamento(LocalDate dataOrcamento) {
        this.dataOrcamento = dataOrcamento;
    }

    public LocalDate getDataPedido() {
        return dataPedido;
    }

    public void setDataPedido(LocalDate dataPedido) {
        this.dataPedido = dataPedido;
    }

    public LocalDate getDataProducao() {
        return dataProducao;
    }

    public void setDataProducao(LocalDate dataProducao) {
        this.dataProducao = dataProducao;
    }

    public boolean isProducao() {
        return producao;
    }

    public void setProducao(boolean producao) {
        this.producao = producao;
    }

    public List<CardapioVenda> getItensCardapioVenda() {
        return itensCardapioVenda;
    }

    public void setItensCardapioVenda(List<CardapioVenda> itensCardapioVenda) {
        this.itensCardapioVenda = itensCardapioVenda;
    }

}