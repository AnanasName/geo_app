import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/geo_math.dart';

void main() => runApp(const RoundPage());

class RoundPage extends StatefulWidget {
  const RoundPage({super.key});

  @override
  State<RoundPage> createState() => _nameState();
}

class _nameState extends State<RoundPage> {
  final TextEditingController _x_coords_of_a_controller =
  TextEditingController();
  final TextEditingController _y_coords_of_a_controller =
  TextEditingController();

  final TextEditingController _x_coords_of_b_controller =
  TextEditingController();
  final TextEditingController _y_coords_of_b_controller =
  TextEditingController();

  String res = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.all(50),
                      child: Column(
                        children: [
                          const Text(
                            "Введите исходные данные первой точки",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _x_coords_of_a_controller,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (value) {
                              setState(() {});
                            },
                            decoration: const InputDecoration(
                                labelText: "Введите x первой точки:",
                                border: OutlineInputBorder()),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _y_coords_of_a_controller,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (value) {
                              setState(() {});
                            },
                            decoration: const InputDecoration(
                                labelText: "Введите y первой точки:",
                                border: OutlineInputBorder()),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Введите исходные данные второй точки",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _x_coords_of_b_controller,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (value) {
                              setState(() {});
                            },
                            decoration: const InputDecoration(
                                labelText: "Введите x второй точки:",
                                border: OutlineInputBorder()),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _y_coords_of_b_controller,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (value) {
                              setState(() {});
                            },
                            decoration: const InputDecoration(
                                labelText: "Введите y второй точки:",
                                border: OutlineInputBorder()),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  var (
                                  horLine1,
                                  horLine2,
                                  horLine3
                                  ) = GeoMath.reverseGeo(
                                      double.parse(
                                          _x_coords_of_a_controller.text),
                                      double.parse(
                                          _y_coords_of_a_controller.text),
                                      double.parse(
                                          _x_coords_of_b_controller.text),
                                      double.parse(
                                          _y_coords_of_b_controller.text));
                                  String horLine1String =
                                  GeoMath.formatDouble(horLine1);
                                  String horLine2String =
                                  GeoMath.formatDouble(horLine2);
                                  String horLine3String =
                                  GeoMath.formatDouble(horLine3);
                                  if (horLine1.isNaN) {
                                    horLine1String = "Не удалось посчитать";
                                  }
                                  if (horLine2.isNaN) {
                                    horLine2String = "Не удалось посчитать";
                                  }
                                  if (horLine3.isNaN) {
                                    horLine3String = "Не удалось посчиать";
                                  }

                                  res =
                                  "$horLine1String м, $horLine2String м, $horLine3String м";
                                });
                              },
                              child: const Text(
                                "Перевести",
                                style: TextStyle(fontSize: 20),
                              ))
                        ],
                      )),
                  const Text(
                    "Результаты вычисления тремя способами:",
                    textAlign: TextAlign.center,
                  ),
                  SelectableText(
                    res,
                    style: const TextStyle(fontSize: 25),
                    onTap: () {
                      _x_coords_of_a_controller.clear();
                      _y_coords_of_a_controller.clear();
                      _x_coords_of_b_controller.clear();
                      _y_coords_of_b_controller.clear();

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
          )),
    );
  }
}
