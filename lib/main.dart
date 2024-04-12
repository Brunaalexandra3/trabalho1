import 'package:flutter/material.dart';

void main() {
  runApp(const Trabalho1());
}

// Classe principal que define o aplicação
class Trabalho1 extends StatelessWidget {
  const Trabalho1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Converter', // Título do aplicação
      theme: ThemeData(
        primarySwatch: Colors.grey, // Define a cor primária do tema
      ),
      home: const Trabalho1Starters(
          title: 'Converter'), // Define a página inicial
    );
  }
}

// Classe que define a tela inicial e a lógica de conversão
class Trabalho1Starters extends StatefulWidget {
  final String title; // Título da página
  const Trabalho1Starters({Key? key, this.title = 'Converter'})
      : super(key: key);

  @override
  State<Trabalho1Starters> createState() =>
      _Trabalho1StartersState(); // Cria o estado da tela
}

// Estado da tela inicial
class _Trabalho1StartersState extends State<Trabalho1Starters> {
  String _inputValue = ''; // Valor de entrada
  String _outputValue = ''; // Valor de saída
  String _inputBase = 'Decimal'; // Base de entrada padrão
  String _outputBase = 'Binary'; // Base de saída padrão

  // Método para realizar a conversão
  void _convert() {
    String inputValue =
        _inputValue.trim(); // Remove espaços em branco do valor de entrada
    int? parsedValue; // Valor de entrada convertido

    // Converte o valor de entrada de acordo com a base selecionada
    switch (_inputBase) {
      case 'Decimal':
        parsedValue = int.tryParse(inputValue);
        break;
      case 'Binary':
        parsedValue = int.tryParse(inputValue, radix: 2);
        break;
      case 'Octal':
        parsedValue = int.tryParse(inputValue, radix: 8);
        break;
      case 'Hexadecimal':
        parsedValue = int.tryParse(inputValue, radix: 16);
        break;
    }

    // Verifica se a conversão foi bem-sucedida
    if (parsedValue != null) {
      setState(() {
        // Converte o valor de entrada para a base de saída selecionada
        switch (_outputBase) {
          case 'Decimal':
            _outputValue = parsedValue.toString();
            break;
          case 'Binary':
            _outputValue = parsedValue?.toRadixString(2) ?? '';
            break;
          case 'Octal':
            _outputValue = parsedValue?.toRadixString(8) ?? '';
            break;
          case 'Hexadecimal':
            _outputValue = parsedValue?.toRadixString(16)?.toUpperCase() ?? '';
            break;
        }
      });
    } else {
      // Se a conversão falhar, exibe uma mensagem de erro
      setState(() {
        _outputValue = 'Entrada inválida';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // Define o título da página
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            300, 100, 300, 20), // Define o preenchimento ao redor dos elementos
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DropdownButtonFormField(
              value: _inputBase,
              items: ['Decimal', 'Binary', 'Octal', 'Hexadecimal']
                  .map((base) =>
                      DropdownMenuItem(value: base, child: Text(base)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _inputBase = value
                      .toString(); // Atualiza a base de entrada selecionada
                });
              },
              decoration: const InputDecoration(
                  labelText:
                      'Converter de: '), // Define a etiqueta do campo de seleção de base de entrada
            ),
            const SizedBox(height: 20.0),
            TextField(
              decoration: const InputDecoration(
                  labelText:
                      'Insira o número que pretende converter'), // Define a etiqueta do campo de entrada
              onChanged: (value) {
                _inputValue = value; // Atualiza o valor de entrada
              },
            ),
            const SizedBox(height: 20.0),
            DropdownButtonFormField(
              value: _outputBase,
              items: ['Decimal', 'Binary', 'Octal', 'Hexadecimal']
                  .map((base) =>
                      DropdownMenuItem(value: base, child: Text(base)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _outputBase =
                      value.toString(); // Atualiza a base de saída selecionada
                });
              },
              decoration: const InputDecoration(
                  labelText:
                      'Converter para: '), // Define a etiqueta do campo de seleção de base de saída
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double
                  .infinity, // Define a largura do botão para preencher toda a largura da tela
              child: ElevatedButton(
                onPressed: _convert, // Define a ação ao pressionar o botão
                child: const Text('Converter'), // Define o texto do botão
              ),
            ),
            const SizedBox(height: 20.0),
            Text('Resultado: $_outputValue', // Exibe o resultado da conversão
                style: const TextStyle(fontSize: 18.0)),
          ],
        ),
      ),
    );
  }
}
