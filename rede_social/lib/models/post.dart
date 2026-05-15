// Desenvolvido por: Vinicius Montuani e Pietro Rennó

class Post {
  final String id;
  final String authorName;
  final String content;
  int likes;
  final DateTime createdAt;
  bool isLiked;

  Post({
    required this.id,
    required this.authorName,
    required this.content,
    this.likes = 0,
    required this.createdAt,
    this.isLiked = false,
  });
}
