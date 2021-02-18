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
public class ItemVenda {

    private int idItemVenda;
    private int qtdeVenda;
    private float valorVenda;
    private int idCardapioVenda;
    private Prato prato;

    public int getIdItemVenda() {
        return idItemVenda;
    }

    public void setIdItemVenda(int idItemVenda) {
        this.idItemVenda = idItemVenda;
    }

    public int getQtdeVenda() {
        return qtdeVenda;
    }

    public void setQtdeVenda(int qtdeVenda) {
        this.qtdeVenda = qtdeVenda;
    }

    public float getValorVenda() {
        return valorVenda;
    }

    public void setValorVenda(float valorVenda) {
        this.valorVenda = valorVenda;
    }

    public int getIdCardapioVenda() {
        return idCardapioVenda;
    }

    public void setIdCardapioVenda(int idCardapioVenda) {
        this.idCardapioVenda = idCardapioVenda;
    }

    public Prato getPrato() {
        return prato;
    }

    public void setPrato(Prato prato) {
        this.prato = prato;
    }

}