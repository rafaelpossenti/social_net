class Post {
  String? id;
  String? userId;
  String? text;

  Post({this.id, this.userId, this.text});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['text'] = this.text;
    return data;
  }
}
