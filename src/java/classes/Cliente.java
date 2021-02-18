/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import utils.Conexao;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.time.LocalDate;

/**
 *
 * @author Janine
 */
public class Cliente {
    
    private int idCliente;
    private String nome;
    private String tipo;
    private String cpf_cnpj;
    private String cep;
    private String uf;
    private String cidade;
    private String bairro;
    private String endereco;
    private Integer numero;
    private String complemento;
    private String telefone1;
    private String telefone2;
    private String email;
    private LocalDate dataNascimento;

    public void salvar() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "insert into cliente (nome, tipo, cpf_cnpj, cep, uf, cidade, "
                + "bairro, endereco, numero, complemento, telefone1, telefone2, email, "
                + "dataNascimento) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.nome);
            stm.setString(2, this.tipo);
            stm.setString(3, this.cpf_cnpj);
            stm.setString(4, this.cep);
            stm.setString(5, this.uf);
            stm.setString(6, this.cidade);
            stm.setString(7, this.bairro);
            stm.setString(8, this.endereco);
            stm.setObject(9, this.numero);
            stm.setString(10, this.complemento);
            stm.setString(11, this.telefone1);
            stm.setString(12, this.telefone2);
            stm.setString(13, this.email);
            stm.setObject(14, this.dataNascimento);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public void editar()throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "update cliente set nome = ?, tipo = ?, cpf_cnpj = ?, cep = ?, "
                + "uf = ?, cidade = ?, bairro = ?, endereco = ?, numero = ?, "
                + "complemento = ?, telefone1 = ?, telefone2 = ?, email = ?, "
                + "dataNascimento = ? where idCliente = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.nome);
            stm.setString(2, this.tipo);
            stm.setString(3, this.cpf_cnpj);
            stm.setString(4, this.cep);
            stm.setString(5, this.uf);
            stm.setString(6, this.cidade);
            stm.setString(7, this.bairro);
            stm.setString(8, this.endereco);
            stm.setObject(9, this.numero);
            stm.setString(10, this.complemento);
            stm.setString(11, this.telefone1);
            stm.setString(12, this.telefone2);
            stm.setString(13, this.email);
            stm.setObject(14, this.dataNascimento);
            stm.setInt(15, this.idCliente);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public void excluir() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "delete from cliente where idCliente = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, this.idCliente);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public static Cliente consultar(int idCliente) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from cliente where idCliente = ?";
        Cliente cliente = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idCliente);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                cliente = new Cliente();
                cliente.setIdCliente(idCliente);
                cliente.setNome(rs.getString("nome"));
                cliente.setTipo(rs.getString("tipo"));
                cliente.setCpf_cnpj(rs.getString("cpf_cnpj"));
                cliente.setCep(rs.getString("cep"));
                cliente.setUf(rs.getString("uf"));
                cliente.setCidade(rs.getString("cidade"));
                cliente.setBairro(rs.getString("bairro"));
                cliente.setEndereco(rs.getString("endereco"));
                cliente.setNumero(rs.getObject("numero", Integer.class));
                cliente.setComplemento(rs.getString("complemento"));
                cliente.setTelefone1(rs.getString("telefone1"));
                cliente.setTelefone2(rs.getString("telefone2"));
                cliente.setEmail(rs.getString("email"));
                cliente.setDataNascimento(rs.getObject("dataNascimento", LocalDate.class));
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return cliente;
    }
    
    public static Cliente consultarCPF_CNPJ(String Cpf_cnpj) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from cliente where cpf_cnpj = ?";
        Cliente cliente = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, Cpf_cnpj);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                cliente = new Cliente();
                cliente.setIdCliente(rs.getInt("idCliente"));
                cliente.setNome(rs.getString("nome"));
                cliente.setTipo(rs.getString("tipo"));
                cliente.setCpf_cnpj(rs.getString("cpf_cnpj"));
                cliente.setCep(rs.getString("cep"));
                cliente.setUf(rs.getString("uf"));
                cliente.setCidade(rs.getString("cidade"));
                cliente.setBairro(rs.getString("bairro"));
                cliente.setEndereco(rs.getString("endereco"));
                cliente.setNumero(rs.getObject("numero", Integer.class));
                cliente.setComplemento(rs.getString("complemento"));
                cliente.setTelefone1(rs.getString("telefone1"));
                cliente.setTelefone2(rs.getString("telefone2"));
                cliente.setEmail(rs.getString("email"));
                cliente.setDataNascimento(rs.getObject("dataNascimento", LocalDate.class));
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return cliente;
    }

    public static List<Cliente> consultar() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from cliente";
        List<Cliente> listaCliente = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Cliente cliente = new Cliente();
                cliente.setIdCliente(Integer.parseInt(rs.getString("idCliente")));
                cliente.setNome(rs.getString("nome"));
                cliente.setTipo(rs.getString("tipo"));
                cliente.setCpf_cnpj(rs.getString("cpf_cnpj"));
                cliente.setCep(rs.getString("cep"));
                cliente.setUf(rs.getString("uf"));
                cliente.setCidade(rs.getString("cidade"));
                cliente.setBairro(rs.getString("bairro"));
                cliente.setEndereco(rs.getString("endereco"));
                cliente.setNumero(rs.getObject("numero", Integer.class));
                cliente.setComplemento(rs.getString("complemento"));
                cliente.setTelefone1(rs.getString("telefone1"));
                cliente.setTelefone2(rs.getString("telefone2"));
                cliente.setEmail(rs.getString("email"));
                cliente.setDataNascimento(rs.getObject("dataNascimento", LocalDate.class));
                listaCliente.add(cliente);
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaCliente;
    }

    public static List<Cliente> consultarNome(String nome) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from cliente where nome like ?";
        List<Cliente> listaCliente = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, nome + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Cliente cliente = new Cliente();
                cliente.setIdCliente(Integer.parseInt(rs.getString("idCliente")));
                cliente.setNome(rs.getString("nome"));
                cliente.setTipo(rs.getString("tipo"));
                cliente.setCpf_cnpj(rs.getString("cpf_cnpj"));
                cliente.setCep(rs.getString("cep"));
                cliente.setUf(rs.getString("uf"));
                cliente.setCidade(rs.getString("cidade"));
                cliente.setBairro(rs.getString("bairro"));
                cliente.setEndereco(rs.getString("endereco"));
                cliente.setNumero(rs.getObject("numero", Integer.class));
                cliente.setComplemento(rs.getString("complemento"));
                cliente.setTelefone1(rs.getString("telefone1"));
                cliente.setTelefone2(rs.getString("telefone2"));
                cliente.setEmail(rs.getString("email"));
                cliente.setDataNascimento(rs.getObject("dataNascimento", LocalDate.class));
                listaCliente.add(cliente);
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaCliente;
    }

    public static List<Cliente> consultarTipo(String tipo) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from cliente where tipo like ?";
        List<Cliente> listaCliente = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, tipo + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Cliente cliente = new Cliente();
                cliente.setIdCliente(Integer.parseInt(rs.getString("idCliente")));
                cliente.setNome(rs.getString("nome"));
                cliente.setTipo(rs.getString("tipo"));
                cliente.setCpf_cnpj(rs.getString("cpf_cnpj"));
                cliente.setCep(rs.getString("cep"));
                cliente.setUf(rs.getString("uf"));
                cliente.setCidade(rs.getString("cidade"));
                cliente.setBairro(rs.getString("bairro"));
                cliente.setEndereco(rs.getString("endereco"));
                cliente.setNumero(rs.getObject("numero", Integer.class));
                cliente.setComplemento(rs.getString("complemento"));
                cliente.setTelefone1(rs.getString("telefone1"));
                cliente.setTelefone2(rs.getString("telefone2"));
                cliente.setEmail(rs.getString("email"));
                cliente.setDataNascimento(rs.getObject("dataNascimento", LocalDate.class));
                listaCliente.add(cliente);
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaCliente;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getCpf_cnpj() {
        return cpf_cnpj;
    }

    public void setCpf_cnpj(String cpf_cnpj) {
        this.cpf_cnpj = cpf_cnpj;
    }

    public String getCep() {
        return cep;
    }

    public void setCep(String cep) {
        this.cep = cep;
    }

    public String getUf() {
        return uf;
    }

    public void setUf(String uf) {
        this.uf = uf;
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    public String getBairro() {
        return bairro;
    }

    public void setBairro(String bairro) {
        this.bairro = bairro;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public Integer getNumero() {
        return numero;
    }

    public void setNumero(Integer numero) {
        this.numero = numero;
    }

    public String getComplemento() {
        return complemento;
    }

    public void setComplemento(String complemento) {
        this.complemento = complemento;
    }

    public String getTelefone1() {
        return telefone1;
    }

    public void setTelefone1(String telefone1) {
        this.telefone1 = telefone1;
    }

    public String getTelefone2() {
        return telefone2;
    }

    public void setTelefone2(String telefone2) {
        this.telefone2 = telefone2;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public LocalDate getDataNascimento() {
        return dataNascimento;
    }

    public void setDataNascimento(LocalDate dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

}