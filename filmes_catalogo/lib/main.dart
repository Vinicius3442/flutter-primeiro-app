import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class Movie {
  final String title;
  final int position;
  final String imageUrl;
  final String synopsis;

  Movie({
    required this.title,
    required this.position,
    required this.imageUrl,
    required this.synopsis,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Filmes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MovieListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Criei esse Widget para resolver o problema de misturar imagens locais (assets) com links da web
class CapaFilme extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;

  const CapaFilme({super.key, required this.url, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    // Se a string começar com http, ele baixa da internet. Se não, pega da pasta assets.
    if (url.startsWith('http')) {
      return Image.network(
        url,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: width ?? 50),
      );
    } else {
      return Image.asset(
        url,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Icon(Icons.movie, size: width ?? 50),
      );
    }
  }
}

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
    List<Movie> movies = [
    Movie(
      title: "The Thing",
      position: 1,
      imageUrl: "assets/filme1.jpg",
      synopsis: "In Antarctica, an isolated group of American scientists finds the frozen remains of an alien organism...",
    ),
    Movie(
      title: "Star Wars: Episode III",
      position: 2,
      imageUrl: "assets/filme2.jpg",
      synopsis: "The Clone Wars are in full swing and Anakin Skywalker maintains a bond of loyalty with Palpatine...",
    ),
    Movie(
      title: "Alien",
      position: 3,
      imageUrl: "assets/filme3.jpg",
      synopsis: "The crew of the interstellar freighter Nostromo is awakened in the middle of their journey home by strange distress signals...",
    ),
    Movie(
      title: "The Lord of the Rings: The Return of the King",
      position: 4,
      imageUrl: "assets/filme4.jpg",
      synopsis: "Sauron prepares an attack on Minas Tirith. Gandalf and Pippin leave to help defend the capital...",
    ),
    Movie(
      title: "Interstellar",
      position: 5,
      imageUrl: "assets/filme5.jpg",
      synopsis: "Earth's natural reserves are coming to an end and a group of astronauts receives the mission...",
    ),
    Movie(
      title: "The Lord of the Rings: The Two Towers",
      position: 6,
      imageUrl: "assets/filme6.jpg",
      synopsis: "After the capture of Merry and Pippin by the orcs, the Fellowship of the Ring is dissolved...",
    ),
    Movie(
      title: "The Lord of the Rings: The Fellowship of the Ring",
      position: 7,
      imageUrl: "assets/filme7.jpg",
      synopsis: "In a fantastic and unique land, a hobbit receives a magical and evil ring as a gift from his uncle...",
    ),
    Movie(
      title: "Star Wars: Episode V",
      position: 8,
      imageUrl: "assets/filme8.jpg",
      synopsis: "Yoda trains Luke Skywalker to be a Jedi knight. Han Solo courts Princess Leia while Darth Vader returns...",
    ),
    Movie(
      title: "2001: A Space Odyssey",
      position: 9,
      imageUrl: "assets/filme9.jpg",
      synopsis: "Since prehistory, a mysterious black monolith seems to emit signals from another civilization...",
    ),
    Movie(
      title: "The Dark Knight",
      position: 10,
      imageUrl: "assets/filme10.jpg",
      synopsis: "Batman has managed to maintain order in Gotham with the help of Jim Gordon and Harvey Dent...",
    ),
  ];

  final TextEditingController _movieController = TextEditingController();
  final TextEditingController _imageController = TextEditingController(); // Novo controlador para a imagem
  Color _backgroundColor = Colors.white;

  void _addMovie() {
    if (_movieController.text.isNotEmpty) {
      setState(() {
        movies.add(Movie(
          title: _movieController.text,
          position: movies.length + 1,
          // Se o cara não colocar link, a gente joga uma imagem vazia pra não quebrar
          imageUrl: _imageController.text.isNotEmpty ? _imageController.text : 'sem-imagem',
          synopsis: 'Sinopse não disponível para filmes adicionados manualmente.',
        ));
        _movieController.clear();
        _imageController.clear(); // Limpa o campo da imagem também
      });
    }
  }

  void _removeMovie(int index) {
    setState(() {
      movies.removeAt(index);
    });
  }

  void _changeBackgroundColor() {
    setState(() {
      _backgroundColor = Color.fromRGBO(
        200 + Random().nextInt(56),
        200 + Random().nextInt(56),
        200 + Random().nextInt(56),
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Catálogo de Filmes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: _changeBackgroundColor,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            // Mudei para Column para caber os dois TextFields de boa
            child: Column(
              children: [
                TextField(
                  controller: _movieController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do filme',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _imageController,
                  decoration: const InputDecoration(
                    labelText: 'Link da imagem (URL)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _addMovie,
                    child: const Text('Adicionar'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      // Chamando nosso Widget inteligente aqui
                      child: CapaFilme(
                        url: movies[index].imageUrl,
                        width: 50,
                        height: 70,
                      ),
                    ),
                    title: Text(movies[index].title),
                    subtitle: Text('Posição: ${movies[index].position}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeMovie(index),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsScreen(
                            movie: movies[index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              // E chamando ele aqui nos detalhes também
              child: CapaFilme(
                url: movie.imageUrl,
                height: 300,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              movie.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Posição no ranking: ${movie.position}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 20),
            const Text('Sinopse:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(movie.synopsis, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Voltar para a lista'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}