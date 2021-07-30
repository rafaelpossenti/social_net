class Comment {
  String? id;
  String? userId;
  String? postId;
  String? text;

  Comment({this.id, this.userId, this.postId, this.text});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    postId = json['postId'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['postId'] = this.postId;
    data['text'] = this.text;
    return data;
  }
}
