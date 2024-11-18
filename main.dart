import 'package:flutter/material.dart';
import 'lista_page.dart'; // Página para visualizar os cadastros
import 'cadastro_page.dart'; // Página para cadastro de novo animal

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetShop - Cadastro de Pets',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF780000),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF780000),
          secondary: Color(0xFFC1121F),
          background: Color(0xFFFDF0D5),
          surface: Color(0xFFFDF0D5),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onBackground: Color(0xFF003049),
          onSurface: Color(0xFF003049),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF003049),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF003049), fontSize: 16),
          bodyMedium: TextStyle(color: Color(0xFF003049), fontSize: 14),
          headlineSmall: TextStyle(
              color: Color(0xFF003049),
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFFC1121F),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PetShop')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navegar para a página de cadastro de novo animal
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CadastroPage(),
                  ),
                );
              },
              child: Text('Cadastrar Novo Animal'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar para a página de listagem de animais
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaPage(),
                  ),
                );
              },
              child: Text('Visualizar Cadastros'),
            ),
          ],
        ),
      ),
    );
  }
}
