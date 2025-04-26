// Menu/Address.dart
import 'package:flutter/material.dart';

class Address extends StatelessWidget implements PreferredSizeWidget {
  const Address({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.teal,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              // กด Welcome ยังไม่ทำอะไร
            },
            child: Text(
              "Welcome",
              style: TextStyle(
                color: Colors.blue[900],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              // ที่นี่คุณเว้นว่างไว้ ยังไม่ได้กำหนด action
            },
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, color: Colors.white),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings, color: Colors.white),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
