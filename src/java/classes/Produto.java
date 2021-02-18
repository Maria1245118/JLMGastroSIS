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
public class Produto {

    private int idProduto;
    private String descricaoProduto;
    private float qtdeProduto;
    private String unMedida;

    public void salvar() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "insert into produto (descricaoproduto, qtdeProduto, unmedida) values(?, ?, ?)";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.descricaoProduto);
            stm.setFloat(2, 0);
            stm.setString(3, this.unMedida);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public void editar()throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "update produto set descricaoproduto = ?, "
                + "unmedida = ? where idproduto = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.descricaoProduto);
            stm.setString(2, this.unMedida);
            stm.setInt(3, this.idProduto);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public void excluir() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "delete from produto where idProduto = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, this.idProduto);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public float getPrecoCompra() throws Exception {
	Connection con = Conexao.getInstance();
        String sql = "select c.datacompra, i.valorcompra from compra c, item_compra i "
                + "where i.idproduto = ? and c.idcompra=i.idcompra order by datacompra "
                + "desc limit 1 offset 0";
        float valorCompra = 0;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setFloat(1, idProduto);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                valorCompra = rs.getFloat("valorcompra");
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return valorCompra;
    }

    public static void atualizarSaldoEstoque(int idProduto) throws Exception {
        Connection con = Conexao.getInstance();
        String sqlTotalCompra = "select coalesce(sum(qtdecompra), 0) as totalcompra from "
                + "item_compra where idproduto = ?";
        float totalCompra = 0;
        try {
            PreparedStatement stm = con.prepareStatement(sqlTotalCompra);
            stm.setInt(1, idProduto);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                totalCompra = rs.getFloat("totalcompra");
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        String sqlTotalVenda = "select coalesce(sum(itemv.qtdevenda * ing.qtde), 0) "
                + "as totalvenda from item_venda itemv, cardapio_venda menuv, prato_cardapio prmenu, "
                + "ingrediente ing where itemv.idcardapiovenda=menuv.idcardapiovenda and "
                + "menuv.idcardapio=prmenu.idcardapio and prmenu.idprato=ing.idprato and ing.idproduto = ?";
        float totalVenda = 0;
        try {
            PreparedStatement stm = con.prepareStatement(sqlTotalVenda);
            stm.setInt(1, idProduto);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                totalVenda = rs.getFloat("totalvenda");
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        String sql = "update produto set qtdeproduto = ? where idproduto = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setFloat(1, totalCompra - totalVenda);
            stm.setInt(2, idProduto);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public static Produto consultar(int idProduto) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from produto where idProduto = ? order by descricaoproduto";
        Produto produto = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idProduto);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                produto = new Produto();
                produto.setIdProduto(idProduto);
                produto.setDescricaoProduto(rs.getString("descricaoProduto"));
                produto.setQtdeProduto(Float.parseFloat(rs.getString("qtdeProduto")));
                produto.setUnMedida(rs.getString("unmedida"));
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return produto;
    }

    public static List<Produto> consultar() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from produto order by descricaoproduto";
        List<Produto> listaProduto = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Produto produto = new Produto();
                produto.setIdProduto(Integer.parseInt(rs.getString("idproduto")));
                produto.setDescricaoProduto(rs.getString("descricaoproduto"));
                produto.setQtdeProduto(Float.parseFloat(rs.getString("qtdeproduto")));
                produto.setUnMedida(rs.getString("unmedida"));
                listaProduto.add(produto);
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaProduto;
    }

    public static List<Produto> consultarProduto(String descricaoProduto) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from produto where descricaoproduto like ? order by descricaoproduto";
        List<Produto> listaProduto = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, descricaoProduto + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Produto produto = new Produto();
                produto.setIdProduto(Integer.parseInt(rs.getString("idproduto")));
                produto.setDescricaoProduto(rs.getString("descricaoproduto"));
                produto.setQtdeProduto(Float.parseFloat(rs.getString("qtdeProduto")));
                produto.setUnMedida(rs.getString("unmedida"));
                listaProduto.add(produto);
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaProduto;
    }

    public int getIdProduto() {
        return idProduto;
    }

    public void setIdProduto(int idProduto) {
        this.idProduto = idProduto;
    }

    public float getQtdeProduto() {
        return qtdeProduto;
    }

    public void setQtdeProduto(float qtdeProduto) {
        this.qtdeProduto = qtdeProduto;
    }

    public String getDescricaoProduto() {
        return descricaoProduto;
    }

    public void setDescricaoProduto(String descricaoProduto) {
        this.descricaoProduto = descricaoProduto;
    }

    public String getUnMedida() {
        return unMedida;
    }

    public void setUnMedida(String unMedida) {
        this.unMedida = unMedida;
    }
}
