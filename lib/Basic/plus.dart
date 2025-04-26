import 'package:flutter/material.dart';

void main() {
  runApp(MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _counter = 0; // ວ່າງຕົວປ່ຽນໃຫມ່ຊື່ວ່າ _counter
  void _incrementCounter() {
    setState(() {
      _counter++; // ເພີ່ມຄຳສັງຕົວປ່ຽນ _counter ຂື້ນເທື່ອລະ 1
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ເເອັບນັກເລກຈຳນວນຄັ້ງເມືອກົດປຸ່ມບວກ +"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ກົດປຸ່ມເພີ່ມເລກ',
                style: TextStyle(fontSize: 22),
              ),
              Text('$_counter', // ສະເເດງຄ່າປັດຈຸບັນຂອງ ຕົວປ່ຽນ _counter
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: (Colors.blue),
                  )),
            ],
          ),
        ),
        // ສ້າງປຸ່ມ FoatingButton
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter, //
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.add), // ເພິ່ມໄອຄອນເຂົ້າໃນປຸ່ມ
        ),
      ),
    );
  }
}
