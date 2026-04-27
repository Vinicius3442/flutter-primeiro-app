import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SorteadorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SorteadorPage extends StatefulWidget {
  const SorteadorPage({super.key});

  @override
  State<SorteadorPage> createState() => _SorteadorPageState();
}

class _SorteadorPageState extends State<SorteadorPage> {
  int numeroSorteado = 0;

  void sortear() {
    setState(() {
      numeroSorteado = Random().nextInt(100) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sorteador SENAI")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("O número sorteado é:", style: TextStyle(fontSize: 20)),
            Text("$numeroSorteado", style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: sortear,
              child: const Text("Tentar a Sorte"),
            ),
          ],
        ),
      ),
    );
  }
}