// Profile/MyAccount.dart
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool biometricEnabled = false;
  bool savePhotoEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ส่วนหัวของหน้าจอ
          Container(
            width: double.infinity,
            color: Color(0xFFFCEAE9),
            padding: EdgeInsets.only(top: 50, bottom: 15, left: 20, right: 20),
            child: Center(
              child: Text(
                'ການຕັ້ງຄ່າ', // หัวข้อ "การตั้งค่า" ในภาษาลาว
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // ส่วนข้อมูลผู้ใช้
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                // รูปโปรไฟล์
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/Soulin.jpg'),
                      // ถ้าไม่มีรูปให้ใช้ NetworkImage หรือ placeholder แทน
                      // backgroundImage: NetworkImage('https://via.placeholder.com/80'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16),
                // ข้อมูลผู้ใช้
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ສຸລິມ ໃຊຍະວົງ', // ชื่อผู้ใช้ "สุลิม ไซยะวง"
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            '207****347', // หมายเลขผู้ใช้
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.visibility_off,
                              color: Colors.grey, size: 18),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'UnApproved',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ส่วนโปรโมชั่น
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ຮັບສ່ວນຫຼຸດສູງສຸດ 15%', // "รับส่วนลดสูงสุด 15%"
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ຈາກ M MoneyX', // "จาก M MoneyX"
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 60,
                      // หรือใช้ Icon แทนถ้าไม่มีรูป
                      // แทนด้วยไอคอนนี้
                    ),
                    SizedBox(width: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'ຫດສ່ວນຫຼຸດ', // "กดส่วนลด"
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ส่วนรายการเมนู
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                // รายการเมนูต่างๆ
                _buildMenuItem(
                    'ຂໍ້ມູນສ່ວນຕົວ', Icons.chevron_right), // "ข้อมูลส่วนตัว"
                Divider(height: 1),
                _buildMenuItem(
                    'ປຽນລະຫັດຜ່ານ', Icons.chevron_right), // "เปลี่ยนรหัสผ่าน"
                Divider(height: 1),
                _buildMenuItem(
                    'ການຢືນຢັນຕົວຕົນ', Icons.chevron_right), // "การยืนยันตัวตน"
                Divider(height: 1),

                // สวิตช์ Biometric
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Biometric',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Switch(
                            value: biometricEnabled,
                            onChanged: (value) {
                              setState(() {
                                biometricEnabled = value;
                              });
                            },
                            activeTrackColor: Colors.grey[400],
                            inactiveTrackColor: Colors.grey[400],
                            activeColor: Colors.grey[600],
                          ),
                          Text(
                            'ປິດ', // "ปิด"
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(height: 1),

                // สวิตช์บันทึกรูปใบบิล
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Biometric',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Switch(
                            value: biometricEnabled,
                            onChanged: (value) {
                              setState(() {
                                biometricEnabled = value;
                              });
                            },
                            activeTrackColor: Colors.grey[400],
                            inactiveTrackColor: Colors.grey[400],
                            activeColor: Colors.grey[600],
                          ),
                          Text(
                            'ປິດ', // "ปิด"
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(height: 1),
              ],
            ),
          ),

          // เมนูเกี่ยวกับเรา
          Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: _buildMenuItem(
                'ກ່ຽວກັບພວກເຮົາ', Icons.chevron_right), // "เกี่ยวกับพวกเรา"
          ),
        ],
      ),
    );
  }

  // วิดเจ็ตสำหรับสร้างรายการเมนู
  Widget _buildMenuItem(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(
            icon,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
