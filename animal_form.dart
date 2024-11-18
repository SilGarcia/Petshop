import 'package:flutter/material.dart';
import 'database.dart'; // Importe o helper de banco de dados

class AnimalFormPage extends StatefulWidget {
  final int? animalId;
  AnimalFormPage({this.animalId});

  @override
  _AnimalFormPageState createState() => _AnimalFormPageState();
}

class _AnimalFormPageState extends State<AnimalFormPage> {
  final _nomeController = TextEditingController();
  final _tipoController = TextEditingController();
  final _racaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Se um ID de animal for passado (para edição), carrega os dados
    if (widget.animalId != null) {
      _loadAnimalData(widget.animalId!);
    }
  }

  // Carregar dados do animal para edição
  Future<void> _loadAnimalData(int id) async {
    Map<String, dynamic>? animal = await DatabaseHelper.instance.get(id);
    if (animal != null) {
      _nomeController.text = animal['nome'];
      _tipoController.text = animal['tipo'];
      _racaController.text = animal['raca'];
    }
  }

  // Função de salvar (inserir ou atualizar dependendo do ID)
  Future<void> _saveAnimal() async {
    if (_nomeController.text.isEmpty ||
        _tipoController.text.isEmpty ||
        _racaController.text.isEmpty) {
      return; // Validação simples
    }

    final animal = {
      'nome': _nomeController.text,
      'tipo': _tipoController.text,
      'raca': _racaController.text,
    };

    if (widget.animalId == null) {
      // Inserir novo animal
      await DatabaseHelper.instance.insert(animal);
    } else {
      // Atualizar animal existente
      await DatabaseHelper.instance.update({
        'id': widget.animalId,
        ...animal,
      });
    }

    Navigator.pop(context); // Voltar para a página anterior
  }

  // Função para excluir animal
  Future<void> _deleteAnimal() async {
    if (widget.animalId != null) {
      await DatabaseHelper.instance.delete(widget.animalId!);
      Navigator.pop(context); // Volta para a página anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.animalId == null ? 'Cadastrar Animal' : 'Editar Animal'),
        actions: [
          if (widget.animalId !=
              null) // Exibe o botão de excluir apenas na edição
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _deleteAnimal,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _tipoController,
              decoration: InputDecoration(labelText: 'Tipo'),
            ),
            TextField(
              controller: _racaController,
              decoration: InputDecoration(labelText: 'Raça'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveAnimal,
              child: Text(widget.animalId == null ? 'Cadastrar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
