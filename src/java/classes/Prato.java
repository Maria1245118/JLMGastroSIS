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
public class Prato {

    private int idPrato;
    private String nome;
    private Integer rendimento;
    private Integer tempoPreparo;
    private float valorPrato;
    private float lucro;
    private Produto produto;
    private float qtde;
    private String unMedida;
    private float valorIngrediente;
    
    private List<Ingrediente> ingredientes = new ArrayList<>();

    public void salvar() throws Exception {
        Connection con = Conexao.getInstance();
        //não permite gravar a compra sem os itens da compra
        //desabilita a conexão para a gravação da compra sem os itens da compra
        //garante que desfaz a gravação de item e/ou compra no caso de algum erro no processo de gravação
        con.setAutoCommit(false);
        String sql = "insert into prato (nome, rendimento, tempopreparo, valorprato, lucro) "
                   + "values (?, ?, ?, ?, ?)";
        String sqlIngrediente = "insert into ingrediente (qtde, unmedida, valoringrediente, "
                   + "idprato, idproduto) values (?, ?, ?, ?, ?)";
        try {
            PreparedStatement stm = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stm.setString(1, this.nome);
            stm.setInt(2, this.rendimento);
            stm.setInt(3, this.tempoPreparo);
            stm.setFloat(4, this.getValorPrato());
            stm.setFloat(5, this.lucro);
            stm.execute();
            ResultSet rs = stm.getGeneratedKeys(); //recupera o serial gerado no idprato
            Integer idPrato = 0;
            if (rs.next()) { //confere se tem retorno em idprato
                idPrato = rs.getInt(1); //grava o 1º valor retornado
            }
            for (Ingrediente ingrediente : ingredientes) {
                ingrediente.setIdprato(idPrato);
                PreparedStatement stmIngrediente = con.prepareStatement(sqlIngrediente);
                stmIngrediente.setFloat(1, ingrediente.getQtde());
                stmIngrediente.setString(2, ingrediente.getUnMedida());
                stmIngrediente.setFloat(3, ingrediente.getValorIngrediente());
                stmIngrediente.setInt(4, ingrediente.getIdprato());
                stmIngrediente.setInt(5, ingrediente.getIdproduto());
                stmIngrediente.execute();
            }
            con.commit(); //confirma que não houve erro e executa a gravação de todos os dados no banco
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
        String sql = "update prato set nome = ?, rendimento = ?, tempopreparo = ?, "
                + "valorprato = ?, lucro = ? where idprato = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.nome);
            stm.setInt(2, this.rendimento);
            stm.setInt(3, this.tempoPreparo);
            stm.setFloat(4, this.getValorPrato());
            stm.setFloat(5, this.lucro);
            stm.setInt(6, this.idPrato);
            stm.execute();
            
            String sqlIngrediente = "delete from ingrediente where idprato = ?";
            PreparedStatement stmIngrediente = con.prepareStatement(sqlIngrediente);
            stmIngrediente.setInt(1, this.idPrato);
            stmIngrediente.execute();
            sqlIngrediente = "insert into ingrediente (qtde, unmedida, valoringrediente, "
                    + "idprato, idproduto) values (?, ?, ?, ?, ?)";
            for (Ingrediente ingrediente : ingredientes) {
                ingrediente.setIdprato(this.idPrato);
                stmIngrediente = con.prepareStatement(sqlIngrediente);
                stmIngrediente.setFloat(1, ingrediente.getQtde());
                stmIngrediente.setString(2, ingrediente.getUnMedida());
                stmIngrediente.setFloat(3, ingrediente.getValorIngrediente());
                stmIngrediente.setInt(4, ingrediente.getIdprato());
                stmIngrediente.setInt(5, ingrediente.getIdproduto());
                stmIngrediente.execute();
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
        String sqlIngrediente = "delete from ingrediente where idprato = ?";
        String sql = "delete from prato where idprato = ?";
        try {
            PreparedStatement stmIngrediente = con.prepareStatement(sqlIngrediente);
            stmIngrediente.setInt(1, this.idPrato);
            stmIngrediente.execute();
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, this.idPrato);
            stm.execute();
            con.commit();
        } catch (SQLException ex) {
            con.rollback();
            throw new Exception(ex.getMessage());
        } finally {
            con.setAutoCommit(true);
        }
    }
    
    public void adicionarIngrediente(Ingrediente ingrediente) {
        ingredientes.add(ingrediente);
    }

    public Float getTotalIngrediente() {
        float totalIngrediente = 0;
        for (Ingrediente ingrediente : this.ingredientes) {
            totalIngrediente += ingrediente.getValorIngrediente();
        }
        return totalIngrediente;
    }
    
    public static Prato consultar(int idPrato) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from prato where idprato = ?";
        String sqlIngrediente = "select * from ingrediente where idprato = ?";
        Prato prato = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idPrato);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                prato = new Prato();
                prato.setIdPrato(idPrato);
                prato.setNome(rs.getString("nome"));
                prato.setRendimento(Integer.parseInt(rs.getString("rendimento")));
                prato.setTempoPreparo(Integer.parseInt(rs.getString("tempopreparo")));
                prato.setValorPrato(Float.parseFloat(rs.getString("valorprato")));
                prato.setLucro(Float.parseFloat(rs.getString("lucro")));
                
                PreparedStatement stmIngrediente = con.prepareStatement(sqlIngrediente);
                stmIngrediente.setInt(1, idPrato);
                ResultSet rsIngrediente = stmIngrediente.executeQuery();
                while (rsIngrediente.next()) {
                    Ingrediente ingrediente = new Ingrediente();
                    ingrediente.setIdprato(idPrato);
                    ingrediente.setQtde(rsIngrediente.getFloat("qtde"));
                    ingrediente.setUnMedida(rsIngrediente.getString("unmedida"));
                    ingrediente.setValorIngrediente(rsIngrediente.getFloat("valoringrediente"));
                    ingrediente.setIdproduto((rsIngrediente.getInt("idproduto")));
                    prato.adicionarIngrediente(ingrediente);
                }
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return prato;
    }

    public static List<Prato> consultar() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from prato";
        String sqlIngrediente = "select * from ingrediente where idprato = ?";
        List<Prato> listaPrato = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Prato prato = new Prato();
                prato.setIdPrato(Integer.parseInt(rs.getString("idPrato")));
                prato.setNome(rs.getString("nome"));
                prato.setRendimento(Integer.parseInt(rs.getString("rendimento")));
                prato.setTempoPreparo(Integer.parseInt(rs.getString("tempopreparo")));
                prato.setValorPrato(Float.parseFloat(rs.getString("valorprato")));
                prato.setLucro(Float.parseFloat(rs.getString("lucro")));
                listaPrato.add(prato);
                
                PreparedStatement stmIngrediente = con.prepareStatement(sqlIngrediente);
                stmIngrediente.setInt(1, prato.getIdPrato());
                ResultSet rsIngrediente = stmIngrediente.executeQuery();
                while (rsIngrediente.next()) {
                    Ingrediente ingrediente = new Ingrediente();
                    ingrediente.setIdprato(rsIngrediente.getInt("idprato"));
                    ingrediente.setQtde(rsIngrediente.getFloat("qtde"));
                    ingrediente.setUnMedida(rsIngrediente.getString("unmedida"));
                    ingrediente.setValorIngrediente(rsIngrediente.getFloat("valoringrediente"));
                    ingrediente.setIdproduto((rsIngrediente.getInt("idproduto")));
                    prato.adicionarIngrediente(ingrediente);
                }
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaPrato;
    }

    public static List<Prato> consultarNome(String nome) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from prato where nome like ?";
        String sqlIngrediente = "select * from ingrediente where idprato = ?";
        List<Prato> listaPrato = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, nome + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Prato prato = new Prato();
                prato.setIdPrato(Integer.parseInt(rs.getString("idPrato")));
                prato.setNome(rs.getString("nome"));
                prato.setRendimento(Integer.parseInt(rs.getString("rendimento")));
                prato.setTempoPreparo(Integer.parseInt(rs.getString("tempoPreparo")));
                prato.setValorPrato(Float.parseFloat(rs.getString("valorprato")));
                prato.setLucro(Float.parseFloat(rs.getString("lucro")));
                listaPrato.add(prato);
                
                PreparedStatement stmIngrediente = con.prepareStatement(sqlIngrediente);
                stmIngrediente.setInt(1, prato.getIdPrato());
                ResultSet rsIngrediente = stmIngrediente.executeQuery();
                while (rsIngrediente.next()) {
                    Ingrediente ingrediente = new Ingrediente();
                    ingrediente.setIdprato(rsIngrediente.getInt("idprato"));
                    ingrediente.setQtde(rsIngrediente.getFloat("qtde"));
                    ingrediente.setUnMedida(rsIngrediente.getString("unmedida"));
                    ingrediente.setValorIngrediente(rsIngrediente.getFloat("valoringrediente"));
                    ingrediente.setIdproduto(rsIngrediente.getInt("idproduto"));
                    prato.adicionarIngrediente(ingrediente);
                }
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaPrato;
    }
    
    public static List<Prato> consultarProduto(String produto) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from prato pr, ingrediente ing, produto prod where "
                + "pr.idprato=ing.idprato and ing.idproduto=prod.idproduto "
                + "and prod.descricaoproduto like ?";
        String sqlIngrediente = "select * from ingrediente where idprato = ?";
        List<Prato> listaPrato = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, produto + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Prato prato = new Prato();
                prato.setIdPrato(Integer.parseInt(rs.getString("idPrato")));
                prato.setNome(rs.getString("nome"));
                prato.setRendimento(Integer.parseInt(rs.getString("rendimento")));
                prato.setTempoPreparo(Integer.parseInt(rs.getString("tempoPreparo")));
                prato.setValorPrato(Float.parseFloat(rs.getString("valorprato")));
                prato.setLucro(Float.parseFloat(rs.getString("lucro")));
                listaPrato.add(prato);
                
                PreparedStatement stmIngrediente = con.prepareStatement(sqlIngrediente);
                stmIngrediente.setInt(1, prato.getIdPrato());
                ResultSet rsIngrediente = stmIngrediente.executeQuery();
                while (rsIngrediente.next()) {
                    Ingrediente ingrediente = new Ingrediente();
                    ingrediente.setIdprato(rsIngrediente.getInt("idprato"));
                    ingrediente.setQtde(rsIngrediente.getFloat("qtde"));
                    ingrediente.setUnMedida(rsIngrediente.getString("unmedida"));
                    ingrediente.setValorIngrediente(rsIngrediente.getFloat("valoringrediente"));
                    ingrediente.setIdproduto(rsIngrediente.getInt("idproduto"));
                    prato.adicionarIngrediente(ingrediente);
                }
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaPrato;
    }

    public int getIdPrato() {
        return idPrato;
    }

    public void setIdPrato(int idPrato) {
        this.idPrato = idPrato;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Integer getRendimento() {
        return rendimento;
    }

    public void setRendimento(Integer rendimento) {
        this.rendimento = rendimento;
    }

    public Integer getTempoPreparo() {
        return tempoPreparo;
    }

    public void setTempoPreparo(Integer tempoPreparo) {
        this.tempoPreparo = tempoPreparo;
    }

    public float getValorPrato() {
        return valorPrato;
    }

    public void setValorPrato(float valorPrato) {
        this.valorPrato = valorPrato;
    }

    public float getLucro() {
        return lucro;
    }

    public void setLucro(float lucro) {
        this.lucro = lucro;
    }

    public Produto getProduto() {
        return produto;
    }

    public void setProduto(Produto produto) {
        this.produto = produto;
    }

    public float getQtde() {
        return qtde;
    }

    public void setQtde(float qtde) {
        this.qtde = qtde;
    }

    public String getUnMedida() {
        return unMedida;
    }

    public void setUnMedida(String unMedida) {
        this.unMedida = unMedida;
    }

    public float getValorIngrediente() {
        return valorIngrediente;
    }

    public void setValorIngrediente(float valorIngrediente) {
        this.valorIngrediente = valorIngrediente;
    }

    public List<Ingrediente> getIngredientes() {
        return ingredientes;
    }

    public void setIngredientes(List<Ingrediente> ingredientes) {
        this.ingredientes = ingredientes;
    }

}
