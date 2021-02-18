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
public class Funcionario {

    private int idFuncionario;
    private String nome;
    private String cpf;
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
        String sql = "insert into funcionario (nome, cpf, cep, uf, cidade, "
                + "bairro, endereco, numero, complemento, telefone1, telefone2, email, "
                + "dataNascimento) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.nome);
            stm.setString(2, this.cpf);
            stm.setString(3, this.cep);
            stm.setString(4, this.uf);
            stm.setString(5, this.cidade);
            stm.setString(6, this.bairro);
            stm.setString(7, this.endereco);
            stm.setObject(8, this.numero);
            stm.setString(9, this.complemento);
            stm.setString(10, this.telefone1);
            stm.setString(11, this.telefone2);
            stm.setString(12, this.email);
            stm.setObject(13, this.dataNascimento);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public void editar()throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "update funcionario set nome = ?, cpf = ?, cep = ?, "
                + "uf = ?, cidade = ?, bairro = ?, endereco = ?, numero = ?, "
                + "complemento = ?, telefone1 = ?, telefone2 = ?, email = ?, "
                + "datanascimento = ? where idFuncionario = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.nome);
            stm.setString(2, this.cpf);
            stm.setString(3, this.cep);
            stm.setString(4, this.uf);
            stm.setString(5, this.cidade);
            stm.setString(6, this.bairro);
            stm.setString(7, this.endereco);
            stm.setObject(8, this.numero);
            stm.setString(9, this.complemento);
            stm.setString(10, this.telefone1);
            stm.setString(11, this.telefone2);
            stm.setString(12, this.email);
            stm.setObject(13, this.dataNascimento);
            stm.setInt(14, this.idFuncionario);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public void excluir() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "delete from funcionario where idFuncionario = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, this.idFuncionario);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public static Funcionario consultar(int idFuncionario) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from funcionario where idFuncionario = ?";
        Funcionario funcionario = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idFuncionario);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                funcionario = new Funcionario();
                funcionario.setIdFuncionario(idFuncionario);
                funcionario.setNome(rs.getString("nome"));
                funcionario.setCpf(rs.getString("cpf"));
                funcionario.setCep(rs.getString("cep"));
                funcionario.setUf(rs.getString("uf"));
                funcionario.setCidade(rs.getString("cidade"));
                funcionario.setBairro(rs.getString("bairro"));
                funcionario.setEndereco(rs.getString("endereco"));
                funcionario.setNumero(rs.getObject("numero", Integer.class));
                funcionario.setComplemento(rs.getString("complemento"));
                funcionario.setTelefone1(rs.getString("telefone1"));
                funcionario.setTelefone2(rs.getString("telefone2"));
                funcionario.setEmail(rs.getString("email"));
                funcionario.setDataNascimento(rs.getObject("dataNascimento", LocalDate.class));
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return funcionario;
    }

    public static Funcionario consultarCPF(String Cpf) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from funcionario where cpf = ?";
        Funcionario funcionario = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, Cpf);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                funcionario = new Funcionario();
                funcionario.setIdFuncionario(rs.getInt("idFuncionario"));
                funcionario.setNome(rs.getString("nome"));
                funcionario.setCpf(rs.getString("cpf"));
                funcionario.setCep(rs.getString("cep"));
                funcionario.setUf(rs.getString("uf"));
                funcionario.setCidade(rs.getString("cidade"));
                funcionario.setBairro(rs.getString("bairro"));
                funcionario.setEndereco(rs.getString("endereco"));
                funcionario.setNumero(rs.getObject("numero", Integer.class));
                funcionario.setComplemento(rs.getString("complemento"));
                funcionario.setTelefone1(rs.getString("telefone1"));
                funcionario.setTelefone2(rs.getString("telefone2"));
                funcionario.setEmail(rs.getString("email"));
                funcionario.setDataNascimento(rs.getObject("dataNascimento", LocalDate.class));
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return funcionario;
    }

    public static List<Funcionario> consultar() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from funcionario";
        List<Funcionario> listaFuncionario = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Funcionario funcionario = new Funcionario();
                funcionario.setIdFuncionario(Integer.parseInt(rs.getString("idFuncionario")));
                funcionario.setNome(rs.getString("nome"));
                funcionario.setCpf(rs.getString("cpf"));
                funcionario.setCep(rs.getString("cep"));
                funcionario.setUf(rs.getString("uf"));
                funcionario.setCidade(rs.getString("cidade"));
                funcionario.setBairro(rs.getString("bairro"));
                funcionario.setEndereco(rs.getString("endereco"));
                funcionario.setNumero(rs.getObject("numero", Integer.class));
                funcionario.setComplemento(rs.getString("complemento"));
                funcionario.setTelefone1(rs.getString("telefone1"));
                funcionario.setTelefone2(rs.getString("telefone2"));
                funcionario.setEmail(rs.getString("email"));
                funcionario.setDataNascimento(rs.getObject("dataNascimento", LocalDate.class));
                listaFuncionario.add(funcionario);
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaFuncionario;
    }

    public static List<Funcionario> consultarNome(String nome) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from funcionario where nome like ?";
        List<Funcionario> listaFuncionario = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, nome + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Funcionario funcionario = new Funcionario();
                funcionario.setIdFuncionario(Integer.parseInt(rs.getString("idFuncionario")));
                funcionario.setNome(rs.getString("nome"));
                funcionario.setCpf(rs.getString("cpf"));
                funcionario.setCep(rs.getString("cep"));
                funcionario.setUf(rs.getString("uf"));
                funcionario.setCidade(rs.getString("cidade"));
                funcionario.setBairro(rs.getString("bairro"));
                funcionario.setEndereco(rs.getString("endereco"));
                funcionario.setNumero(rs.getObject("numero", Integer.class));
                funcionario.setComplemento(rs.getString("complemento"));
                funcionario.setTelefone1(rs.getString("telefone1"));
                funcionario.setTelefone2(rs.getString("telefone2"));
                funcionario.setEmail(rs.getString("email"));
                funcionario.setDataNascimento(rs.getObject("dataNascimento", LocalDate.class));
                listaFuncionario.add(funcionario);
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaFuncionario;
    }

    public int getIdFuncionario() {
        return idFuncionario;
    }

    public void setIdFuncionario(int idFuncionario) {
        this.idFuncionario = idFuncionario;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
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
