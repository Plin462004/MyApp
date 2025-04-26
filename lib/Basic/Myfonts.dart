import 'package:flutter/material.dart';

class Myfonts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ການສະແດງຂໍ້ຄວາມໃນ Flutter'),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ໄລຍະທາງພິສູດມ້າ ການເວລາພິສູດຄົນ',
                style: TextStyle(fontSize: 18, fontFamily: 'Phetsarath OT'),
              ),
              SizedBox(height: 16),
              Container(
                width: 500,
                child: Text(
                  'ຄັນບໍ່ອອກຈາກບ້ານ ບໍ່ເຫັນດ່ານແດນໄກ ຄັນບໍ່ໄປຫາຮຽນບໍ່ຮ່ອນມີຄວາມຮູ້',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'LAI LAO 2022 (Design By Mr Go S)'),
                ),
              ),
              SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'ຄວາມພະຍາຍາມຢູ່ບ່ອນໃດ ຄວາມສຳເລັດຢູ່ບ່ອນນັ້ນ\n',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                    TextSpan(
                      text: 'ອົດສົ້ມຈຶ່ງໄດ້ກິນຫວານ ອົດທົນທານວຽກງານຈຶ່ງແລ້ວ',
                      style: TextStyle(fontSize: 18, color: Colors.red),
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
