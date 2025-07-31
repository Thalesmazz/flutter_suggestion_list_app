import 'package:flutter/material.dart';
import 'package:login_screen_app/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Define a rota inicial
      routes: {
        '/login': (context) => const LoginPage(),
        // '/home': (context) => const HomePage(), // Poderíamos adicionar a home aqui também
      },
    );
  }
}

// A CLASSE LoginPage DEVE ESTAR AQUI, FORA DE QUALQUER OUTRA CLASSE
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// E A CLASSE _LoginPageState TAMBÉM DEVE ESTAR AQUI, FORA DE QUALQUER OUTRA CLASSE
class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para os campos de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    // Valida todos os campos do formulário
    if (_formKey.currentState!.validate()) {
      // Se a validação passar, imprima os valores (ou faça a autenticação real)
      print('Login bem-sucedido!');
      print('Email: ${_emailController.text}');
      print('Senha: ${_passwordController.text}');

      // Em um app real, aqui você chamaria um serviço de autenticação
      // e navegaria para a próxima tela se o login fosse bem-sucedido.

      Navigator.pushReplacement( //troca para a home page
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );


    } else {
      print('Erro de validação. Preencha os campos corretamente.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center( // Centraliza o conteúdo do formulário na tela
        child: SingleChildScrollView( // Permite rolagem se o teclado aparecer
          padding: const EdgeInsets.all(24.0), // Aumenta o padding
          child: Form( // Nosso formulário para validação
            key: _formKey, // Associa a chave global ao formulário
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch, // Estica os elementos horizontalmente
              children: <Widget>[
                // Ícone ou logo (opcional, mas comum em telas de login)
                const Icon(
                  Icons.lock_person, // Ícone de cadeado com pessoa
                  size: 100, // Tamanho do ícone
                  color: Colors.blue, // Cor do ícone
                ),
                const SizedBox(height: 48.0), // Espaçamento maior

                TextFormField( // Usamos TextFormField para validação
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'seu.email@exemplo.com', // Texto de dica
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) { // Função de validação
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu email';
                    }
                    // Validação de formato de e-mail simples
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Email inválido';
                    }
                    return null; // Retorna null se a validação for bem-sucedida
                  },
                ),
                const SizedBox(height: 16.0),

                TextFormField( // Usamos TextFormField para validação
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    hintText: 'Sua senha secreta',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) { // Função de validação
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha';
                    }
                    if (value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),

                ElevatedButton(
                  onPressed: _login, // Chama o método _login que criamos
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder( // Borda arredondada
                      borderRadius: BorderRadius.circular(8), // Raio de 8 pixels
                    ),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(fontSize: 18, color: Colors.white), // Cor do texto
                  ),
                ),
                const SizedBox(height: 16.0),

                // NOVO CÓDIGO: Botão "Esqueceu a Senha?"
                TextButton(
                  onPressed: () {
                    print('Esqueceu a senha?');
                    // Implementar navegação para tela de recuperação de senha
                  },
                  child: const Text('Esqueceu a senha?'),
                ),
                const SizedBox(height: 8.0), // Espaçamento menor

                // NOVO CÓDIGO: Botão "Criar Conta"
                OutlinedButton( // Botão com borda
                  onPressed: () {
                    print('Criar nova conta');
                    // Implementar navegação para tela de registro
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(color: Colors.blue), // Cor da borda
                  ),
                  child: const Text(
                    'Criar Conta',
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ),
              ],
            ),
            ),
          ),
        ),
      );
  }
}