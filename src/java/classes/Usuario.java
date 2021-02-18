/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import utils.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Janine
 */
public class Usuario {

    private int idUsuario;
    private String nuser;
    private Funcionario funcionario;
    private String senha;
    private String email;

    public void salvar() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "insert into usuario (nuser, idfuncionario, senha, email) values (?, ?, ?, ?)";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.nuser);
            if (funcionario != null) {
                stm.setInt(2, funcionario.getIdFuncionario());
            } else {
                stm.setObject(2, null);
            }
            stm.setString(3, this.senha);
            stm.setString(4, this.email);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public void editar() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "update usuario set nuser = ?, idfuncionario = ?, senha = ?, email = ? where idUsuario = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.nuser);
            if (funcionario != null) {
                stm.setInt(2, funcionario.getIdFuncionario());
            } else {
                stm.setObject(2, null);
            }
            stm.setString(3, this.senha);
            stm.setString(4, this.email);
            stm.setInt(5, this.idUsuario);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public void excluir() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "delete from usuario where idUsuario = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, this.idUsuario);
            stm.execute();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public static boolean podeLogar(String nUser, String pSenha) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from usuario where nuser=? and senha=?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, nUser.toUpperCase());
            stm.setString(2, pSenha);
            ResultSet rs = stm.executeQuery();
            return rs.next();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public boolean userExiste(String nUser) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from usuario where nuser=?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, nUser);
            ResultSet rs = stm.executeQuery();
            return rs.next();
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public static Usuario consultar(int idUsuario) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from usuario where idUsuario = ?";
        Usuario usuario = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idUsuario);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                usuario = new Usuario();
                usuario.setIdUsuario(idUsuario);
                usuario.setNuser(rs.getString("nuser"));
                usuario.setFuncionario(Funcionario.consultar(rs.getInt("idFuncionario")));
                usuario.setSenha(rs.getString("senha"));
                usuario.setEmail(rs.getString("email"));
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return usuario;
    }
    
    public static Usuario consultar(String nuser) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from usuario where nuser = ?";
        Usuario usuario = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, nuser.toUpperCase());
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idUsuario"));
                usuario.setNuser(rs.getString("nuser"));
                usuario.setFuncionario(Funcionario.consultar(rs.getInt("idFuncionario")));
                usuario.setSenha(rs.getString("senha"));
                usuario.setEmail(rs.getString("email"));
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return usuario;
    }

    public static List<Usuario> consultarUsuario(String nuser) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from usuario where nuser like ?";
        List<Usuario> listaUsuario = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, nuser + "%");
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idUsuario"));
                usuario.setNuser(rs.getString("nuser"));
                usuario.setFuncionario(Funcionario.consultar(rs.getInt("idFuncionario")));
                usuario.setSenha(rs.getString("senha"));
                usuario.setEmail(rs.getString("email"));
                listaUsuario.add(usuario);
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaUsuario;
    }

    public static List<Usuario> consultar() throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from usuario";
        List<Usuario> listaUsuario = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(Integer.parseInt(rs.getString("idUsuario")));
                usuario.setNuser(rs.getString("nuser"));
                Funcionario func = Funcionario.consultar(rs.getInt("idFuncionario"));
                usuario.setFuncionario(func);
                usuario.setSenha(rs.getString("senha"));
                usuario.setEmail(rs.getString("email"));
                listaUsuario.add(usuario);
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaUsuario;
    }

    public static List<Usuario> consultarFuncionario(String nome) throws Exception {
        Connection con = Conexao.getInstance();
        String sql = "select * from usuario usuar, funcionario func where "
                   + "usuar.idfuncionario=func.idfuncionario and func.nome like ?";
        List<Usuario> listaUsuario = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, nome + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(Integer.parseInt(rs.getString("idUsuario")));
                usuario.setNuser(rs.getString("nuser"));
                usuario.setFuncionario(Funcionario.consultar(rs.getInt("idFuncionario")));
                usuario.setSenha(rs.getString("senha"));
                usuario.setEmail(rs.getString("email"));
                listaUsuario.add(usuario);
            }
        } catch (SQLException ex) {
            throw new Exception(ex.getMessage());
        }
        return listaUsuario;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNuser() {
        return nuser;
    }

    public void setNuser(String nuser) {
        this.nuser = nuser;
    }

    public Funcionario getFuncionario() {
        return funcionario;
    }

    public void setFuncionario(Funcionario funcionario) {
        this.funcionario = funcionario;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

}