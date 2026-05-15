// Desenvolvido por: Vinicius Montuani e Pietro Rennó

import 'package:flutter/material.dart';
import '../widgets/glass_box.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {'title': 'Curtida', 'body': 'Alguém curtiu sua postagem.', 'time': '2m ago', 'icon': Icons.favorite, 'color': Colors.blueGrey},
      {'title': 'Comentário', 'body': 'Pietro comentou: "Excelente trabalho!"', 'time': '15m ago', 'icon': Icons.comment, 'color': Colors.white70},
      {'title': 'Novo Seguidor', 'body': 'SENN.AI começou a seguir você.', 'time': '1h ago', 'icon': Icons.person_add, 'color': Colors.white70},
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Notificações'),
        backgroundColor: Colors.black.withValues(alpha: 0.5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final note = notifications[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GlassBox(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: (note['color'] as Color).withValues(alpha: 0.1),
                  child: Icon(note['icon'] as IconData, color: note['color'] as Color),
                ),
                title: Text(note['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                subtitle: Text(note['body'] as String, style: const TextStyle(color: Colors.white70)),
                trailing: Text(note['time'] as String, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                onTap: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
