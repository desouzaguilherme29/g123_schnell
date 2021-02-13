import 'package:flutter/cupertino.dart';

getUrlServer() {
  return "http://192.168.0.101:80/guia/";
}

getUrlFotoPrincipal(String cidade, String telefone, String arquivo) {
  var imagem = "https://g123.com.br/publicidade/" +
      cidade +
      "/" +
      telefone +
      "/gifs/" +
      arquivo;
  return imagem;
}

getURLPatrocinadosRecentes({@required String filtro}) {
  if (filtro == "") filtro = "false";
  String url = "";
  url = getUrlServer() + "listaPatrocinadosRecentes.php";

  return url;
}

getURLAdicionadosRecentes({@required String filtro}) {
  if (filtro == "") filtro = "false";
  String url = "";
  url = getUrlServer() + "listaAdicionadosRecentes.php";

  return url;
}

getURLListaRamos({@required String filtro}) {
  if (filtro == "") filtro = "false";
  String url = "";
  url = getUrlServer() + "listaRamos.php?filtro=" + filtro;
  return url;
}

getURLDetalhesCliente(String telefone) {
  String url = "";
  url = getUrlServer() + "getdetalhescliente.php?telefone=" + telefone;
  return url;
}

getURLCidades() {
  String url = "";
  url = getUrlServer() + "cidades.php";
  print(url);
  return url;
}

getURLFonesUteis({@required String filtro}) {
  if (filtro == "") filtro = "false";
  String url = "";
  url = getUrlServer() + "getfonesuteis.php?filtro=" + filtro;
  return url;
}

getURLResultadoPesquisa({@required String filtro}){
  if (filtro == "") filtro = "false";
  String url = "";
  url = getUrlServer() + "getresultadopesquisa.php?filtro=" + filtro;
  print(url);
  return url;
}
