// Menu/MaximApp.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MaximApp());
}

class MaximApp extends StatelessWidget {
  const MaximApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maxim App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ตัวแปรเก็บประเภทบริการที่เลือก
  String selectedService = 'car';
  
  // ตัวแปรเก็บตัวเลือกย่อยของแต่ละบริการ
  String selectedCarOption = 'standard';
  String selectedMotorcycleOption = 'standard';
  String selectedDeliveryOption = 'small';
  
  // ข้อมูลตัวเลือกย่อยสำหรับแต่ละบริการ
  final Map<String, List<Map<String, String>>> serviceOptions = {
    'car': [
      {'id': 'standard', 'name': 'รถยนต์มาตรฐาน', 'price': '₭15000'},
      {'id': 'premium', 'name': 'รถยนต์พรีเมียม', 'price': '₭20000'},
      {'id': 'suv', 'name': 'รถ SUV', 'price': '₭25000'},
    ],
    'motorcycle': [
      {'id': 'standard', 'name': 'มอเตอร์ไซค์ทั่วไป', 'price': '₭10000'},
      {'id': 'fast', 'name': 'มอเตอร์ไซค์เร็ว', 'price': '₭12000'},
    ],
    'delivery': [
      {'id': 'small', 'name': 'พัสดุขนาดเล็ก', 'price': '₭10000'},
      {'id': 'medium', 'name': 'พัสดุขนาดกลาง', 'price': '₭15000'},
      {'id': 'large', 'name': 'พัสดุขนาดใหญ่', 'price': '₭20000'},
    ],
  };

  // ชื่อหัวข้อสำหรับป็อปอัพของแต่ละบริการ
  final Map<String, String> serviceTitles = {
    'car': 'ประเภทรถยนต์',
    'motorcycle': 'ประเภทมอเตอร์ไซค์',
    'delivery': 'ประเภทการจัดส่ง',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with logo and city
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Maxim logo
                  Row(
                    children: [
                      const Text(
                        "m",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        "a",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const Text(
                        "xim",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  // City name
                  const Text(
                    "Vientiane",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            
            // Location fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // From location button
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(Icons.location_on, color: Colors.white),
                      ),
                      title: const Text(
                        'เดินทางจาก',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {},
                    ),
                  ),
                  
                  // To location button
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal[800],
                        child: const Text('ไป', style: TextStyle(color: Colors.white)),
                      ),
                      title: const Text(
                        'ไปที่',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            
            // Divider line
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
            ),
            
            // Expanded empty space (map would go here in a real app)
            const Expanded(
              child: SizedBox(),
            ),
            
            // Bottom action area
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Details button
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.info_outline, color: Colors.blueGrey),
                        title: const Text(
                          'รายละเอียด',
                          style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                        ),
                        onTap: () {},
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    // Payment and time options
                    Row(
                      children: [
                        // Payment method
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.money, color: Colors.blueGrey),
                              title: const Text(
                                'เงินสด',
                                style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 10),
                        
                        // Time option
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.access_time, color: Colors.blueGrey),
                              title: const Text(
                                'ตอนนี้',
                                style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Service options with prices
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Car option
                        _buildServiceOption(
                          context,
                          image: 'assets/cars/car.png',
                          title: 'รถยนต์',
                          price: 'เริ่มต้น ₭15000',
                          isSelected: selectedService == 'car',
                          onTap: () {
                            setState(() {
                              selectedService = 'car';
                            });
                            _showServiceOptionsDialog('car');
                          },
                        ),
                        
                        // Motorcycle option
                        _buildServiceOption(
                          context,
                          image: 'assets/cars/images.png',
                          title: 'มอเตอร์ไซค์',
                          price: 'เริ่มต้น ₭10000',
                          isSelected: selectedService == 'motorcycle',
                          onTap: () {
                            setState(() {
                              selectedService = 'motorcycle';
                            });
                            _showServiceOptionsDialog('motorcycle');
                          },
                        ),
                        
                        // Delivery option
                        _buildServiceOption(
                          context,
                          image: 'assets/cars/download.png',
                          title: 'การจัดส่ง',
                          price: 'เริ่มต้น ₭10000',
                          isSelected: selectedService == 'delivery',
                          onTap: () {
                            setState(() {
                              selectedService = 'delivery';
                            });
                            _showServiceOptionsDialog('delivery');
                          },
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Call taxi button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFCC00),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'เรียกรถ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // แสดงป็อปอัพเลือกตัวเลือกย่อยของบริการ
  void _showServiceOptionsDialog(String serviceType) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        // ดึงค่าตัวเลือกปัจจุบันของบริการนี้
        String currentSelected = '';
        switch (serviceType) {
          case 'car':
            currentSelected = selectedCarOption;
            break;
          case 'motorcycle':
            currentSelected = selectedMotorcycleOption;
            break;
          case 'delivery':
            currentSelected = selectedDeliveryOption;
            break;
        }
        
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    serviceTitles[serviceType]!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: serviceOptions[serviceType]!.length,
                itemBuilder: (context, index) {
                  final option = serviceOptions[serviceType]![index];
                  final bool isSelected = option['id'] == currentSelected;
                  
                  return InkWell(
                    onTap: () {
                      // อัพเดทตัวเลือกที่เลือก
                      setState(() {
                        switch (serviceType) {
                          case 'car':
                            selectedCarOption = option['id']!;
                            break;
                          case 'motorcycle':
                            selectedMotorcycleOption = option['id']!;
                            break;
                          case 'delivery':
                            selectedDeliveryOption = option['id']!;
                            break;
                        }
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFFFF8E1) : Colors.white,
                        border: Border(
                          left: BorderSide(
                            color: isSelected ? const Color(0xFFFFCC00) : Colors.transparent,
                            width: 5,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              option['name']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            Text(
                              option['price']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFCC00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'ยืนยัน',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // สร้าง Widget สำหรับตัวเลือกหลักด้านล่าง (รถยนต์, มอเตอร์ไซค์, การจัดส่ง)
  Widget _buildServiceOption(
    BuildContext context, {
    required String image,
    required String title,
    required String price,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFFFFCC00) : const Color(0xFFEEEEEE),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 50,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              price,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}