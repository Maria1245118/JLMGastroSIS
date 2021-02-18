
package utils;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Web {
    
    //inicia o checkbox como false
    public static Boolean valorCheckbox(String checkbox) {
        return (checkbox != null);
    }

    //converte Boolean em String - desconsiderar null retornando ""
    public static Boolean stringParaBoolean(String valor) {
        return ("SIM".equals(valor));
    }

    //converte Boolean em String - desconsiderar null retornando ""
    public static String booleanParaString(Boolean valor) {
        return (valor ? "SIM" : "NÃO");
    }
    
    //converte String em Inteiro - null se não tiver dado informado
    public static Integer valorInteger(String valor) {
        return (valor != null && valor != "") ? Integer.parseInt(valor) : null;
    }
    
    //converte String em Inteiro - null se não tiver dado informado
    public static Float valorFloat(String valor) {
        return (valor != null && valor != "") ? Float.parseFloat(valor) : null;
    }
    
    //converte String em Data - null se não tiver dado informado
    public static LocalDate valorDate(String data) {
        return (data != null && data != "") ? LocalDate.parse(data) : null;
    }

    //converte Data em String - desconsiderar null retornando ""
    public static String dataParaString(LocalDate data) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        //return (data != null) ? String.valueOf(data) : "";
        return (data != null) ? formatter.format(data) : "";
    }

    //converte Inteiro em String - desconsiderar null retornando ""
    public static String inteiroParaString(Integer valor) {
        return (valor != null) ? String.valueOf(valor) : "";
    }
    
    //converte Float em String - desconsiderar null retornando ""
    public static String floatParaString(Float valor) {
        return (valor != null) ? String.valueOf(valor) : "";
    }

    //converte moeda em String - desconsiderar null retornando ""
    public static String moedaParaString(Float valor) {
        return NumberFormat.getCurrencyInstance().format(valor);
    }
    
    public static String arredondaValor(Float valor) {
        DecimalFormat df = new DecimalFormat("0.00");
        return df.format(valor);
    }

}
