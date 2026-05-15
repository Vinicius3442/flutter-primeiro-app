// Desenvolvido por: Vinicius Montuani e Pietro Rennó

import 'package:flutter/material.dart';
import '../models/post.dart';

class PostProvider extends ChangeNotifier {
  final List<Post> _posts = [
    Post(
      id: '1',
      authorName: 'SENN.AI Admin',
      content: 'Bem-vindos ao SENN Connect! Nossa rede social oficial.',
      likes: 12,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Post(
      id: '2',
      authorName: 'Vinicius Montuani',
      content: 'Desenvolvendo o MVP em Flutter. Está ficando ótimo!',
      likes: 8,
      createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
    ),
  ];

  List<Post> get posts => [..._posts];

  void toggleLike(String postId) {
    final index = _posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      if (_posts[index].isLiked) {
        _posts[index].likes--;
      } else {
        _posts[index].likes++;
      }
      _posts[index].isLiked = !_posts[index].isLiked;
      notifyListeners();
    }
  }

  void addPost(String content, String authorName, {String? authorImageUrl}) {
    _posts.insert(
      0,
      Post(
        id: DateTime.now().toString(),
        authorName: authorName,
        authorImageUrl: authorImageUrl,
        content: content,
        createdAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
