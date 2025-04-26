// Pages/Notification.dart
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'ຂໍ້ຄວາມ', // ข้อความในภาษาลาว
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // พื้นหลังลายไอคอน
          Positioned.fill(
            child: _buildPatternBackground(),
          ),
          
          // เนื้อหาหลัก
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ภาพประกอบการแจ้งเตือน
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // วงกลมพื้นหลังสีชมพู
                    Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFCDAD7),
                        shape: BoxShape.circle,
                      ),
                    ),
                    
                    // ตัวการ์ตูนถือโทรศัพท์กับการแจ้งเตือน
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ไอคอนระฆังแจ้งเตือน
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: const Icon(Icons.notifications, color: Colors.black, size: 24),
                        ),
                        
                        const SizedBox(width: 10),
                        
                        // ภาพตัวการ์ตูน
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                // ตัวการ์ตูน
                                Image.asset(
                                  'assets/character.png', // เปลี่ยนเป็นที่อยู่ของรูปภาพตัวการ์ตูนของคุณ
                                  width: 120,
                                  height: 120,
                                  errorBuilder: (context, error, stackTrace) => _buildCharacterFallback(),
                                ),
                                
                                // กล่องข้อความกับเลข "0"
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black, width: 1),
                                    ),
                                    child: const Text(
                                      "0",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 40),
                
                // ข้อความด้านล่างภาพประกอบ
                const Text(
                  'ບໍ່ມີການແຈ້ງເຕືອນ', // ไม่มีการแจ้งเตือน
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'ມາຊ້ຳເບລອດເມື່ອຍາວອື່ນໆ ດ້ວຍຫ່າງດຽວ.', // ข้อความอธิบายภาษาลาว
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ตัวการ์ตูนสำรองกรณีไม่มีไฟล์รูปภาพ
  Widget _buildCharacterFallback() {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        children: [
          // ลำตัวตัวการ์ตูน
          Positioned(
            right: 10,
            child: Column(
              children: [
                // หัว
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      // ตา
                      Positioned(
                        top: 20,
                        left: 10,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 10,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // แก้มแดง
                      Positioned(
                        top: 30,
                        left: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        right: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // ปาก
                      Positioned(
                        bottom: 15,
                        left: 25,
                        child: Container(
                          width: 10,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // ลำตัว
                Container(
                  width: 70,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Container(
                      width: 30,
                      height: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // โทรศัพท์ในมือ
          Positioned(
            left: 20,
            top: 40,
            child: Container(
              width: 30,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // พื้นหลังลายไอคอน
  Widget _buildPatternBackground() {
    return CustomPaint(
      painter: PatternPainter(),
    );
  }
}

// ตัววาดลายพื้นหลัง
class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFEEAE8)
      ..style = PaintingStyle.fill;

    final random = DateTime.now().millisecondsSinceEpoch;
    
    // วาดไอคอนต่างๆ บนพื้นหลัง
    for (int i = 0; i < 30; i++) {
      final x = ((random + i * 3737) % size.width);
      final y = ((random + i * 5151) % size.height);
      final iconType = i % 4;
      
      switch (iconType) {
        case 0: // กล่องของขวัญ
          _drawGiftBox(canvas, paint, x, y);
          break;
        case 1: // หัวใจ
          _drawHeart(canvas, paint, x, y);
          break;
        case 2: // ระฆังแจ้งเตือน
          _drawBell(canvas, paint, x, y);
          break;
        case 3: // โทรศัพท์
          _drawPhone(canvas, paint, x, y);
          break;
      }
    }
  }

  void _drawGiftBox(Canvas canvas, Paint paint, double x, double y) {
    final rect = Rect.fromCenter(center: Offset(x, y), width: 20, height: 20);
    canvas.drawRect(rect, paint);
    
    final topRect = Rect.fromLTWH(x - 5, y - 15, 10, 5);
    canvas.drawRect(topRect, paint);
    
    final ribbonVertical = Rect.fromLTWH(x - 1, y - 15, 2, 30);
    canvas.drawRect(ribbonVertical, paint);
    
    final ribbonHorizontal = Rect.fromLTWH(x - 10, y - 1, 20, 2);
    canvas.drawRect(ribbonHorizontal, paint);
  }

  void _drawHeart(Canvas canvas, Paint paint, double x, double y) {
    final path = Path();
    path.moveTo(x, y + 5);
    path.cubicTo(x - 10, y - 8, x - 5, y - 15, x, y - 5);
    path.cubicTo(x + 5, y - 15, x + 10, y - 8, x, y + 5);
    canvas.drawPath(path, paint);
  }

  void _drawBell(Canvas canvas, Paint paint, double x, double y) {
    final bellPath = Path();
    bellPath.addOval(Rect.fromCenter(center: Offset(x, y - 8), width: 10, height: 10));
    bellPath.addRect(Rect.fromLTWH(x - 7, y - 8, 14, 15));
    bellPath.addArc(Rect.fromLTWH(x - 7, y + 2, 14, 10), 0, 3.14);
    canvas.drawPath(bellPath, paint);
    
    final clapper = Path();
    clapper.addOval(Rect.fromCenter(center: Offset(x, y + 8), width: 3, height: 3));
    canvas.drawPath(clapper, paint);
  }

  void _drawPhone(Canvas canvas, Paint paint, double x, double y) {
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(x, y), width: 12, height: 20),
      const Radius.circular(2),
    );
    canvas.drawRRect(rect, paint);
    
    final screen = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(x, y - 3), width: 8, height: 12),
      const Radius.circular(1),
    );
    canvas.drawRRect(screen, paint);
    
    canvas.drawCircle(Offset(x, y + 6), 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}