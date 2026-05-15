import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Pesquisar no SENN Connect...',
              prefixIcon: const Icon(Icons.search, color: Colors.white70),
              border: InputBorder.none,
              hintStyle: const TextStyle(color: Colors.white70, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 21,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/500/500?random=$index'),
                  fit: BoxFit.cover,
                ),
              ),
            )
            .animate()
            .fade(duration: 500.ms, delay: (index * 30).ms)
            .scale(delay: (index * 30).ms, curve: Curves.easeOutBack);
          },
        ),
      ),
    );
  }
}
