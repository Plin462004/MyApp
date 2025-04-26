// countdown.dart
import 'package:flutter/material.dart';
import 'dart:async';

class Countdown extends StatelessWidget {
  const Countdown({super.key});
  void main() {
    runApp(Countdown());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Countdownpage(),
    );
  }
}

class Countdownpage extends StatefulWidget {
  const Countdownpage({super.key});

  @override
  State<Countdownpage> createState() => _CountdownpageState();
}

class _CountdownpageState extends State<Countdownpage> {
  late Timer _timer;
  late int _day;
  late int _hours;
  late int _minutes;
  late int _seconds;
  //ກຳນົດວັນເວລາທີ່ຕ້ອງການໃຫ້ນັບຖອຍຫຼັງ(ປີ2025)
  final DateTime targetDate = DateTime(2026, 1, 1, 0, 0, 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startCountdownn();
  }

  void _startCountdownn() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateCountdown();
    });
  }

  void _updateCountdown() {
    final now = DateTime.now();
    final differance = targetDate.difference(now);
    setState(() {
      _day = differance.inDays;
      _hours = differance.inHours % 24;
      _minutes = differance.inMinutes % 60;
      _seconds = differance.inSeconds % 60;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Count Down to 2025"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "$_day ວັນ $_hours ຊົ່ວໂມງ $_minutes ນາທີ $_seconds ວິນາທີ ",
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
