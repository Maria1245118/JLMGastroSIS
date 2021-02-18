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
import java.util.ArrayList;
import java.util.List;
import utils.Conexao;

/**
 *
 * @author Janine
 */
public class Cardapio {
    
    private int idCardapio;
    private String descCardapio;
    private Integer qtdePessoas;
    private float valorUnitario;
    private float valorTotal;
    private boolean buffetInterno;
    
    private List<PratoCardapio> pratos = new ArrayList<>();

    public void salvar() throws Exception {
        Connection con = Conexao.getInstance();
        //não permite gravar a compra sem os itens da compra
        //desabilita a conexão para a gravação da compra sem os itens da compra
        //garante que desfaz a gravação de item e/ou compra no caso de algum erro no processo de gravação
        con.setAutoCommit(false);
        String sql = "insert into cardapio (valorUnitario, valorTotal, qtdePessoas, "
                + "buffetInterno, descCardapio) values (?, ?, ?, ?, ?)";
        String sqlItem = "insert into prato_cardapio (idprato, idcardapio) "
                   + "values (?, ?)";
        try {
            PreparedStatement stm = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stm.setFloat(1, this.getValorUnitario());
            stm.setFloat(2, this.valorTotal);
            stm.setInt(3, this.qtdePessoas);
            stm.setBoolean(4, this.buffetInterno);
            stm.setString(5, this.descCardapio);
            stm.execute();
            ResultSet rs = stm.getGeneratedKeys(); //recupera o serial gerado no idcardapio
            Integer idCardapio = 0;
            if (rs.next()) { //confere se tem retorno em idcardapio
                idCardapio = rs.getInt(1); //grava o 1º valor retornado
            }
            for (PratoCardapio item : pratos) {
                item.setIdCardapio(idCardapio);
                PreparedStatement stmPrato = con.prepareStatement(sqlItem);
                stmPrato.setInt(1, item.getIdPrato());
                stmPrato.setInt(2, item.getIdCardapio());
                stmPrato.execute();
            }
            con.commit();
        } catch (SQLException ex) {
            con.rollback();
            throw new Exception(ex.getMessage());
        } finally {
            con.setAutoCommit(true);
        }
    }
    
    public void editar()throws Exception {
        Connection con = Conexao.getInstance();
        con.setAutoCommit(false);
        String sql = "update cardapio set valorUnitario = ?, valorTotal = ?, "
                + "qtdePessoas = ?, buffetInterno = ?, descCardapio = ? where idCardapio = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setFloat(1, this.getValorUnitario());
            stm.setFloat(2, this.valorTotal);
            stm.setInt(3, this.qtdePessoas);
            stm.setBoolean(4, this.buffetInterno);
            stm.setString(5, this.descCardapio);
            stm.setInt(6, this.idCardapio);
            stm.execute();
            
            String sqlItem = "delete from prato_cardapio where idCardapio = ?";
            PreparedStatement stmItem = con.prepareStatement(sqlItem);
            stmItem.setInt(1, this.idCardapio);
            stmItem.execute();
            sqlItem = "insert into prato_cardapio (idprato, idcardapio) values (?, ?)";
            for (PratoCardapio item : pratos) {
                item.setIdCardapio(this.idCardapio);
                stmItem = con.prepareStatement(sqlItem);
                stmItem.setInt(1, item.getIdPrato());
                stmItem.setInt(2, item.getIdCardapio());
                stmItem.execute();
            }
            con.commit();
        } catch (SQLException ex) {
            con.rollback();
            throw new Exception(ex.getMessage());
        } finally {
            con.setAutoCommit(true);
        }
    }
    
    public void excluir() throws Exception {
        Connection con = Conexao.getInstance();
        con.setAutoCommit(false);
        String sqlItem = "delete from prato_cardapio where idCardapio = ?";
        String sql = "delete from cardapio where idCardapio = ?";
        try {
            PreparedStatement stmItem = con.prepareStatement(sqlItem);
            stmItem.setInt(1, this.idCardapio);
            stmItem.execute();
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, this.idCardapio);
            stm.execute();
            con.commit();
        } catch (SQLException ex) {
            con.rollback();
            throw new Exception(ex.getMessage());
        } finally {
            con.setAutoCommit(true);
        }
    }
    
    public void adicionarPrato(PratoCardapio item) {
        pratos.add(item);
    }
    
    public Float getVTotal() throws Exception {
        float vTotal = 0;
        for (PratoCardapio prmenu : this.pratos) {
            Prato prato = Prato.consultar(prmenu.getIdPrato());
            vTotal += prato.getValorPrato();
        }
        return vTotal;
    }
    
    public static Cardapio consultar(int idCardapio) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from cardapio where idCardapio = ?";
        String sqlItem = "select * from prato_cardapio where idcardapio = ?";
        Cardapio cardapio = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idCardapio);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                cardapio = new Cardapio();
                cardapio.setIdCardapio(idCardapio);
                cardapio.setDescCardapio(rs.getString("desccardapio"));
                cardapio.setQtdePessoas(Integer.parseInt(rs.getString("qtdePessoas")));
                cardapio.setValorUnitario(Float.parseFloat(rs.getString("valorUnitario")));
                cardapio.setValorTotal(Float.parseFloat(rs.getString("valorTotal")));
                cardapio.setBuffetInterno(rs.getBoolean("buffetInterno"));
                
                PreparedStatement stmItem = con.prepareStatement(sqlItem);
                stmItem.setInt(1, idCardapio);
                ResultSet rsItem = stmItem.executeQuery();
                while (rsItem.next()) {
                    PratoCardapio item = new PratoCardapio();
                    item.setIdCardapio(idCardapio);
                    item.setIdPrato(rsItem.getInt("idprato"));
                    cardapio.adicionarPrato(item);
                }
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return cardapio;
    }

    public static List<Cardapio> consultar() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from cardapio";
        String sqlItem = "select * from prato_cardapio where idcardapio = ?";
        List<Cardapio> listaCardapio = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Cardapio cardapio = new Cardapio();
                cardapio.setIdCardapio(Integer.parseInt(rs.getString("idCardapio")));
                cardapio.setDescCardapio(rs.getString("desccardapio"));
                cardapio.setQtdePessoas(Integer.parseInt(rs.getString("qtdePessoas")));
                cardapio.setValorUnitario(Float.parseFloat(rs.getString("valorUnitario")));
                cardapio.setValorTotal(Float.parseFloat(rs.getString("valorTotal")));
                cardapio.setBuffetInterno(rs.getBoolean("buffetInterno"));
                listaCardapio.add(cardapio);
                
                PreparedStatement stmItem = con.prepareStatement(sqlItem);
                stmItem.setInt(1, cardapio.getIdCardapio());
                ResultSet rsItem = stmItem.executeQuery();
                while (rsItem.next()) {
                    PratoCardapio item = new PratoCardapio();
                    item.setIdCardapio(rsItem.getInt("idcardapio"));
                    item.setIdPrato(rsItem.getInt("idprato"));
                    cardapio.adicionarPrato(item);
                }
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaCardapio;
    }

    public static List<Cardapio> consultarCardapio(String nome) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from cardapio where desccardapio like ?";
        String sqlItem = "select * from prato_cardapio where idcardapio = ?";
        List<Cardapio> listaCardapio = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, nome + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Cardapio cardapio = new Cardapio();
                cardapio.setIdCardapio(Integer.parseInt(rs.getString("idCardapio")));
                cardapio.setDescCardapio(rs.getString("desccardapio"));
                cardapio.setQtdePessoas(Integer.parseInt(rs.getString("qtdePessoas")));
                cardapio.setValorUnitario(Float.parseFloat(rs.getString("valorUnitario")));
                cardapio.setValorTotal(Float.parseFloat(rs.getString("valorTotal")));
                cardapio.setBuffetInterno(rs.getBoolean("buffetInterno"));
                listaCardapio.add(cardapio);
                
                PreparedStatement stmItem = con.prepareStatement(sqlItem);
                stmItem.setInt(1, cardapio.getIdCardapio());
                ResultSet rsItem = stmItem.executeQuery();
                while (rsItem.next()) {
                    PratoCardapio item = new PratoCardapio();
                    item.setIdCardapio(rsItem.getInt("idcardapio"));
                    item.setIdPrato(rsItem.getInt("idprato"));
                    cardapio.adicionarPrato(item);
                }
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaCardapio;
    }

    public static List<Cardapio> consultarPrato(String nome) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from cardapio menu, prato pr, prato_cardapio prmenu where "
                   + "menu.idcardapio=prmenu.idcardapio and prmenu.idprato=pr.idprato and"
                   + "pr.nome like ?";
        String sqlItem = "select * from prato_cardapio where idcardapio = ?";
        List<Cardapio> listaCardapio = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, nome + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Cardapio cardapio = new Cardapio();
                cardapio.setIdCardapio(Integer.parseInt(rs.getString("idCardapio")));
                cardapio.setDescCardapio(rs.getString("desccardapio"));
                cardapio.setQtdePessoas(Integer.parseInt(rs.getString("qtdePessoas")));
                cardapio.setValorUnitario(Float.parseFloat(rs.getString("valorUnitario")));
                cardapio.setValorTotal(Float.parseFloat(rs.getString("valorTotal")));
                cardapio.setBuffetInterno(rs.getBoolean("buffetInterno"));
                listaCardapio.add(cardapio);
                
                PreparedStatement stmItem = con.prepareStatement(sqlItem);
                stmItem.setInt(1, cardapio.getIdCardapio());
                ResultSet rsItem = stmItem.executeQuery();
                while (rsItem.next()) {
                    PratoCardapio item = new PratoCardapio();
                    item.setIdCardapio(rsItem.getInt("idcardapio"));
                    item.setIdPrato(rsItem.getInt("idprato"));
                    cardapio.adicionarPrato(item);
                }
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaCardapio;
    }

    public static List<Cardapio> consultarBuffet(Boolean buffet) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from cardapio where buffetinterno = ?";
        String sqlItem = "select * from prato_cardapio where idcardapio = ?";
        List<Cardapio> listaCardapio = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setBoolean(1, buffet);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Cardapio cardapio = new Cardapio();
                cardapio.setIdCardapio(Integer.parseInt(rs.getString("idCardapio")));
                cardapio.setDescCardapio(rs.getString("desccardapio"));
                cardapio.setQtdePessoas(Integer.parseInt(rs.getString("qtdePessoas")));
                cardapio.setValorUnitario(Float.parseFloat(rs.getString("valorUnitario")));
                cardapio.setValorTotal(Float.parseFloat(rs.getString("valorTotal")));
                cardapio.setBuffetInterno(rs.getBoolean("buffetInterno"));
                listaCardapio.add(cardapio);

                PreparedStatement stmItem = con.prepareStatement(sqlItem);
                stmItem.setInt(1, cardapio.getIdCardapio());
                ResultSet rsItem = stmItem.executeQuery();
                while (rsItem.next()) {
                    PratoCardapio item = new PratoCardapio();
                    item.setIdCardapio(rsItem.getInt("idcardapio"));
                    item.setIdPrato(rsItem.getInt("idprato"));
                    cardapio.adicionarPrato(item);
                }   
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaCardapio;
    }

    public int getIdCardapio() {
        return idCardapio;
    }

    public void setIdCardapio(int idCardapio) {
        this.idCardapio = idCardapio;
    }

    public String getDescCardapio() {
        return descCardapio;
    }

    public void setDescCardapio(String descCardapio) {
        this.descCardapio = descCardapio;
    }

    public Integer getQtdePessoas() {
        return qtdePessoas;
    }

    public void setQtdePessoas(Integer qtdePessoas) {
        this.qtdePessoas = qtdePessoas;
    }

    public float getValorUnitario() {
        return valorUnitario;
    }

    public void setValorUnitario(float valorUnitario) {
        this.valorUnitario = valorUnitario;
    }

    public float getValorTotal() {
        return valorTotal;
    }

    public void setValorTotal(float valorTotal) {
        this.valorTotal = valorTotal;
    }

    public boolean isBuffetInterno() {
        return buffetInterno;
    }

    public void setBuffetInterno(boolean buffetInterno) {
        this.buffetInterno = buffetInterno;
    }

    public List<PratoCardapio> getPratos() {
        return pratos;
    }

    public void setPratos(List<PratoCardapio> pratos) {
        this.pratos = pratos;
    }

}
