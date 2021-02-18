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
public class Fornecedor {
    
    private int idFornecedor;
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
    private LocalDate dataCadastro;

    public void salvar() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "insert into fornecedor (nome, tipo, cpf_cnpj, cep, uf, cidade, "
                + "bairro, endereco, numero, complemento, telefone1, telefone2, email, "
                + "dataCadastro) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
            stm.setObject(14, this.dataCadastro);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public void editar()throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "update fornecedor set nome = ?, tipo = ?, cpf_cnpj = ?, cep = ?, "
                + "uf = ?, cidade = ?, bairro = ?, endereco = ?, numero = ?, "
                + "complemento = ?, telefone1 = ?, telefone2 = ?, email = ?, "
                + "dataCadastro = ? where idFornecedor = ?";
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
            stm.setObject(14, this.dataCadastro);
            stm.setInt(15, this.idFornecedor);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public void excluir() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "delete from fornecedor where idFornecedor = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, this.idFornecedor);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public static Fornecedor consultar(int idFornecedor) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from fornecedor where idFornecedor = ? order by nome";
        Fornecedor fornecedor = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idFornecedor);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                fornecedor = new Fornecedor();
                fornecedor.setIdFornecedor(idFornecedor);
                fornecedor.setNome(rs.getString("nome"));
                fornecedor.setTipo(rs.getString("tipo"));
                fornecedor.setCpf_cnpj(rs.getString("cpf_cnpj"));
                fornecedor.setCep(rs.getString("cep"));
                fornecedor.setUf(rs.getString("uf"));
                fornecedor.setCidade(rs.getString("cidade"));
                fornecedor.setBairro(rs.getString("bairro"));
                fornecedor.setEndereco(rs.getString("endereco"));
                fornecedor.setNumero(rs.getObject("numero", Integer.class));
                fornecedor.setComplemento(rs.getString("complemento"));
                fornecedor.setTelefone1(rs.getString("telefone1"));
                fornecedor.setTelefone2(rs.getString("telefone2"));
                fornecedor.setEmail(rs.getString("email"));
                fornecedor.setDataCadastro(rs.getObject("dataCadastro", LocalDate.class));
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return fornecedor;
    }
    
    public static Fornecedor consultarCPF_CNPJ(String Cpf_cnpj) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from fornecedor where cpf_cnpj = ? order by nome";
        Fornecedor fornecedor = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, Cpf_cnpj);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                fornecedor = new Fornecedor();
                fornecedor.setIdFornecedor(rs.getInt("idFornecedor"));
                fornecedor.setNome(rs.getString("nome"));
                fornecedor.setTipo(rs.getString("tipo"));
                fornecedor.setCpf_cnpj(rs.getString("cpf_cnpj"));
                fornecedor.setCep(rs.getString("cep"));
                fornecedor.setUf(rs.getString("uf"));
                fornecedor.setCidade(rs.getString("cidade"));
                fornecedor.setBairro(rs.getString("bairro"));
                fornecedor.setEndereco(rs.getString("endereco"));
                fornecedor.setNumero(rs.getObject("numero", Integer.class));
                fornecedor.setComplemento(rs.getString("complemento"));
                fornecedor.setTelefone1(rs.getString("telefone1"));
                fornecedor.setTelefone2(rs.getString("telefone2"));
                fornecedor.setEmail(rs.getString("email"));
                fornecedor.setDataCadastro(rs.getObject("dataCadastro", LocalDate.class));
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return fornecedor;
    }

    public static List<Fornecedor> consultar() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from fornecedor order by nome";
        List<Fornecedor> listaFornecedor = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Fornecedor fornecedor = new Fornecedor();
                fornecedor.setIdFornecedor(Integer.parseInt(rs.getString("idFornecedor")));
                fornecedor.setNome(rs.getString("nome"));
                fornecedor.setTipo(rs.getString("tipo"));
                fornecedor.setCpf_cnpj(rs.getString("cpf_cnpj"));
                fornecedor.setCep(rs.getString("cep"));
                fornecedor.setUf(rs.getString("uf"));
                fornecedor.setCidade(rs.getString("cidade"));
                fornecedor.setBairro(rs.getString("bairro"));
                fornecedor.setEndereco(rs.getString("endereco"));
                fornecedor.setNumero(rs.getObject("numero", Integer.class));
                fornecedor.setComplemento(rs.getString("complemento"));
                fornecedor.setTelefone1(rs.getString("telefone1"));
                fornecedor.setTelefone2(rs.getString("telefone2"));
                fornecedor.setEmail(rs.getString("email"));
                fornecedor.setDataCadastro(rs.getObject("dataCadastro", LocalDate.class));
                listaFornecedor.add(fornecedor);
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaFornecedor;
    }

    public static List<Fornecedor> consultarNome(String nome) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from fornecedor where nome like ? order by nome";
        List<Fornecedor> listaFornecedor = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, nome + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Fornecedor fornecedor = new Fornecedor();
                fornecedor.setIdFornecedor(Integer.parseInt(rs.getString("idFornecedor")));
                fornecedor.setNome(rs.getString("nome"));
                fornecedor.setTipo(rs.getString("tipo"));
                fornecedor.setCpf_cnpj(rs.getString("cpf_cnpj"));
                fornecedor.setCep(rs.getString("cep"));
                fornecedor.setUf(rs.getString("uf"));
                fornecedor.setCidade(rs.getString("cidade"));
                fornecedor.setBairro(rs.getString("bairro"));
                fornecedor.setEndereco(rs.getString("endereco"));
                fornecedor.setNumero(rs.getObject("numero", Integer.class));
                fornecedor.setComplemento(rs.getString("complemento"));
                fornecedor.setTelefone1(rs.getString("telefone1"));
                fornecedor.setTelefone2(rs.getString("telefone2"));
                fornecedor.setEmail(rs.getString("email"));
                fornecedor.setDataCadastro(rs.getObject("dataCadastro", LocalDate.class));
                listaFornecedor.add(fornecedor);
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaFornecedor;
    }

    public static List<Fornecedor> consultarTipo(String tipo) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from fornecedor where tipo like ? order by nome";
        List<Fornecedor> listaFornecedor = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, tipo + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Fornecedor fornecedor = new Fornecedor();
                fornecedor.setIdFornecedor(Integer.parseInt(rs.getString("idFornecedor")));
                fornecedor.setNome(rs.getString("nome"));
                fornecedor.setTipo(rs.getString("tipo"));
                fornecedor.setCpf_cnpj(rs.getString("cpf_cnpj"));
                fornecedor.setCep(rs.getString("cep"));
                fornecedor.setUf(rs.getString("uf"));
                fornecedor.setCidade(rs.getString("cidade"));
                fornecedor.setBairro(rs.getString("bairro"));
                fornecedor.setEndereco(rs.getString("endereco"));
                fornecedor.setNumero(rs.getObject("numero", Integer.class));
                fornecedor.setComplemento(rs.getString("complemento"));
                fornecedor.setTelefone1(rs.getString("telefone1"));
                fornecedor.setTelefone2(rs.getString("telefone2"));
                fornecedor.setEmail(rs.getString("email"));
                fornecedor.setDataCadastro(rs.getObject("dataCadastro", LocalDate.class));
                listaFornecedor.add(fornecedor);
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaFornecedor;
    }

    public int getIdFornecedor() {
        return idFornecedor;
    }

    public void setIdFornecedor(int idFornecedor) {
        this.idFornecedor = idFornecedor;
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

    public LocalDate getDataCadastro() {
        return dataCadastro;
    }

    public void setDataCadastro(LocalDate dataCadastro) {
        this.dataCadastro = dataCadastro;
    }

}
