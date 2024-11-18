import 'package:flutter/material.dart';
import 'database.dart'; // Banco de dados

class CadastroPage extends StatefulWidget {
  final Map<String, dynamic>? animal; // Animal que será editado (se existir)

  CadastroPage({this.animal});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _racaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Se estiver editando, preenche os campos com os dados existentes
    if (widget.animal != null) {
      _nomeController.text = widget.animal!['nome'];
      _tipoController.text = widget.animal!['tipo'];
      _racaController.text = widget.animal!['raca'];
    }
  }

  // Função para salvar o animal (criação ou edição)
  Future<void> _salvar() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> animal = {
        'nome': _nomeController.text,
        'tipo': _tipoController.text,
        'raca': _racaController.text,
      };

      if (widget.animal == null) {
        // Se for um novo animal, insere no banco
        await DatabaseHelper.instance.insert(animal);
      } else {
        // Se estiver editando, atualiza o animal
        animal['id'] = widget.animal!['id']; // Atribui o id para atualizar
        await DatabaseHelper.instance.update(animal);
      }

      Navigator.pop(context); // Volta para a lista
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              widget.animal == null ? 'Cadastrar Animal' : 'Editar Animal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome do animal';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tipoController,
                decoration: InputDecoration(labelText: 'Tipo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o tipo do animal';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _racaController,
                decoration: InputDecoration(labelText: 'Raça'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a raça do animal';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvar,
                child: Text(widget.animal == null ? 'Cadastrar' : 'Atualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _tipoController.dispose();
    _racaController.dispose();
    super.dispose();
  }
}
