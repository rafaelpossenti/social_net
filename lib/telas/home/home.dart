import 'package:flutter/material.dart';
import 'package:social_net/modelos/post.dart';
import 'dart:convert';
import 'package:social_net/detalhes/detalhes.dart';

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
            child: FutureBuilder(
          future:
              DefaultAssetBundle.of(context).loadString('assets/posts.json'),
          builder: (context, snapshot) {
            List<dynamic> posts = json.decode(snapshot.data.toString());

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
                new Column(children: <Widget>[_construirReactions()]),
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

  Widget _construirReactions() {
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
        onPressed: () {},
      ),
    ]);
  }

  AppBar _construirAppBar(String titulo) {
    return AppBar(title: Text(titulo));
  }
}
