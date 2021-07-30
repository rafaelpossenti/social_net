import 'package:flutter/material.dart';
import 'package:social_net/modelos/post.dart';
import 'package:social_net/modelos/comment.dart';
import 'dart:convert';

class Comentarios extends StatelessWidget {
  final Post? post;

  Comentarios({Key? key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _construirDetalhes(context);
  }

  Widget _construirDetalhes(context) {
    return Scaffold(
        body: SizedBox(
            child: FutureBuilder(
          future:
              DefaultAssetBundle.of(context).loadString('assets/comments.json'),
          builder: (context, snapshot) {
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter to insert a new comment'),
            );
            List<dynamic> comments = json.decode(snapshot.data.toString());
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                Comment comment = Comment.fromJson(comments[index]);
                return _construirCard(comment);
              },
              itemCount: comments == null ? 0 : comments.length,
            );
          },
        )),
        appBar: _construirAppBar('Comentarios'));
  }

  Widget _construirCard(comment) {
    return GestureDetector(
        child: Card(
            margin: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    _construirImagemCard(comment.text),
                  ],
                ),
              ],
            )));
  }

  Widget _construirImagemCard(String text) {
    return Row(children: [
      CircleAvatar(
          backgroundImage: NetworkImage(
              "https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes-thumbnail.png")),
      SizedBox(width: 10),
      Text(text, textAlign: TextAlign.justify)
    ]);
  }

  AppBar _construirAppBar(String titulo) {
    return AppBar(title: Text(titulo));
  }
}
