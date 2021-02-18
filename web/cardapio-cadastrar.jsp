<%-- 
    Document   : cardapio-cadastrar
    Created on : 8 de jan de 2021, 08:14:04
    Author     : Janine
--%>

<%@page import="utils.Web"%>
<%@page import="classes.PratoCardapio"%>
<%@page import="java.util.List"%>
<%@page import="classes.Prato"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Cadastro de cardápios" />
</jsp:include>
<%
    Prato prato = new Prato();
    List<Prato> pratos = prato.consultar();
%>
                <h1>Cadastro de cardápios</h1>
                <form action="cardapio-recebe-cadastrar.jsp" method="POST" onsubmit="return enviarForm()">
                    <input type="hidden" name="qtdePratos" id="qtdePratos" value="1"/>
                    <p class="txt-verde txt-center p-block">Campos com Preenchimento Obrigatório <span class="asterisco">*</span></p>
                    <div class="form-grupo">
                        <label>Nome do Cardápio <span class="asterisco">*</span></label>
                        <input  class="form-campo" type="text" name="desccardapio"/>
                        <div class="alerta alerta-vermelho d-none" id="erroDesc"></div>
                    </div>
                    <div class="form-grupo">
                        <label>Nº de Pessoas <span class="asterisco">*</span></label>
                        <input class="form-campo form-campo-w250 txt-right" type="text" name="qtdepessoas" id="qtdepessoas" onchange="calculaUnitario()"/>
                        <div class="alerta alerta-vermelho d-none" id="erroQtde"></div>
                    </div>
                    <div class="form-grupo">
                        <label>Preço por Pessoa</label>
                        <input class="form-campo form-campo-w250 txt-right" type="text" readonly="true" name="valorunitario" id="valorunitario"/>
                    </div>
                    <div class="form-grupo">
                        <label>Preço do Cardápio</label>
                        <input class="form-campo form-campo-w250 txt-right" type="text" readonly="true" name="valortotal" id="valortotal"/>
                    </div>
                    <div class="form-checkbox">
                        <input type="checkbox" name="buffetinterno" id="buffetinterno"/> 
                        <label class="form-check-label" for="buffetinterno">
                            Buffet Interno                                                               
                        </label>                            
                    </div>
                    
                    <div class="subform">
                        <div class="subform-header">
                            Lista de pratos do cardápio <span class="asterisco">*</span>
                        </div>
                        <div class="subform-body">
                            <table id="tabelaPratos">
                                <thead>
                                <th>Prato</th>
                                    <th>Preço</th>
                                </thead>
                                <tbody>
                                    <tr class="selection">
                                        <td> <!--Prato-->
                                            <select  class="form-campo" id="idprato1" name="idprato1" onchange="extraiPreco(this)">
                                                <option value=""></option>
                                                <%for (Prato pr : pratos) {%>
                                                    <option value="<%out.write(String.valueOf(pr.getIdPrato()));%>">
                                                        <%out.write(pr.getNome() + " - Rende: " + pr.getRendimento() + " porções - " 
                                                         + Web.moedaParaString(pr.getValorPrato()));%>
                                                    </option>
                                                <% } %>
                                            </select>
                                            <div class="alerta alerta-vermelho d-none" id="erroPrato1"></div>
                                        </td>
                                        <td><input class="form-campo txt-right" type="text" readonly="true" id="preco1"/></td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="alerta alerta-vermelho d-none" id="erroListaCardapios"></div>
                            <button type="button" class="btn btn-azul btn-block btn-sm" onclick="adicionar()"><i class="fas fa-plus"></i> Adicionar</button>
                        </div>
                    </div>
                    <div class="grupo-botoes">
                        <button type="submit" class="btn btn-verde">Salvar</button>
                        <button type="reset" class="btn btn-vermelho" onclick="document.location='index.jsp';">Cancelar</button>
                    </div>
                </form>
                                            
                <script>
                    function enviarForm() {
                        var semErros = true;

                        var desc = document.getElementsByName('desccardapio');
                        if (desc[0].value === '') {
                            document.getElementById('erroDesc').innerHTML = 'Informar o Nome do Cardápio';
                            document.getElementById('erroDesc').style = 'display: block';
                            semErros = false;
                        }
                        else {
                            document.getElementById('erroDesc').style = '';
                        }

                        var qtde = document.getElementsByName('qtdepessoas');
                        if (qtde[0].value === '') {
                            document.getElementById('erroQtde').innerHTML = 'Informar o Número de Pessoas';
                            document.getElementById('erroQtde').style = 'display: block';
                            semErros = false;
                        }
                        else {
                            document.getElementById('erroQtde').style = '';
                        }
                        
                        var qtdePratos = parseInt(document.getElementById('qtdePratos').value);
                        var qtdePratosOk = 0;
                        for (i = 1; i <= qtdePratos; i++) {
                            if (document.getElementById('idprato' + i).value != '') {
                                qtdePratosOk++;
                            }
                        }
                        
                        if (qtdePratosOk == 0) {
                            document.getElementById('erroListaCardapios').innerHTML = 'Informar pelo menos um prato.';
                            document.getElementById('erroListaCardapios').style = 'display: block';
                            semErros = false;
                        }
                        else {
                            document.getElementById('erroListaCardapios').style= '';
                        }
                        
                        return semErros;
                    }

                    function calculaUnitario() {
                        // if Para não calcular valor por pessoa caso os campos valor total ou nº de pessoas estiverem vazios
                        if (document.getElementById('valortotal').value != '' && document.getElementById('qtdepessoas').value != '') {
                            var precoPessoa = 0;
                            precoPessoa = parseFloat(document.getElementById('valortotal').value.replace('R$', '').replace(',', '.').trim()) / 
                                parseInt(document.getElementById('qtdepessoas').value);
                            document.getElementById('valorunitario').value = 'R$ ' + precoPessoa.toFixed(2).replace('.', ',');
                        }
                    }

                    function extraiPreco(listaPratos) {
                        // Pega o texto selecionado no elemento 'select'
                        var pratoSelecionado = listaPratos.options[listaPratos.selectedIndex].text;
                        // "Quebra" o texto usando o '-' como delimitador (retorna um array)
                        var partes = pratoSelecionado.split('-');
                        //terceiro elemento
                        var partePreco = partes[2];
                        // Troca ',' por '.', retira o 'R$ ' e converte em float
                        // Trim retira os espaços em branco no início e fim
                        var preco = parseFloat(partePreco.replace(',', '.').replace('R$', '').trim()); 
                        //Extrai o número de ordem do prato na lista de cardápio
                        var i = parseInt(listaPratos.id.replace('idprato', '' ));
                        document.getElementById('preco' + i).value = 'R$ ' + preco.toFixed(2).replace('.', ',');
                        var qtdePratos = parseInt(document.getElementById('qtdePratos').value);
                        var totalCardapio = 0;
                        for (p = 1; p <= qtdePratos; p++) {
                            totalCardapio += parseFloat(document.getElementById('preco' + p).value.replace(',', '.').replace('R$ ',''));
                        }
                        document.getElementById('valortotal').value = 'R$ ' + totalCardapio.toFixed(2).replace('.', ',');
                        calculaUnitario();
                    }

                    function adicionar() {
                        document.getElementById('qtdePratos').value = parseInt(document.getElementById('qtdePratos').value) + 1; // incrementa a quantidade de itens do campo oculto (type hidden)
                        var tr = document.createElement('tr'); // cria novo tr class selection da tabela
                        tr.className = 'selection'; // define a classe da tr acima

                        // montagem da lista para adicionar o prato
                        var td = document.createElement('td'); // cria novo td da tabela
                        var select = document.querySelector('select[name=idprato1]').cloneNode(true); // clona a parte de select do produto
                        select.id = 'idprato' + document.getElementById('qtdePratos').value; // define o id do elemento clonado
                        select.name = 'idprato' + document.getElementById('qtdePratos').value; // define o name do elemento clonado
                        select.selectedIndex = 0; // seleciona o option vazio no select
                        select.setAttribute('onchange', 'extraiPreco(this)');
                        select.className = "form-campo";
                        var divErro = document.createElement('div'); // cria novo label para a mensagem de Erro
                        divErro.id = 'erroPrato' + document.getElementById('qtdePratos').value; // define o novo id para o novo labelErro
                        divErro.className = 'alerta alerta-vermelho d-none'; // cria novo class error
                        td.appendChild(select); // anexa o select ao td
                        td.appendChild(divErro); // anexa o labelErro ao td
                        tr.appendChild(td); // anexa todos os itens de td acima no tr

                        // montagem da lista para adicionar o preço do prato
                        var td = document.createElement('td'); // cria novo td da tabela
                        var input = document.createElement('input');
                        input.id = 'preco' + document.getElementById('qtdePratos').value; // define o id do elemento clonado
                        input.setAttribute('readonly', true);
                        input.setAttribute('type', 'text');
                        input.className = "form-campo";
                        td.appendChild(input); // anexa o select ao td
                        tr.appendChild(td); // anexa todos os itens de td acima no tr

                        document.getElementById('tabelaPratos').appendChild(tr); // anexa nova linha na tabela, para os itens acima
                    }
                </script>
<jsp:include page = "footer.jsp"/>
