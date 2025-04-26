// Auth/Home.dart
import 'package:flutter/material.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F5),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(Icons.headphones, color: Colors.red),
                      SizedBox(height: 4),
                      Text("ຊ່ວຍແກ້ວ", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 10,
                      ),
                      SizedBox(height: 4),
                      Text("LAO", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),

            // Avatar + Name
            const CircleAvatar(
              radius: 70,
              backgroundColor: Colors.pinkAccent,
              child: CircleAvatar(
                radius: 65,
                backgroundImage: AssetImage("assets/user.jpg"), // Replace with your image
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'ສຸລິນ ໄຊຍະວົງ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              '2076***347',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Password Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("ລະຫັດຜ່ານ"),
                  const SizedBox(height: 6),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "ປ້ອນລະຫັດຜ່ານ",
                      suffixIcon: Icon(Icons.visibility_off),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("ເຂົ້າລະບົບລ່າສຸດ"),
                      Text("ລືມລະຫັດຜ່ານ", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Login Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "ເຂົ້າລະບົບ",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            const Icon(Icons.face, size: 32),
            const Text("ເຂົ້າລະບົບດ້ວຍ Biometric"),
            const SizedBox(height: 10),
            const Text(
              "ປູກມາຍໃໝ່",
              style: TextStyle(color: Colors.red, decoration: TextDecoration.underline),
            ),

            const Spacer(),

            // Footer Date & Button
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [
                      Text("20", style: TextStyle(fontSize: 28, color: Colors.red)),
                      Text("04/2025", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const Text("ບໍ່ມີລາຍການສຳຄັນ"),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("ເບິ່ງລະບົບ"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
