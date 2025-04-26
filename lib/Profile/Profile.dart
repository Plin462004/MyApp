// Profile/Profile.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const ProfilePage());
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _subscribeToNews = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // นำทางกลับไปหน้าก่อนหน้า
          },
        ),
        title: const Text(
          'โปรไฟล์',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.login_outlined, color: Colors.teal),
            onPressed: () {
              // ฟังก์ชันเมื่อกดปุ่มแชร์
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          const Divider(height: 1),
          _buildInfoItem(Icons.phone, 'โทรศัพท์', '+856 20 7665 4347'),
          _buildInfoItem(Icons.person, 'ชื่อ', 'โฮยะวัง สุลิม'),
          _buildInfoItem(Icons.people, 'เพศ', 'เพศชาย'),
          _buildInfoItem(Icons.calendar_today, 'วันเกิด', '04.06.2004'),
          _buildInfoItem(Icons.email, 'อีเมล', 'html50014@gmail.com'),
          _buildActionItem(
            Icons.contact_phone,
            'เบอร์ติดต่อฉุกเฉิน',
            () {
              // นำทางไปยังหน้าเบอร์ติดต่อฉุกเฉิน
            },
          ),
          _buildSwitchItem(
            Icons.mail_outline,
            'รับจดหมายข่าว',
            _subscribeToNews,
            (value) {
              setState(() {
                _subscribeToNews = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(icon, color: Colors.grey),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Icon(icon, color: Colors.grey),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.chevron_right, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem(
      IconData icon, String label, bool value, Function(bool) onChanged) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(icon, color: Colors.grey),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.amber,
              activeTrackColor: Colors.amber.shade200,
            ),
          ),
        ],
      ),
    );
  }
}