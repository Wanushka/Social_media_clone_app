class PostModel {
  final String id;
  final String content;
  final String userId;

  PostModel({required this.id, required this.content, required this.userId});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['_id'],
      content: json['content'],
      userId: json['userId'],
    );
  }
}
