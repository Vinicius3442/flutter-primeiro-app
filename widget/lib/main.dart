import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FollowButtonPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FollowButtonPage extends StatefulWidget {
  const FollowButtonPage({super.key});

  @override
  State<FollowButtonPage> createState() => _FollowButtonPageState();
}

class _FollowButtonPageState extends State<FollowButtonPage> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rede social")),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isFollowing ? Colors.grey : Colors.blue,
            foregroundColor: Colors.white,
          ),
          onPressed: () => setState(() => isFollowing = !isFollowing),
          child: Text(isFollowing ? "Seguindo" : "Seguir"),
        ),
      ),
    );
  }
}