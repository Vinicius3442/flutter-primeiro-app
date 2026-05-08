import 'package:flutter/material.dart';

void main() {
  runApp(const MeuTop10App());
}

class MeuTop10App extends StatelessWidget {
  const MeuTop10App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const ListaFilmesPage(),
    );
  }
}

class Filme {
  final String nome;
  final int posicao;
  final String imagemurl;
  final String sinopse;

  Filme({
    required this.nome,
    required this.posicao,
    required this.imagemurl,
    required this.sinopse,
  });
}

class ListaFilmesPage extends StatefulWidget {
  const ListaFilmesPage({super.key});

  @override
  State<ListaFilmesPage> createState() => _ListaFilmesPageState();
}

class _ListaFilmesPageState extends State<ListaFilmesPage> {

  List<Filme> filmes = [
    Filme(
      nome: "O enigma de outro mundo",
      posicao: 1,
      imagemurl: "assets/filme1.jpg",
      sinopse: "Na Antártida, um grupo isolado de cientistas norte-americanos encontra os restos congelados de um organismo alienígena. Quando a criatura assume a forma de um dos cachorros da base de pesquisas, os cientistas descobrem que ela pode simular a aparência de qualquer ser vivo. A equipe corre contra o tempo em uma batalha desesperada para destruir o extraterrestre antes que seja tarde demais.",
    ),
    Filme(
      nome: "Star wars episodio III",
      posicao: 2,
      imagemurl: "assets/filme2.jpg",
      sinopse: "As Guerras Clônicas estão em pleno andamento e Anakin Skywalker mantém um elo de lealdade com Palpatine, ao mesmo tempo em que luta para que seu casamento com Padmé Amidala não seja afetado por esta situação. Seduzido por promessas de poder, Anakin se aproxima cada vez mais de Darth Sidious até se tornar o temível Darth Vader. Juntos eles tramam um plano para aniquilar de uma vez por todas com os cavaleiros jedi.",
    ),
    Filme(
      nome: "Alien, o oitavo passageiro",
      posicao: 3,
      imagemurl: "assets/filme3.jpg",
      sinopse: "A tripulação do cargueiro interestelar Nostromo é despertada no meio da viagem para casa por estranhos sinais de socorro vindos de uma nave alienígena em um planeta aparentemente deserto. Enquanto a equipe investiga, um dos tripulantes é atacado por um organismo, que leva o embrião de um alienígena para dentro da Nostromo. Na espaçonave, a medonha criatura começa a crescer em um ritmo frenético e persegue de forma implacável todos os tripulantes.",
    ),
    Filme(
      nome: "Senhor dos aneis o retorno do rei",
      posicao: 4,
      imagemurl: "assets/filme4.jpg",
      sinopse: "Sauron prepara ataque à Minas Tirith. Gandalf e Pippin partem para ajudar na defesa da capital de Gondor. Enquanto isso, Frodo, Sam e Gollum continuam sua jornada para destruir o Anel na Montanha da Perdição.",
    ),
    Filme(
      nome: "Interstellar",
      posicao: 5,
      imagemurl: "assets/filme5.jpg",
      sinopse: "As reservas naturais da Terra estão chegando ao fim e um grupo de astronautas recebe a missão de verificar possíveis planetas para receberem a população mundial, possibilitando a continuação da espécie. Cooper é chamado para liderar o grupo e aceita a missão sabendo que pode nunca mais ver os filhos. Ao lado de Brand, Jenkins e Doyle, ele seguirá em busca de um novo lar.",
    ),
    Filme(
      nome: "Senhor dos aneis as duas torres",
      posicao: 6,
      imagemurl: "assets/filme6.jpg",
      sinopse: "Após a captura de Merry e Pippin pelos orcs, a Sociedade do Anel é dissolvida. Frodo e Sam seguem sua jornada rumo à Montanha da Perdição para destruir o anel e descobrem que estão sendo perseguidos pelo misterioso Gollum. Enquanto isso, Aragorn, o elfo e arqueiro Legolas e o anão Gimli partem para resgatar os hobbits sequestrados e chegam ao reino de Rohan, onde o rei Théoden foi vítima de uma maldição mortal de Saruman.",
    ),
    Filme(
      nome: "Senhor dos aneis a sociedade do anel",
      posicao: 7,
      imagemurl: "assets/filme7.jpg",
      sinopse: "Em uma terra fantástica e única, um hobbit recebe de presente de seu tio um anel mágico e maligno que precisa ser destruído antes que caia nas mãos do mal. Para isso, o hobbit Frodo tem um caminho árduo pela frente, onde encontra perigo, medo e seres bizarros. Ao seu lado para o cumprimento desta jornada, ele aos poucos pode contar com outros hobbits, um elfo, um anão, dois humanos e um mago, totalizando nove seres que formam a Sociedade do Anel.",
    ),
    Filme(
      nome: "Star Wars episodio V",
      posicao: 8,
      imagemurl: "assets/filme8.jpg",
      sinopse: "Yoda treina Luke Skywalker para ser um cavaleiro Jedi. Han Solo corteja a Princesa Leia enquanto Darth Vader retorna para combater as forças rebeldes que tentam salvar a galáxia.",
    ),
    Filme(
      nome: "2001: Uma odisséia no espaço",
      posicao: 9,
      imagemurl: "assets/filme9.jpg",
      sinopse: "Desde a pré-história, um misterioso monolito negro parece emitir sinais de outra civilização interferindo no planeta Terra. Quatro milhões de anos depois, no século 21, uma equipe de astronautas liderados pelos experientes David Bowman e Frank Poole é enviada a Júpiter para investigar o enigmático monolito na nave Discovery, totalmente controlada pelo computador HAL 9000. Entretanto, no meio da viagem, HAL entra em pane e tenta assumir o controle da nave, decidindo assim eliminar os tripulantes.",
    ),
    Filme(
      nome: "batman o cavaleiro das trevas",
      posicao: 10,
      imagemurl: "assets/filme10.jpg",
      sinopse: "Batman tem conseguido manter a ordem em Gotham com a ajuda de Jim Gordon e Harvey Dent. No entanto, um jovem e anárquico criminoso, conhecido apenas como Coringa, pretende testar o Cavaleiro das Trevas e mergulhar a cidade em caos.",
    ),
  ];

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _posicaoController = TextEditingController();
  final TextEditingController _imagemController = TextEditingController();
  final TextEditingController _sinopseController = TextEditingController();

  void _adicionarFilme() {
    setState(() {
      filmes.add(
        Filme(
          nome: _nomeController.text,
          posicao: int.tryParse(_posicaoController.text) ?? filmes.length + 1,
          imagemurl: _imagemController.text,
          sinopse: _sinopseController.text,
        ),
      );
    });

    _nomeController.clear();
    _posicaoController.clear();
    _imagemController.clear();
    _sinopseController.clear();

    Navigator.of(context).pop();
  }

  void _abrirModalCadastro() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Adicionar Novo Filme',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _nomeController,
                  decoration: const InputDecoration(labelText: 'Nome do Filme'),
                ),
                TextField(
                  controller: _posicaoController,
                  decoration: const InputDecoration(labelText: 'Posição no Top 10'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _imagemController,
                  decoration: const InputDecoration(labelText: 'URL da Imagem (Link da net)'),
                ),
                TextField(
                  controller: _sinopseController,
                  decoration: const InputDecoration(labelText: 'Sinopse'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _adicionarFilme,
                  child: const Text('Salvar Filme'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    filmes.sort((a, b) => a.posicao.compareTo(b.posicao));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Top 10 Filmes'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: filmes.length,
        itemBuilder: (context, index) {
          final filme = filmes[index];
          return ListTile(
            leading: Image.asset(
              filme.imagemurl,
              width: 50,
              height: 75,
              fit: BoxFit.cover,
            ),
            title: Text('${filme.posicao} - ${filme.nome}'),
            subtitle: Text(
              filme.sinopse,
              overflow: TextOverflow.ellipsis,
            ),
    
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _abrirModalCadastro,
        child: const Icon(Icons.add),
      ),
    );
  }
}