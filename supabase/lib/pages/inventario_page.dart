import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/produto.dart';

class InventarioPagina extends StatefulWidget {
  const InventarioPagina({super.key});

  @override
  State<InventarioPagina> createState() => _InventarioPaginaState();
}

class _InventarioPaginaState extends State<InventarioPagina> with SingleTickerProviderStateMixin {
  final supabase = Supabase.instance.client;
  
  final _nomeController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _precoController = TextEditingController();
  
  Uint8List? _imagemBytes;
  String? _imagemNome;
  bool _isLoading = false;

  late Future<List<Produto>> _produtosFuture;

  final Color soulColor = const Color(0xFFE0F7FA);
  final Color voidColor = const Color(0xFF111111);
  final Color infectionColor = const Color(0xFFFF9800);

  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }

  void _carregarProdutos() {
    setState(() {
      _produtosFuture = supabase
          .from('produtos')
          .select()
          .order('created_at', ascending: false)
          .then((data) => data.map((e) => Produto.fromMap(e)).toList());
    });
  }

  Future<void> _escolherImagem() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _imagemBytes = bytes;
        _imagemNome = image.name;
      });
    }
  }

  Future<void> _salvarProduto() async {
    if (_nomeController.text.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      String? imageUrl;
      if (_imagemBytes != null && _imagemNome != null) {
        final path = 'produtos/${DateTime.now().millisecondsSinceEpoch}_$_imagemNome';
        await supabase.storage.from('produtos_imagens').uploadBinary(path, _imagemBytes!);
        imageUrl = supabase.storage.from('produtos_imagens').getPublicUrl(path);
      }

      await supabase.from('produtos').insert({
        'nome': _nomeController.text,
        'quantidade': int.tryParse(_quantidadeController.text) ?? 0,
        'preco': double.tryParse(_precoController.text.replaceAll(',', '.')) ?? 0.0,
        'imagem_url': imageUrl,
      });

      _nomeController.clear();
      _quantidadeController.clear();
      _precoController.clear();
      setState(() {
        _imagemBytes = null;
        _imagemNome = null;
      });
      
      // Checagem necessária após os "awaits" acima
      if (!mounted) return;
      
      FocusScope.of(context).unfocus();
      _carregarProdutos();
      
      // Feedback visual estilo HK
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item guardado no Inventário.', style: GoogleFonts.cinzel(fontWeight: FontWeight.bold)),
          backgroundColor: voidColor,
          behavior: SnackBarBehavior.floating,
        )
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e', style: GoogleFonts.cinzel())));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _incrementar(int id, int qtdAtual) async {
    await supabase.from('produtos').update({'quantidade': qtdAtual + 1}).eq('id', id);
    _carregarProdutos();
  }

  Future<void> _deletar(int id) async {
    await supabase.from('produtos').delete().eq('id', id);
    _carregarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'INVENTÁRIO DE HALLOWNEST', 
          style: GoogleFonts.cinzel(
            fontWeight: FontWeight.w900,
            fontSize: 22,
            letterSpacing: 2,
            shadows: [Shadow(color: soulColor, blurRadius: 10)]
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              color: voidColor.withOpacity(0.6), // Escurece um pouco o fundo
            ),
          ),
          // Conteúdo Principal
          SafeArea(
            child: Column(
              children: [
                _buildFormulario(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(color: soulColor.withOpacity(0.3), thickness: 1, indent: 40, endIndent: 40),
                ),
                Expanded(child: _buildListaProdutos()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormulario() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: voidColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: soulColor.withOpacity(0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: soulColor.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: _escolherImagem,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: soulColor.withOpacity(0.5)),
                image: _imagemBytes != null
                    ? DecorationImage(image: MemoryImage(_imagemBytes!), fit: BoxFit.cover)
                    : null,
              ),
              child: _imagemBytes == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.auto_awesome, color: soulColor, size: 30), // Ícone místico
                        const SizedBox(height: 8),
                        Text('Forjar Imagem do Item', style: GoogleFonts.cinzel(color: soulColor, fontWeight: FontWeight.bold)),
                      ],
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nomeController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDeco('Nome do Relíquia', Icons.adjust),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _quantidadeController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDeco('Qtd', Icons.filter_none),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _precoController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDeco('Geo (R\$)', Icons.circle_outlined),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: voidColor,
                side: BorderSide(color: soulColor, width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: _isLoading ? null : _salvarProduto,
              child: _isLoading 
                  ? CircularProgressIndicator(color: soulColor) 
                  : Text('GRAVAR NO REGISTRO', style: GoogleFonts.cinzel(color: soulColor, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.5)),
            ),
          )
        ],
      ),
    );
  }

  InputDecoration _inputDeco(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.cinzel(color: Colors.white70),
      prefixIcon: Icon(icon, color: soulColor.withOpacity(0.7)),
      filled: true,
      fillColor: Colors.black54,
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.white24)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: soulColor)),
    );
  }

  Widget _buildListaProdutos() {
    return FutureBuilder<List<Produto>>(
      future: _produtosFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator(color: soulColor));
        if (!snapshot.hasData || snapshot.data!.isEmpty) return Center(child: Text('Nenhuma relíquia encontrada.', style: GoogleFonts.cinzel(color: Colors.white54, fontSize: 18)));

        final produtos = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: produtos.length,
          itemBuilder: (context, index) {
            final p = produtos[index];
            final corPreco = p.preco > 100.0 ? Colors.greenAccent : Colors.redAccent;

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: voidColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ]
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: soulColor.withOpacity(0.5)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: p.imagemUrl != null
                        ? Image.network(p.imagemUrl!, fit: BoxFit.cover)
                        : Container(color: Colors.black45, child: Icon(Icons.bug_report, color: soulColor)),
                  ),
                ),
                title: Text(p.nome.toUpperCase(), style: GoogleFonts.cinzel(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Row(
                    children: [
                      const Icon(Icons.layers, size: 14, color: Colors.white54),
                      const SizedBox(width: 4),
                      Text('${p.quantidade}  |  ', style: const TextStyle(color: Colors.white70, fontSize: 15)),
                      Icon(Icons.monetization_on_outlined, size: 14, color: corPreco),
                      const SizedBox(width: 4),
                      Text('R\$ ${p.preco.toStringAsFixed(2)}', style: TextStyle(color: corPreco, fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                ),
                
                onTap: () => _incrementar(p.id, p.quantidade),
                trailing: IconButton(
                  icon: Icon(Icons.close, color: infectionColor),
                  onPressed: () => _deletar(p.id),
                ),
              ),
            );
          },
        );
      },
    );
  }
}