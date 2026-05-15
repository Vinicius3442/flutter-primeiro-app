// Desenvolvido por: Vinicius Montuani e Pietro Rennó

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/glass_box.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('SENN Connect', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black.withValues(alpha: 0.5),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.message_outlined),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
          ),
        ],
      ),
      body: Consumer<PostProvider>(
        builder: (context, postProvider, _) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: postProvider.posts.length,
            itemBuilder: (context, index) {
              final post = postProvider.posts[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GlassBox(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey.withValues(alpha: 0.5),
                            child: Text(post.authorName[0], style: const TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(width: 12),
                          Text(post.authorName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(post.content, style: const TextStyle(fontSize: 15, color: Colors.white70)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              post.isLiked ? Icons.favorite : Icons.favorite_border,
                              color: post.isLiked ? Colors.white : Colors.white54,
                            ),
                            onPressed: () => postProvider.toggleLike(post.id),
                          ),
                          Text('${post.likes}', style: const TextStyle(color: Colors.white70)),
                          const SizedBox(width: 20),
                          IconButton(
                            icon: const Icon(Icons.chat_bubble_outline, color: Colors.white54),
                            onPressed: () {}, // Comment functionality
                          ),
                          const Text('Comentar', style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          border: const Border(top: BorderSide(color: Colors.white12, width: 1)),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: 0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          onTap: (index) {
            if (index == 2) {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explorar'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey.withValues(alpha: 0.8),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => _showAddPostDialog(context),
      ),
    );
  }

  void _showAddPostDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1C1E),
        title: const Text('Nova Postagem', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'O que você está pensando?',
            hintStyle: TextStyle(color: Colors.white54),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey)),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar', style: TextStyle(color: Colors.white54))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                final user = Provider.of<AuthProvider>(context, listen: false).user;
                Provider.of<PostProvider>(context, listen: false).addPost(
                  controller.text,
                  user?.email?.split('@')[0] ?? 'Usuário',
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Postar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
