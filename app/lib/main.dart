import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String nomeDigitado = ""; // Variável para armazenar o nome

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minha Aplicação de Boas-Vindas"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Adicionando o ícone igual ao do botão na AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => print("Ícone da barra pressionado!"),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Bem-vindo ao mundo Flutter!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            // Subtítulo adicionado
            const Text(
              "Explorando widgets básicos",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            // Exibição do nome
            Text(
              nomeDigitado,
              style: const TextStyle(fontSize: 28, color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  nomeDigitado = "Vinicius";
                });
              },
              child: const Text("Mostrar meu nome"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Botão pressionado!");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}