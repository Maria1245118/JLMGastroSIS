/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

/**
 *
 * @author Janine
 */
public class Ingrediente {

    private int idproduto;
    private int idprato;
    private float qtde;
    private String unMedida;
    private float valorIngrediente;

    public int getIdproduto() {
        return idproduto;
    }

    public void setIdproduto(int idproduto) {
        this.idproduto = idproduto;
    }

    public int getIdprato() {
        return idprato;
    }

    public void setIdprato(int idprato) {
        this.idprato = idprato;
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
    
}
