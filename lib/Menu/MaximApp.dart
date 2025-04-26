// Menu/MaximApp.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'LocationPickerPage.dart'; // สมมติว่าคุณสร้างตามที่บอกไป

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
  String selectedService = 'car';
  String selectedCarOption = 'standard';
  String selectedMotorcycleOption = 'standard';
  String selectedDeliveryOption = 'small';

  String? fromLocation;
  String? toLocation;

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
            // Header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Text("m",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Text("a",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                      Text("xim",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                  const Text("Vientiane",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),

            // Location Fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // From location
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
                      title: Text(
                        fromLocation ?? 'เดินทางจาก',
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LocationPickerPage(),
                          ),
                        );
                        if (result != null && result is LatLng) {
                          setState(() {
                            fromLocation =
                                'Lat: ${result.latitude.toStringAsFixed(5)}, Lng: ${result.longitude.toStringAsFixed(5)}';
                          });
                        }
                      },
                    ),
                  ),

                  // To location
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal[800],
                        child: const Text('ไป',
                            style: TextStyle(color: Colors.white)),
                      ),
                      title: Text(
                        toLocation ?? 'ไปที่',
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LocationPickerPage(),
                          ),
                        );
                        if (result != null && result is LatLng) {
                          setState(() {
                            toLocation =
                                'Lat: ${result.latitude.toStringAsFixed(5)}, Lng: ${result.longitude.toStringAsFixed(5)}';
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
            ),

            const Expanded(child: SizedBox()),

            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(20)), // เพิ่มขอบโค้งด้านบน
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // รายละเอียด
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: const Icon(Icons.info_outline, color: Colors.blueGrey),
                title: const Text(
                  'รายละเอียด',
                  style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                ),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildSmallButton(Icons.money, 'เงินสด', () {}),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildSmallButton(Icons.access_time, 'ตอนนี้', () {}),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildServiceChoices(),
            const SizedBox(height: 12),
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallButton(IconData icon, String text, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueGrey),
        title: Text(text,
            style: const TextStyle(fontSize: 16, color: Colors.blueGrey)),
        onTap: onTap,
      ),
    );
  }

  Widget _buildServiceChoices() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildServiceOption(
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
        _buildServiceOption(
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
        _buildServiceOption(
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
    );
  }

  Widget _buildServiceOption({
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
            color:
                isSelected ? const Color(0xFFFFCC00) : const Color(0xFFEEEEEE),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            Image.asset(image, height: 50, fit: BoxFit.contain),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(price,
                style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  void _showServiceOptionsDialog(String serviceType) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            String selectedOption = serviceType == 'car'
                ? selectedCarOption
                : serviceType == 'motorcycle'
                    ? selectedMotorcycleOption
                    : selectedDeliveryOption;

            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      serviceTitles[serviceType] ?? 'เลือกบริการ',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: serviceOptions[serviceType]?.length ?? 0,
                      itemBuilder: (context, index) {
                        final option = serviceOptions[serviceType]?[index];
                        if (option == null) return const SizedBox.shrink();

                        bool isSelected = option['id'] == selectedOption;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFFFCC00)
                                  : const Color(0xFFEEEEEE),
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            title: Text(
                              option['name'] ?? '',
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            trailing: Text(
                              option['price'] ?? '',
                              style: TextStyle(
                                color: isSelected
                                    ? const Color(0xFFFFCC00)
                                    : Colors.grey[600],
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            onTap: () {
                              setModalState(() {
                                if (serviceType == 'car') {
                                  selectedCarOption =
                                      option['id'] ?? 'standard';
                                } else if (serviceType == 'motorcycle') {
                                  selectedMotorcycleOption =
                                      option['id'] ?? 'standard';
                                } else {
                                  selectedDeliveryOption =
                                      option['id'] ?? 'small';
                                }
                                selectedOption = option['id'] ?? '';
                              });

                              setState(() {
                                if (serviceType == 'car') {
                                  selectedCarOption =
                                      option['id'] ?? 'standard';
                                } else if (serviceType == 'motorcycle') {
                                  selectedMotorcycleOption =
                                      option['id'] ?? 'standard';
                                } else {
                                  selectedDeliveryOption =
                                      option['id'] ?? 'small';
                                }
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
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
                          fontSize: 16,
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
      },
    );
  }
}
