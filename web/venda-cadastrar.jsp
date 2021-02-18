<%-- 
    Document   : venda-cadastrar
    Created on : 15 de jan. de 2021, 10:42:57
    Author     : entra21
--%>

<%@page import="utils.Web"%>
<%@page import="classes.Cardapio"%>
<%@page import="java.util.List"%>
<%@page import="classes.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8"); //para não desconfigurar a acentuação
%>
<jsp:include page = "header.jsp">
    <jsp:param name="tituloPagina" value="Cadastro de Vendas" />
</jsp:include>
                <h1>Cadastro de Vendas</h1>
                <%
                    request.setCharacterEncoding("UTF-8");
                    
                    Cliente cliente = new Cliente();
                    List<Cliente> clientes = cliente.consultar();
                    
                    Cardapio cardapio = new Cardapio();
                    List<Cardapio> cardapios = cardapio.consultar();
                %>

                <form action="venda-cadastrar-prato.jsp" method="POST" onsubmit="return enviarForm()">
                    <input type="hidden" name="qtdeCardapios" id="qtdeCardapios" value="1"/>
                    <p class="txt-verde txt-center p-block">Campos com Preenchimento Obrigatório <span class="asterisco">*</span></p>
                    

                    <div class="form-grupo">
                        <label>Selecione o Cliente <span class="asterisco">*</span></label>                        
                        <select class="form-campo" name="idcliente">
                            <option value=""></option>
                            <%for (Cliente cli : clientes) {%>
                            <option value="<%out.write(String.valueOf(cli.getIdCliente()));%>">
                                <%out.write(cli.getNome());%>
                            </option>
                            <% } %>
                        </select>              
                        <div class="alerta alerta-vermelho d-none" id="erroCli"></div>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Data do Orçamento</label>
                        <input class="form-campo form-campo-w250" type="date" name="dataorcamento"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Data do Pedido</label>
                        <input class="form-campo form-campo-w250" type="date" name="datapedido"/>
                    </div>
                    
                    <div class="form-grupo">
                        <label>Data de Produção</label>
                        <input class="form-campo form-campo-w250" type="date" name="dataproducao"/>
                    </div>
                        
                    <div class="form-checkbox">
                        <input type="checkbox" name="producao" id="producao"/> 
                        <label class="form-check-label" for="producao">
                            Produção
                        </label>                            
                    </div>
                    
                    <div class="subform">
                        <div class="subform-header">
                            Itens <span class="asterisco">*</span>
                        </div>
                        <div class="subform-body">
                            <table id="tabelaCardapios">
                                <thead>
                                <th>Selecione o(s) Cardápio(s) <span class="asterisco">*</span></th>
                                    <th>Valor do Cardápio</th>
                                </thead>
                                <tbody>
                                    <tr class="selection">
                                        <td>
                                            <select class="form-campo" id="idcardapio1" name="idcardapio1" onchange="extraiPreco(this)">
                                                <option value=""></option>
                                                <%for (Cardapio menu : cardapios) {%>
                                                    <option value="<%out.write(String.valueOf(menu.getIdCardapio()));%>">
                                                    <%out.write(menu.getDescCardapio() + " - Serve " + menu.getQtdePessoas() 
                                                    + " pessoas - " + Web.moedaParaString(menu.getValorTotal()));%>
                                                    </option>
                                                <% } %>
                                            </select>
                                            <div class="alerta alerta-vermelho d-none" id="erroCardapio1"></div>
                                        </td>
                                        <td><input class="form-campo txt-right" type="text" readonly="true" id="preco1"/></td>
                                    </tr>
                                </tbody>
                            </table>
                            <button type="button" class="btn btn-azul btn-sm btn-block" onclick="adicionar()"><i class="fas fa-plus"></i> Adicionar</button>
                        </div>
                    </div>
                    
                    <div class="grupo-botoes">
                        <button type="submit" class="btn btn-verde">Informar pratos</button>
                        <button type="reset" class="btn btn-vermelho" onclick="document.location='index.jsp';">Cancelar</button>
                    </div>
                </form>
        <script>
            function enviarForm() {
                var semErros = true;

                var idcliente = document.getElementsByName("idcliente");
                if (idcliente[0].value === "") {
                    document.getElementById("erroCli").innerHTML = "Informar o Cliente";
                    document.getElementById("erroCli").style = "display: block";
                    semErros = false;
                }
                else {
                    document.getElementById("erroCli").style = "";
                }                
                
                return semErros;
            }

            function extraiPreco(listaCardapios) {
                // Pega o texto selecionado no elemento 'select'
                var cardapioSelecionado = listaCardapios.options[listaCardapios.selectedIndex].text;
                // "Quebra" o texto usando o '-' como delimitador (retorna um array)
                var partes = cardapioSelecionado.split('-');
                //terceiro elemento
                var partePreco = partes[2];
                // Troca ',' por '.', retira o 'R$ ' e converte em float
                // Trim retira os espaços em branco no início e fim
                var preco = parseFloat(partePreco.replace(',', '.').replace('R$', '').trim()); 
                //Extrai o número de ordem do prato na lista de cardápio
                var i = parseInt(listaCardapios.id.replace('idcardapio', ''));
                document.getElementById('preco' + i).value = 'R$ ' + preco.toFixed(2).replace('.', ',');
            }

            
            function adicionar() {
                document.getElementById('qtdeCardapios').value = parseInt(document.getElementById('qtdeCardapios').value) + 1; // incrementa a quantidade de itens do campo oculto (type hidden)
                var tr = document.createElement('tr'); // cria novo tr class selection da tabela
                tr.className = 'selection'; // define a classe da tr acima

                // montagem da lista para adicionar o cardápio
                var td = document.createElement('td'); // cria novo td da tabela
                var select = document.querySelector('select[name=idcardapio1]').cloneNode(true); // clona a parte de select do produto
                select.id = 'idcardapio' + document.getElementById('qtdeCardapios').value;
                select.name = 'idcardapio' + document.getElementById('qtdeCardapios').value; // define o name do elemento clonado
                select.selectedIndex = 0; // seleciona o option vazio no select
                select.setAttribute('onchange', 'extraiPreco(this)');
                select.className = 'form-campo';
                var divErro = document.createElement('div'); // cria novo label para a mensagem de Erro
                divErro.id = 'erroCardapio' + document.getElementById('qtdeCardapios').value; // define o novo id para o novo labelErro
                divErro.className = 'alerta alerta-vermelho d-none'; // cria novo class error
                td.appendChild(select); // anexa o select ao td
                td.appendChild(divErro); // anexa o labelErro ao td
                tr.appendChild(td); // anexa todos os itens de td acima no tr

                // montagem da lista para adicionar o preço do prato
                var td = document.createElement('td'); // cria novo td da tabela
                var input = document.createElement('input');
                input.id = 'preco' + document.getElementById('qtdeCardapios').value; // define o id do elemento clonado
                input.setAttribute('readonly', true);
                input.className = 'form-campo txt-right'
                input.setAttribute('type', 'text');
                td.appendChild(input); // anexa o select ao td
                tr.appendChild(td); // anexa todos os itens de td acima no tr
                
                document.getElementById('tabelaCardapios').appendChild(tr); // anexa nova linha na tabela, para os itens acima
            }
        </script>
<jsp:include page = "footer.jsp"/>
