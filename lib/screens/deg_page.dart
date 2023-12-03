import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/geo_math.dart';

void main() => runApp(const DegPage());

class DegPage extends StatefulWidget {
  const DegPage({super.key});

  @override
  State<DegPage> createState() => _nameState();
}

class _nameState extends State<DegPage> {
  final TextEditingController _textcontroller1 = TextEditingController();
  String res = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(50),
                child: TextField(
                  controller: _textcontroller1,
                  onSubmitted: (value) {
                    setState(() {
                      res = GeoMath.toGMS(double.parse(_textcontroller1.text));
                    });
                  },
                  decoration: const InputDecoration(
                      labelText: "Введите градусы:",
                      border: OutlineInputBorder()),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              SelectableText(
                res,
                style: TextStyle(fontSize: 25),
                onTap: () {
                  _textcontroller1.clear();
                  Clipboard.setData(ClipboardData(text: res)).then(
                    (_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Текст скопирован!",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
