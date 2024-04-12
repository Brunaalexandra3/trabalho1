import 'package:flutter/material.dart';

void main() {
  runApp(const trabalho1());
}

class trabalho1 extends StatelessWidget {
  const trabalho1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: trabalho1Starters(),
    );
  }
}

class trabalho1Starters extends StatefulWidget {
  final double? ta;
  const trabalho1Starters({super.key, this.ta});

  @override
  State<trabalho1Starters> createState() => _trabalho1StartersState();
}

class _trabalho1StartersState extends State<trabalho1Starters> {
  var _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  double _totalAmount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.ta != null) {
      _totalAmount = widget.ta!;
    }
  }

  void reset() {
    setState(() {
      controller.text = '';
      _formKey = GlobalKey<FormState>();
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(60, 60, 60, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildTextFormField(
                        controller,
                        'Insira o número que pertende converter',
                        'Please, enter the price.',
                        '€',
                        'Please, enter a value >= 0.',
                        0,
                        250),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildElevatedButton(reset, 'Converter'),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






String? _validator(
    var value, String emptyTxt, String validTxt, int min, int max) {
  value != null ? value = value.replaceAll(',', '.') : null;
  if (value == null || value.isEmpty) {
    return emptyTxt;
  } else if (double.tryParse(value) == null) {
    return 'Please enter a valid numerical value.';
  } else if (double.parse(value) < min || double.parse(value) > max) {
    return validTxt;
  }
  return null;
}

Widget buildTextFormField(TextEditingController controller, String lbl,
    String emptyTxt, String sufix, String validTxt, int min, int max) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(labelText: lbl, suffixText: sufix),
    textAlign: TextAlign.center,
    keyboardType: TextInputType.number,
    //keyboardType: const TextInputType.numberWithOptions(decimal: true),
    validator: (value) {
      return _validator(value, emptyTxt, validTxt, min, max);
    },
  );
}

Widget buildElevatedButton(Function() fx, String txt) {
  return ElevatedButton(
    onPressed: fx,
    child: Text(txt),
  );
}

