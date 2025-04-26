// LoveCalculater.dart
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(LoveCalculater());
}

class Lovecalculater extends StatelessWidget {
  const Lovecalculater({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LoveCalculator",
      home: const Lovecalculater(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoveCalculater extends StatefulWidget {
  const LoveCalculater({super.key});

  @override
  State<LoveCalculater> createState() => _LoveCalculaterState();
}

class _LoveCalculaterState extends State<LoveCalculater> {
  //
  final TextEditingController _name1Controller = TextEditingController();
  final TextEditingController _name2Controller = TextEditingController();
  String _result = "";
  void _calculator() {
    final name1 = _name1Controller.text.trim();
    final name2 = _name2Controller.text.trim();
    //ວາງເງື່ອນໄຂກວບສອບ ຖ້າບໍ່ມີການປ້ອນຂໍ້ມູນ
    if (name1.isEmpty || name2.isEmpty) {
      setState(() {
        _result = "ກະລຸນາປ້້ອນຊື່ໃຫ້ຄົບທັງສອງຄົນ";
      });
      return;
    }
    //ສ້າງເລກສຸ່ມ ຈຳລອງການສຳນວນຄວາມຮັກ
    final random = Random();
    int lovePercentage = random.nextInt(101);

    setState(() {
      _result = "🥰😍ຄວາມຮັກລະຫວ່າງ $name1 ແລະ $name2 ແມ່ນ $lovePercentage%";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Love Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _name1Controller,
              decoration: const InputDecoration(
                labelText: "ກະລຸນາປ້ອນຊື່ຄົນທີ່1",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _name2Controller,
              decoration: const InputDecoration(
                labelText: "ກະລຸນາປ້ອນຊື່ຄົນທີ່2",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculator,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
              ),
              child: const Text(
                "ຄຳນວນຄວາມຮັກ👩‍❤️‍👨",
                style: TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(
                fontSize: 22,
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
