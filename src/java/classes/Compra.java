/*
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
public class Compra {

    private int idCompra;
    private Fornecedor fornecedor;
    private LocalDate dataCotacao;
    private LocalDate dataCompra;
    private LocalDate dataEntrada;
    private float qtdecompra;
    private String unmedida;
    private float valorcompra;
    private Compra compra;
    private Produto produto;
    
    private List<ItemCompra> itens = new ArrayList<>();

    public void salvar() throws Exception {
        Connection con = Conexao.getInstance();
        //não permite gravar a compra sem os itens da compra
        //desabilita a conexão para a gravação da compra sem os itens da compra
        //garante que desfaz a gravação de item e/ou compra no caso de algum erro no processo de gravação
        con.setAutoCommit(false);
        String sql = "insert into compra (idFornecedor, dataCotacao, dataCompra, "
                   + "dataEntrada) values(?, ?, ?, ?)";
        String sqlItem = "insert into item_compra (qtdecompra, unmedida, "
                       + "valorcompra, idcompra, idproduto) values (?, ?, ?, ?, ?)";
        try {
            PreparedStatement stm = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stm.setInt(1, fornecedor.getIdFornecedor());
            stm.setObject(2, this.dataCotacao);
            stm.setObject(3, this.dataCompra);
            stm.setObject(4, this.dataEntrada);
            stm.execute();
            ResultSet rs = stm.getGeneratedKeys(); //recupera o serial gerado no idcompra
            Integer idCompra = 0;
            if (rs.next()) { //confere se tem retorno em idcompra
                idCompra = rs.getInt(1); //grava o 1º valor retornado
            }
            for (ItemCompra item : itens) {
                item.setIdCompra(idCompra);
                PreparedStatement stmItem = con.prepareStatement(sqlItem);
                stmItem.setFloat(1, item.getQtdeCompra());
                stmItem.setString(2, item.getUnMedida());
                stmItem.setFloat(3, item.getValorCompra());
                stmItem.setInt(4, item.getIdCompra());
                stmItem.setInt(5, item.getIdProduto());
                stmItem.execute();
                Produto.atualizarSaldoEstoque(item.getIdProduto());
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
        //não permite gravar a compra sem os itens da compra
        //desabilita a conexão para a gravação da compra sem os itens da compra
        //garante que desfaz a gravação de item e/ou compra no caso de algum erro no processo de gravação
        con.setAutoCommit(false);
        String sql = "update compra set idFornecedor = ?, dataCotacao = ?, "
                   + "dataCompra = ?, dataEntrada = ? where idCompra = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, fornecedor.getIdFornecedor());
            stm.setObject(2, this.dataCotacao);
            stm.setObject(3, this.dataCompra);
            stm.setObject(4, this.dataEntrada);
            stm.setInt(5, this.idCompra);
            stm.execute();

            String sqlItem = "delete from item_compra where idCompra = ?";
            PreparedStatement stmItem = con.prepareStatement(sqlItem);
            stmItem.setInt(1, this.idCompra);
            stmItem.execute();
            sqlItem = "insert into item_compra (qtdecompra, unmedida, "
                    + "valorcompra, idcompra, idproduto) values (?, ?, ?, ?, ?)";
            for (ItemCompra item : itens) {
                item.setIdCompra(this.idCompra);
                stmItem = con.prepareStatement(sqlItem);
                stmItem.setFloat(1, item.getQtdeCompra());
                stmItem.setString(2, item.getUnMedida());
                stmItem.setFloat(3, item.getValorCompra());
                stmItem.setInt(4, item.getIdCompra());
                stmItem.setInt(5, item.getIdProduto());
                stmItem.execute();
                Produto.atualizarSaldoEstoque(item.getIdProduto());
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
        String sqlItem = "delete from item_compra where idCompra = ?";
        String sql = "delete from compra where idCompra = ?";
        try {
            PreparedStatement stmItem = con.prepareStatement(sqlItem);
            stmItem.setInt(1, this.idCompra);
            stmItem.execute();
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, this.idCompra);
            stm.execute();
            con.commit();
        } catch (SQLException ex) {
            con.rollback();
            throw new Exception(ex.getMessage());
        } finally {
            con.setAutoCommit(true);
        }
    }
    
    public void adicionarItem(ItemCompra item) {
        itens.add(item);
    }
    
    public Float getValorTotal() {
        float valorTotal = 0;
        for (ItemCompra item : this.itens) {
            valorTotal += item.getValorCompra();
        }
        return valorTotal;
    }
    
    public static Compra consultar(int idCompra) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from compra where idCompra = ?";
        String sqlItem = "select * from item_compra where idcompra = ?";
        Compra compra = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idCompra);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                compra = new Compra();
                compra.setIdCompra(idCompra);
                compra.setFornecedor(Fornecedor.consultar(rs.getInt("idFornecedor")));
                compra.setDataCotacao(rs.getObject("dataCotacao", LocalDate.class));
                compra.setDataCompra(rs.getObject("dataCompra", LocalDate.class));
                compra.setDataEntrada(rs.getObject("dataEntrada", LocalDate.class));

                PreparedStatement stmItem = con.prepareStatement(sqlItem);
                stmItem.setInt(1, idCompra);
                ResultSet rsItem = stmItem.executeQuery();
                while (rsItem.next()) {
                    ItemCompra item = new ItemCompra();
                    item.setIdCompra(idCompra);
                    item.setIdItemCompra(rsItem.getInt("idItemCompra"));
                    item.setIdProduto(rsItem.getInt("idproduto"));
                    item.setQtdeCompra(rsItem.getFloat("qtdecompra"));
                    item.setUnMedida(rsItem.getString("unmedida"));
                    item.setValorCompra(rsItem.getFloat("valorcompra"));
                    compra.adicionarItem(item);
                }
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return compra;
    }

    public static List<Compra> consultar() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from compra";
        String sqlItem = "select * from item_compra where idcompra = ?";
        List<Compra> listaCompra = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Compra compra = new Compra();
                compra.setIdCompra(Integer.parseInt(rs.getString("idCompra")));
                compra.setFornecedor(Fornecedor.consultar(rs.getInt("idFornecedor")));
                compra.setDataCotacao(rs.getObject("dataCotacao", LocalDate.class));
                compra.setDataCompra(rs.getObject("dataCompra", LocalDate.class));
                compra.setDataEntrada(rs.getObject("dataEntrada", LocalDate.class));
                listaCompra.add(compra);
                
                PreparedStatement stmItem = con.prepareStatement(sqlItem);
                stmItem.setInt(1, compra.getIdCompra());
                ResultSet rsItem = stmItem.executeQuery();
                while(rsItem.next()) {
                    ItemCompra item = new ItemCompra();
                    item.setIdCompra(rsItem.getInt("idcompra"));
                    item.setIdItemCompra(rsItem.getInt("idItemCompra"));
                    item.setIdProduto(rsItem.getInt("idproduto"));
                    item.setQtdeCompra(rsItem.getFloat("qtdecompra"));
                    item.setUnMedida(rsItem.getString("unmedida"));
                    item.setValorCompra(rsItem.getFloat("valorcompra"));
                    compra.adicionarItem(item);
                }
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaCompra;
    }

    public static List<Compra> consultarFornecedor(String nome) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from compra comp, fornecedor fornec where "
                   + "comp.idfornecedor=fornec.idfornecedor and fornec.nome like ?";
        String sqlItem = "select * from item_compra where idcompra = ?";
        List<Compra> listaCompra = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, nome + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Compra compra = new Compra();
                compra.setIdCompra(Integer.parseInt(rs.getString("idCompra")));
                compra.setFornecedor(Fornecedor.consultar(rs.getInt("idFornecedor")));
                compra.setDataCotacao(rs.getObject("dataCotacao", LocalDate.class));
                compra.setDataCompra(rs.getObject("dataCompra", LocalDate.class));
                compra.setDataEntrada(rs.getObject("dataEntrada", LocalDate.class));
                listaCompra.add(compra);
                
                PreparedStatement stmItem = con.prepareStatement(sqlItem);
                stmItem.setInt(1, compra.getIdCompra());
                ResultSet rsItem = stmItem.executeQuery();
                while(rsItem.next()) {
                    ItemCompra item = new ItemCompra();
                    item.setIdCompra(rsItem.getInt("idcompra"));
                    item.setIdItemCompra(rsItem.getInt("idItemCompra"));
                    item.setIdProduto(rsItem.getInt("idproduto"));
                    item.setQtdeCompra(rsItem.getFloat("qtdecompra"));
                    item.setUnMedida(rsItem.getString("unmedida"));
                    item.setValorCompra(rsItem.getFloat("valorcompra"));
                    compra.adicionarItem(item);
                }
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaCompra;
    }

    public static List<Compra> consultarProduto(String produto) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from compra comp, item_compra item, produto prod where "
                   + "comp.idcompra=item.idcompra and item.idproduto=prod.idproduto and "
                   + "prod.descricaoproduto like ?";
        String sqlItem = "select * from item_compra where idcompra = ?";
        List<Compra> listaCompra = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, produto + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Compra compra = new Compra();
                compra.setIdCompra(Integer.parseInt(rs.getString("idCompra")));
                compra.setFornecedor(Fornecedor.consultar(rs.getInt("idFornecedor")));
                compra.setDataCotacao(rs.getObject("dataCotacao", LocalDate.class));
                compra.setDataCompra(rs.getObject("dataCompra", LocalDate.class));
                compra.setDataEntrada(rs.getObject("dataEntrada", LocalDate.class));
                listaCompra.add(compra);
                
                PreparedStatement stmItem = con.prepareStatement(sqlItem);
                stmItem.setInt(1, compra.getIdCompra());
                ResultSet rsItem = stmItem.executeQuery();
                while(rsItem.next()) {
                    ItemCompra item = new ItemCompra();
                    item.setIdCompra(rsItem.getInt("idcompra"));
                    item.setIdItemCompra(rsItem.getInt("idItemCompra"));
                    item.setIdProduto(rsItem.getInt("idproduto"));
                    item.setQtdeCompra(rsItem.getFloat("qtdecompra"));
                    item.setUnMedida(rsItem.getString("unmedida"));
                    item.setValorCompra(rsItem.getFloat("valorcompra"));
                    compra.adicionarItem(item);
                }
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaCompra;
    }

    public int getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }

    public Fornecedor getFornecedor() {
        return fornecedor;
    }

    public void setFornecedor(Fornecedor fornecedor) {
        this.fornecedor = fornecedor;
    }

    public LocalDate getDataCotacao() {
        return dataCotacao;
    }

    public void setDataCotacao(LocalDate dataCotacao) {
        this.dataCotacao = dataCotacao;
    }

    public LocalDate getDataCompra() {
        return dataCompra;
    }

    public void setDataCompra(LocalDate dataCompra) {
        this.dataCompra = dataCompra;
    }

    public LocalDate getDataEntrada() {
        return dataEntrada;
    }

    public void setDataEntrada(LocalDate dataEntrada) {
        this.dataEntrada = dataEntrada;
    }

    public float getQtdecompra() {
        return qtdecompra;
    }

    public void setQtdecompra(float qtdecompra) {
        this.qtdecompra = qtdecompra;
    }

    public String getUnmedida() {
        return unmedida;
    }

    public void setUnmedida(String unmedida) {
        this.unmedida = unmedida;
    }

    public float getValorcompra() {
        return valorcompra;
    }

    public void setValorcompra(float valorcompra) {
        this.valorcompra = valorcompra;
    }

    public Compra getCompra() {
        return compra;
    }

    public void setCompra(Compra compra) {
        this.compra = compra;
    }

    public Produto getProduto() {
        return produto;
    }

    public void setProduto(Produto produto) {
        this.produto = produto;
    }

    public List<ItemCompra> getItens() {
        return itens;
    }

    public void setItens(List<ItemCompra> itens) {
        this.itens = itens;
    }

}
