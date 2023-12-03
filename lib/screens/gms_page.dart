import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/geo_math.dart';

void main() => runApp(const GMSPage());

class GMSPage extends StatefulWidget {
  const GMSPage({super.key});

  @override
  State<GMSPage> createState() => _nameState();
}

class _nameState extends State<GMSPage> {
  final TextEditingController _degrees_controller = TextEditingController();
  final TextEditingController _minutes_controller = TextEditingController();
  final TextEditingController _seconds_contoller = TextEditingController();
  String res = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(50),
                  child: Column(
                    children: [
                      TextField(
                        controller: _degrees_controller,
                        onSubmitted: (value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                            labelText: "Введите градусы:",
                            border: OutlineInputBorder()),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _minutes_controller,
                        onSubmitted: (value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                            labelText: "Введите минуты:",
                            border: OutlineInputBorder()),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _seconds_contoller,
                        onSubmitted: (value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                            labelText: "Введите секунды:",
                            border: OutlineInputBorder()),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              double result = GeoMath.toDeg(
                                  double.parse(_degrees_controller.text),
                                  double.parse(_minutes_controller.text),
                                  double.parse(_seconds_contoller.text));
                              res = GeoMath.formatDouble(result);
                            });
                          },
                          child: const Text(
                            "Перевести",
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  )),
              SelectableText(
                res,
                style: TextStyle(fontSize: 25),
                onTap: () {
                  _degrees_controller.clear();
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
