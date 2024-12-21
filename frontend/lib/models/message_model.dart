class MessageModel {
  final String id;
  final String content;
  final String senderId;
  final String receiverId;

  MessageModel({
    required this.id,
    required this.content,
    required this.senderId,
    required this.receiverId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'],
      content: json['content'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
    );
  }
}
