import 'package:flutter/material.dart';
import 'database.dart';
import 'animal_form.dart'; // Página de cadastro/edição de animais

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  List<Map<String, dynamic>> _animais = [];

  @override
  void initState() {
    super.initState();
    _loadAnimais();
  }

  // Carregar a lista de animais
  Future<void> _loadAnimais() async {
    final animais = await DatabaseHelper.instance.queryAllRows();
    setState(() {
      _animais = animais;
    });
  }

  // Função para excluir animal
  Future<void> _deleteAnimal(int id) async {
    await DatabaseHelper.instance.delete(id);
    _loadAnimais(); // Atualiza a lista após exclusão
  }

  // Função para navegar para a página de cadastro ou edição
  void _navigateToForm(int? id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimalFormPage(animalId: id),
      ),
    ).then((_) =>
        _loadAnimais()); // Atualiza a lista após voltar da página de edição
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Animais')),
      body: ListView.builder(
        itemCount: _animais.length,
        itemBuilder: (context, index) {
          final animal = _animais[index];
          return ListTile(
            title: Text(animal['nome']),
            subtitle: Text('${animal['tipo']} - ${animal['raca']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _navigateToForm(animal['id']),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteAnimal(animal['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _navigateToForm(null), // Navega para a página de cadastro
        child: Icon(Icons.add),
      ),
    );
  }
}
