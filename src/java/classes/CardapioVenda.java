/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Janine
 */
public class CardapioVenda {
    private int idCardapioVenda;
    private int idCardapio;
    private int idVenda;
    private List<ItemVenda> itens = new ArrayList<>();
    
    public void adicionarItem(ItemVenda item) {
        itens.add(item);
    }
    
    public Float getValorTotal() { //totaliza a venda e retorna o valor total
        float valorTotal = 0;
        for (ItemVenda item : this.itens) {
            valorTotal += item.getValorVenda();
        }
        return valorTotal;
    }
    
    public int getIdCardapioVenda() {
        return idCardapioVenda;
    }

    public void setIdCardapioVenda(int idCardapioVenda) {
        this.idCardapioVenda = idCardapioVenda;
    }

    public int getIdCardapio() {
        return idCardapio;
    }

    public void setIdCardapio(int idCardapio) {
        this.idCardapio = idCardapio;
    }

    public int getIdVenda() {
        return idVenda;
    }

    public void setIdVenda(int idVenda) {
        this.idVenda = idVenda;
    }

    public List<ItemVenda> getItens() {
        return itens;
    }

    public void setItens(List<ItemVenda> itens) {
        this.itens = itens;
    }
    
    
}
