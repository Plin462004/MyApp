// Pages/Notification.dart

// Pages/Notification.dart
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'ການເເຈ້ງເຕືອນ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // ปรับเป็น center เพื่อให้เนื้อหาอยู่ตรงกลาง
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Image.asset(
                'assets/icons/service.png',
                // Replace with your actual asset path
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'ການເເຈ້ງເຕືອນຂອງບໍລິການຈະຢູ່ທີ່ນີ້',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // ลบ Expanded เพื่อให้เนื้อหาอยู่ตรงกลางจริงๆ
          ],
        ),
      ),
    );
  }
}

// If you want to implement a page with actual notifications, here's a more complete version:

class NotificationsPageWithList extends StatefulWidget {
  const NotificationsPageWithList({Key? key}) : super(key: key);

  @override
  _NotificationsPageWithListState createState() => _NotificationsPageWithListState();
}

class _NotificationsPageWithListState extends State<NotificationsPageWithList> {
  // Sample notification data
  final List<NotificationItem> _notifications = [];

  @override
  void initState() {
    super.initState();
    // You would typically load notifications from your backend here
    // This is just sample data
    _loadSampleNotifications();
  }

  void _loadSampleNotifications() {
    // Add sample notifications for demonstration
    // In a real app, you would fetch this from a service
    setState(() {
      _notifications.clear();
      // You can uncomment these to show sample notifications
      
      _notifications.add(
        NotificationItem(
          title: "ยืนยันการชำระเงินสำเร็จ",
          message: "การชำระเงินของคุณได้รับการยืนยันเรียบร้อยแล้ว",
          time: DateTime.now().subtract(const Duration(hours: 2)),
          isRead: false,
        ),
      );
      _notifications.add(
        NotificationItem(
          title: "มีข้อความใหม่",
          message: "คุณได้รับข้อความใหม่จากระบบ",
          time: DateTime.now().subtract(const Duration(days: 1)),
          isRead: true,
        ),
      );
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'ການເເຈ້ງເຕືອນ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // ปรับเป็น center เพื่อให้เนื้อหาอยู่ตรงกลาง
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      'assets/icons/service.png',
                      // Replace with your actual asset path
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'ການເເຈ້ງເຕືອນຂອງບໍລິການຈະຢູ່ທີ່ນີ້',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _notifications.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return NotificationTile(
                  notification: notification,
                  onTap: () {
                    setState(() {
                      notification.isRead = true;
                    });
                    // Handle notification tap
                  },
                );
              },
            ),
    );
  }
}

// Notification data model
class NotificationItem {
  final String title;
  final String message;
  final DateTime time;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });
}

// Widget for individual notification items
class NotificationTile extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;

  const NotificationTile({
    Key? key,
    required this.notification,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        color: notification.isRead ? Colors.white : Colors.blue.shade50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!notification.isRead)
              Container(
                margin: const EdgeInsets.only(top: 3, right: 8),
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.message,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(notification.time),
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} วันที่แล้ว';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ชั่วโมงที่แล้ว';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} นาทีที่แล้ว';
    } else {
      return 'เมื่อสักครู่';
    }
  }
}