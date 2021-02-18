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
import utils.DataHora;

/**
 *
 * @author Janine
 */
public class CardapioDia {

    private int idCardapioDia;
    private Cardapio cardapio;
    private LocalDate dataCardapio;

    public void salvar() throws Exception {
        Connection con = Conexao.getInstance();
        //não permite gravar a compra sem os itens da compra
        //desabilita a conexão para a gravação da compra sem os itens da compra
        //garante que desfaz a gravação de item e/ou compra no caso de algum erro no processo de gravação
        String sql = "insert into cardapio_dia (idcardapio, datacardapio) values (?, ?)";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, cardapio.getIdCardapio());
            stm.setObject(2, this.dataCardapio);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public void editar()throws Exception {
        Connection con = Conexao.getInstance();
        //não permite gravar a compra sem os itens da compra
        //desabilita a conexão para a gravação da compra sem os itens da compra
        //garante que desfaz a gravação de item e/ou compra no caso de algum erro no processo de gravação
        String sql = "update cardapio_dia set idcardapio = ?, datacardapio = ? where idcardapiodia = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, cardapio.getIdCardapio());
            stm.setObject(2, this.dataCardapio);
            stm.setInt(3, this.idCardapioDia);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public void excluir() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "delete from cardapio_dia where idcardapiodia = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, this.idCardapioDia);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public static CardapioDia consultar(int idCardapioDia) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from cardapio_dia where idcardapiodia = ?";
        CardapioDia cardapioDia = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idCardapioDia);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                cardapioDia = new CardapioDia();
                cardapioDia.setIdCardapioDia(idCardapioDia);
                cardapioDia.setCardapio(Cardapio.consultar(rs.getInt("idcardapio")));
                cardapioDia.setDataCardapio(rs.getObject("datacardapio", LocalDate.class));
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return cardapioDia;
    }

    public static CardapioDia consultarIdCardapio(int idCardapio) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from cardapio_dia where idcardapio = ?";
        CardapioDia cardapioDia = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idCardapio);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                cardapioDia = new CardapioDia();
                cardapioDia.setIdCardapioDia(Integer.parseInt(rs.getString("idcardapiodia")));
                cardapioDia.setCardapio(Cardapio.consultar(rs.getInt("idcardapio")));
                cardapioDia.setDataCardapio(rs.getObject("datacardapio", LocalDate.class));
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return cardapioDia;
    }

    public LocalDate getDivulgarCardapio() {
        LocalDate divulgar = LocalDate.now();
        if (dataCardapio != null && "".equals(dataCardapio)) {
            dataCardapio = LocalDate.now();
        } else {
            System.out.println("Não há cardápio cadastrado para o dia de hoje");
        }
        return divulgar;
    }
    
    public static CardapioDia consultarData(LocalDate dataCardapio) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from cardapio_dia menudia where datacardapio = ?";
        CardapioDia cardapioDia = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setObject(1, dataCardapio);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {                    
                cardapioDia = new CardapioDia();
                cardapioDia.setIdCardapioDia(Integer.parseInt(rs.getString("idcardapiodia")));
                cardapioDia.setCardapio(Cardapio.consultar(rs.getInt("idcardapio")));
                cardapioDia.setDataCardapio(dataCardapio);
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return cardapioDia;
    }

    public static List<CardapioDia> consultar() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from cardapio_dia";
        List<CardapioDia> listaCardapioDia = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                CardapioDia cardapioDia = new CardapioDia();
                cardapioDia.setIdCardapioDia(Integer.parseInt(rs.getString("idcardapiodia")));
                cardapioDia.setCardapio(Cardapio.consultar(rs.getInt("idcardapio")));
                cardapioDia.setDataCardapio(rs.getObject("datacardapio", LocalDate.class));
                listaCardapioDia.add(cardapioDia);
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaCardapioDia;
    }

    public int getIdCardapioDia() {
        return idCardapioDia;
    }

    public void setIdCardapioDia(int idCardapioDia) {
        this.idCardapioDia = idCardapioDia;
    }

    public Cardapio getCardapio() {
        return cardapio;
    }

    public void setCardapio(Cardapio cardapio) {
        this.cardapio = cardapio;
    }

    public LocalDate getDataCardapio() {
        return dataCardapio;
    }

    public void setDataCardapio(LocalDate dataCardapio) {
        this.dataCardapio = dataCardapio;
    }

    
}
