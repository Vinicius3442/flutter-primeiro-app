// Desenvolvido por: Vinicius Montuani e Pietro Rennó

import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {'title': 'Curtida', 'body': 'Alguém curtiu sua postagem.', 'time': '2m ago', 'icon': Icons.favorite, 'color': Colors.red},
      {'title': 'Comentário', 'body': 'Pietro comentou: "Excelente trabalho!"', 'time': '15m ago', 'icon': Icons.comment, 'color': Colors.blue},
      {'title': 'Novo Seguidor', 'body': 'SENN.AI começou a seguir você.', 'time': '1h ago', 'icon': Icons.person_add, 'color': Colors.green},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        backgroundColor: const Color(0xFF0D47A1),
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final note = notifications[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: (note['color'] as Color).withOpacity(0.1),
              child: Icon(note['icon'] as IconData, color: note['color'] as Color),
            ),
            title: Text(note['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(note['body'] as String),
            trailing: Text(note['time'] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            onTap: () {},
          );
        },
      ),
    );
  }
}
