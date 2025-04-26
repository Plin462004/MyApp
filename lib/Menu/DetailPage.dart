// Menu/DetailPage.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const DetailPage());
}

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: const ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  // สำหรับตัวเลือกที่เลือก
  String? selectedPrice = '3000';
  String? selectedBonus = '20000';
  String? selectedTip = '1000';

  // สำหรับสวิตช์ต่างๆ
  bool isPriceEnabled = true;
  bool isTravelEnabled = false;
  bool isBonusEnabled = true;
  bool isTipEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // กลับไปยังหน้าก่อนหน้า
          },
        ),
        title: const Text(
          'ລາຍລະອຽດຕິດຕໍ່',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const Divider(height: 1),
                _buildSwitchSection(
                  'ການເພີ່ມລາຄາ',
                  'ການເພີ່ມລາຄາຊະແດງໃຫ້ເຫັນວ່າ ຕິດຕໍ່ຂອງທ່ານແມ່ນຮີບດ່ວນ ແລະ ເຮັດໃຫ້ມີຄວາມຕ້ອງການຍິ່ງຂຶ້ນຕໍ່ຜູ້ດຳເນີນການ.',
                  isPriceEnabled,
                  (value) {
                    setState(() {
                      isPriceEnabled = value;
                    });
                  },
                ),
                if (isPriceEnabled)
                  _buildPriceOptions(['3000', '6000', '9000', '12000']),
                _buildSwitchWithSlider(
                  'ກະເປົ່າເດີນທາງ',
                  '+ 2000 ₭',
                  isTravelEnabled,
                  (value) {
                    setState(() {
                      isTravelEnabled = value;
                    });
                  },
                ),
                _buildSwitchSection(
                  'ເງິນໂບນັສ',
                  '',
                  isBonusEnabled,
                  (value) {
                    setState(() {
                      isBonusEnabled = value;
                    });
                  },
                ),
                if (isBonusEnabled)
                  _buildPriceOptions(['20000', '50000', '100000']),
                _buildSwitchSection(
                  'ເງິນທິບ',
                  'ຈຳນວນເງິນທິບຈະຖືກເພີ່ມເຂົ້າໃນລາຄາຂອງຕິດຕໍ່.',
                  isTipEnabled,
                  (value) {
                    setState(() {
                      isTipEnabled = value;
                    });
                  },
                ),
                if (isTipEnabled)
                  _buildPriceOptions(['1000', '2000', '3000', '4000']),
                const SizedBox(height: 20),
                _buildAddCommentButton(),
                const SizedBox(height: 80),
              ],
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildSwitchSection(
      String title, String description, bool value, Function(bool) onChanged) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.teal,
            activeTrackColor: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceOptions(List<String> options) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: options.map((option) {
          bool isSelected = false;
          if (options.contains('3000') && selectedPrice == option) {
            isSelected = true;
          } else if (options.contains('20000') && selectedBonus == option) {
            isSelected = true;
          } else if (options.contains('1000') && selectedTip == option) {
            isSelected = true;
          }

          return GestureDetector(
            onTap: () {
              setState(() {
                if (options.contains('3000')) {
                  selectedPrice = option;
                } else if (options.contains('20000')) {
                  selectedBonus = option;
                } else if (options.contains('1000')) {
                  selectedTip = option;
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.teal : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? Colors.teal : Colors.grey.shade300,
                ),
              ),
              child: Text(
                '$option ₭',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSwitchWithSlider(
      String title, String value, bool switchValue, Function(bool) onChanged) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 20,
            width: 40,
            child: Switch(
              value: switchValue,
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: Colors.grey.shade300,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCommentButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: OutlinedButton.icon(
        icon: const Icon(Icons.message_outlined, color: Colors.grey),
        label: const Text(
          'ຂໍ້ມູນເພີ່ມເຕີມ',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          // จัดการการเพิ่มความคิดเห็น
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // ดำเนินการเมื่อกดปุ่มสำเร็จ
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: const Text(
          'ສຳເລັດ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
