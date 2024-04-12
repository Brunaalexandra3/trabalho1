import 'package:flutter/material.dart';

void main() {
  runApp(const Trabalho1());
}

class Trabalho1 extends StatelessWidget {
  const Trabalho1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Converter',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const Trabalho1Starters(title: 'Converter'),
    );
  }
}

class Trabalho1Starters extends StatefulWidget {
  final String title;
  const Trabalho1Starters({Key? key, this.title = 'Converter'}) : super(key: key);

  @override
  State<Trabalho1Starters> createState() => _Trabalho1StartersState();
}

class _Trabalho1StartersState extends State<Trabalho1Starters> {
  String _inputValue = '';
  String _outputValue = '';
  String _inputBase = 'Decimal';
  String _outputBase = 'Binary';

  void _convert() {
    String inputValue = _inputValue.trim();
    int? parsedValue;

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

    if (parsedValue != null) {
      setState(() {
        switch (_outputBase) {
          case 'Decimal':
            _outputValue = parsedValue.toString();
            break;
          case 'Binary':
            _outputValue =
                parsedValue?.toRadixString(2) ?? ''; 
            break;
          case 'Octal':
            _outputValue =
                parsedValue?.toRadixString(8) ?? ''; 
            break;
          case 'Hexadecimal':
            _outputValue = parsedValue?.toRadixString(16)?.toUpperCase() ??
                ''; 
            break;
        }
      });
    } else {
      setState(() {
        _outputValue = 'Entrada inválida';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(300, 100, 300, 20),
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
                  _inputBase = value.toString();
                });
              },
              decoration: const InputDecoration(labelText: 'Converter de: '),
            ),
            const SizedBox(height: 20.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Insira o número que pretende converter'),
              onChanged: (value) {
                _inputValue = value;
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
                  _outputBase = value.toString();
                });
              },
              decoration: const InputDecoration(labelText: 'Converter para: '),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity, // Definindo a largura para preencher toda a largura da tela
              child: ElevatedButton(
                onPressed: _convert,
                child: const Text('Converter'),
                style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
              ),
            ),
            const SizedBox(height: 20.0),
            Text('Resultado: $_outputValue',
                style: const TextStyle(fontSize: 18.0)),
          ],
        ),
      ),
    );
  }
}

