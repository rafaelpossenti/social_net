import 'package:flutter/material.dart';
import 'package:social_net/modelos/post.dart';
import 'dart:convert';
import 'package:social_net/detalhes/detalhes.dart';
import 'package:social_net/detalhes/comentarios.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return _construirHome();
  }

  Widget _construirHome() {
    return Scaffold(
        body: SizedBox(
            child: FutureBuilder<List>(
          future: getDataPost(),
          builder: (context, snapshot) {
            List<dynamic> posts = snapshot.data!;

            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                Post post = Post.fromJson(posts[index]);
                return _construirCard(post);
              },
              itemCount: posts == null ? 0 : posts.length,
            );
          },
        )),
        appBar: _construirAppBar('Rede Social'));
  }

  Future<List<dynamic>> getDataPost() async {
    final response = await http.get('http://localhost:8081/posts');
    if (response.statusCode == 200) {
      List<dynamic> lista = json.decode(response.body)['content'];
      print(lista);
      return lista;
    } else {
      throw Exception('Falha ao carregar dados...');
    }
  }

  Widget _construirCard(post) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Detalhes(post: post)));
        },
        child: Card(
            margin: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    _construirImagemCard(post.text),
                    _construirImagemGradienteCard(),
                    _construirTituloCard(post.userId),
                  ],
                ),
                new Column(children: <Widget>[_construirReactions(post)]),
              ],
            )));
  }

  Widget _construirImagemCard(String text) {
    return
//      ClipRRect(
//        borderRadius: BorderRadius.all(Radius.circular(6)),
//        child:
        // Image.asset(imagem, fit: BoxFit.fitHeight, height: 200);
        Text(text, textAlign: TextAlign.center);
//    );
  }

  Widget _construirImagemGradienteCard() {
    return Container(
        height: 200,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)])));
  }

  Widget _construirTituloCard(String titulo) {
    return Positioned(
        bottom: 10.0,
        left: 10.0,
        child:
            Text(titulo, style: TextStyle(color: Colors.white, fontSize: 20)));
  }

  Widget _construirReactions(post) {
    return Row(children: <Widget>[
      IconButton(
        icon: const Icon(Icons.mood),
        tooltip: 'icon mood',
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.mood_bad),
        tooltip: 'icon mood bad',
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.insert_comment),
        tooltip: 'icon insert comment',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Comentarios(post: post)));
        },
      ),
    ]);
  }

  AppBar _construirAppBar(String titulo) {
    return AppBar(title: Text(titulo));
  }
}
