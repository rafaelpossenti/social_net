import 'package:flutter/material.dart';
import 'package:social_net/modelos/receita.dart';

class Detalhes extends StatelessWidget {
  final Receita? receita;

  Detalhes({Key? key, @required this.receita}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _construirDetalhes();
  }

  Widget _construirDetalhes() {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          _construirImagemDetalhes(receita!.foto!),
          // _construirTituloDetalhes(receita!.titulo!),

          _construirLinhaIconesDetalhes(
              receita!.tempoPreparo!, '${receita!.porcoes!} porções'),

          _construirTextoDetalhes(receita!.ingredientes!),

          // _construirSubtitulosDetalhes('Ingredientes'),

          // _construirSubtitulosDetalhes('Modo de preparo'),
          // _construirTextoDetalhes(receita!.modoPreparo!)
        ],
      ),
      appBar: _construirAppBar('Rede Social'),
    );
  }

  Widget _construirImagemDetalhes(String imagem) {
    return Image.asset(imagem);
  }

  Widget _construirTituloDetalhes(String titulo) {
    return Center(
      child: Text(titulo,
          style: TextStyle(color: Colors.deepOrange, fontSize: 30)),
    );
  }

  Widget _construirSubtitulosDetalhes(String subtitulo) {
    return Center(child: Text(subtitulo, style: TextStyle(fontSize: 20)));
  }

  Widget _construirTextoDetalhes(String texto) {
    return Container(child: Text(texto, textAlign: TextAlign.justify));
  }

  AppBar _construirAppBar(String titulo) {
    return AppBar(title: Text(titulo));
  }

  Widget _construirLinhaIconesDetalhes(String tempo, String rendimento) {
    return Row(
        children: <Widget>[Icon(Icons.mood, color: Colors.black),
                        Icon(Icons.mood_bad, color: Colors.black),
                        Icon(Icons.insert_comment, color: Colors.black)]);
  }
}
