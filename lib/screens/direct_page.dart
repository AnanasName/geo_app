import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/geo_math.dart';

void main() => runApp(const DirectPage());

class DirectPage extends StatefulWidget {
  const DirectPage({super.key});

  @override
  State<DirectPage> createState() => _nameState();
}

class _nameState extends State<DirectPage> {
  final TextEditingController _x_coords_of_a_controller =
      TextEditingController();
  final TextEditingController _y_coords_of_a_controller =
      TextEditingController();
  final TextEditingController _pos_of_d_controller = TextEditingController();

  final TextEditingController _degrees_controller = TextEditingController();
  final TextEditingController _minutes_controller = TextEditingController();
  final TextEditingController _seconds_controller = TextEditingController();

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
                        "Введите исходные данные",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _x_coords_of_a_controller,
                        onSubmitted: (value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                            labelText: "Введите x точки A:",
                            border: OutlineInputBorder()),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _y_coords_of_a_controller,
                        onSubmitted: (value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                            labelText: "Введите y точки A:",
                            border: OutlineInputBorder()),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _pos_of_d_controller,
                        onSubmitted: (value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                            labelText: "Введите горизональное проложение:",
                            border: OutlineInputBorder()),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Введите дирекционный угол линии AB",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
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
                        controller: _seconds_controller,
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
                              var (resultX, resultY) = GeoMath.directGeo(
                                  double.parse(_x_coords_of_a_controller.text),
                                  double.parse(_y_coords_of_a_controller.text),
                                  double.parse(_pos_of_d_controller.text),
                                  double.parse(_degrees_controller.text),
                                  double.parse(_minutes_controller.text),
                                  double.parse(_seconds_controller.text));
                              String resultXString =
                                  GeoMath.formatDouble(resultX);
                              String resultYString =
                                  GeoMath.formatDouble(resultY);
                              res = "$resultXString м, $resultYString м";
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
                  _x_coords_of_a_controller.clear();
                  _y_coords_of_a_controller.clear();
                  _pos_of_d_controller.clear();

                  _degrees_controller.clear();
                  _seconds_controller.clear();
                  _minutes_controller.clear();
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
