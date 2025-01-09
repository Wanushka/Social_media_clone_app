class Post {
  final String id;
  final String userName;
  final String userAvatar;
  final String content;
  final String? imageUrl;
  final DateTime timestamp;
  int likes;
  final List<Comment> comments;

  Post({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.content,
    this.imageUrl,
    required this.timestamp,
    this.likes = 0,
    required this.comments,
  });
}

class Comment {
  final String userName;
  final String userAvatar;
  final String content;
  final DateTime timestamp;

  Comment({
    required this.userName,
    required this.userAvatar,
    required this.content,
    required this.timestamp,
  });
}
