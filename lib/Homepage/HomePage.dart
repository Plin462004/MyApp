// Homepage/HomePage.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'LocationPickerPage.dart';
import 'package:myflutter/Menu/DetailPage.dart';
import 'package:myflutter/Pages/Notification.dart'; // Import the notifications page

void main() => runApp(const Dokkeo());

class Dokkeo extends StatelessWidget {
  const Dokkeo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maxim App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
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
  String? fromLocation, toLocation;
  
  // สร้างตัวแปรสำหรับจำนวนการแจ้งเตือน (0 คือไม่มีการแจ้งเตือน)
  int notificationCount = 0;

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
  void initState() {
    super.initState();
    // สำหรับการทดสอบ สามารถเปลี่ยนค่า notificationCount ได้ที่นี่
    // notificationCount = 9; // ถ้าต้องการทดสอบว่ามีการแจ้งเตือน
    notificationCount = 0; // ถ้าต้องการทดสอบว่าไม่มีการแจ้งเตือน
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            _buildLocationFields(),
            const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
            const Expanded(child: SizedBox()),
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: const [
          Text("D",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          Text("o",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal)),
          Text("kkeo",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ],
      ),
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined,
                  color: Colors.black87, size: 26),
              onPressed: () {
                // Navigate to the notifications page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationsPage()),
                );
              },
            ),
            // แสดงจำนวนการแจ้งเตือนเฉพาะเมื่อมีการแจ้งเตือน (notificationCount > 0)
            if (notificationCount > 0)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      notificationCount.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)
                    ),
                  ),
                ),
              ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.black87, size: 24),
          onPressed: () {
            // Navigate to settings page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          },
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _buildLocationFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16.0, vertical: 8.0), // Reduced vertical padding
      child: Column(
        children: [
          _buildLocationTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.red,
              radius: 14, // Reduced size
              child: Icon(Icons.location_on,
                  color: Colors.white, size: 16), // Reduced size
            ),
            title: fromLocation ?? 'เดินทางจาก',
            onTap: () => _pickLocation((result) {
              setState(() => fromLocation =
                  'Lat: ${result.latitude.toStringAsFixed(5)}, Lng: ${result.longitude.toStringAsFixed(5)}');
            }),
          ),
          const SizedBox(height: 6), // Reduced space between fields
          _buildLocationTile(
            leading: CircleAvatar(
              backgroundColor: Colors.teal,
              radius: 14, // Reduced size
              child: const Text('🏳️',
                  style: TextStyle(
                      color: Colors.white, fontSize: 10)), // Reduced size
            ),
            title: toLocation ?? 'ไปที่',
            onTap: () => _pickLocation((result) {
              setState(() => toLocation =
                  'Lat: ${result.latitude.toStringAsFixed(5)}, Lng: ${result.longitude.toStringAsFixed(5)}');
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationTile(
      {required Widget leading,
      required String title,
      required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 0), // Reduced vertical padding
        minVerticalPadding: 0, // Set minimum vertical padding to 0
        visualDensity: const VisualDensity(
            horizontal: 0, vertical: -4), // Make the tile more compact
        leading: leading,
        title: Text(title,
            style: const TextStyle(fontSize: 14)), // Reduced font size
        trailing:
            const Icon(Icons.chevron_right, size: 18), // Reduced icon size
        onTap: onTap,
      ),
    );
  }

  Future<void> _pickLocation(Function(LatLng) onLocationPicked) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationPickerPage()),
    );
    if (result != null && result is LatLng) {
      onLocationPicked(result);
    }
  }

  Widget _buildBottomActions() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, -2))
        ],
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              minVerticalPadding: 0,
              leading:
                  const Icon(Icons.info_outline, color: Colors.teal, size: 20),
              title: const Text('รายละเอียด',
                  style: TextStyle(fontSize: 13, color: Colors.teal)),
              onTap: () {
                // นำทางไปยังหน้ารายละเอียด
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DetailPage()),
                );
              },
            ),
          ),
          const SizedBox(height: 6),
          _buildActionButtons(),
          const SizedBox(height: 8),
          _buildServiceChoices(),
          const SizedBox(height: 10),
          _buildOrderButton(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildSmallButton(Icons.money, 'เงินสด'),
        ),
        const SizedBox(width: 6), // Reduced spacing
        Expanded(
          child: _buildSmallButton(Icons.access_time, 'ตอนนี้'),
        ),
      ],
    );
  }

  Widget _buildSmallButton(IconData icon, String text) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 8, vertical: 0), // Reduced vertical padding
        visualDensity: const VisualDensity(
            horizontal: 0, vertical: -4), // Make the tile more compact
        minVerticalPadding: 0, // Set minimum vertical padding to 0
        leading: Icon(icon, color: Colors.teal, size: 18), // Reduced icon size
        title: Text(text,
            style: const TextStyle(
                fontSize: 13, color: Colors.teal)), // Reduced font size
        onTap: () {},
      ),
    );
  }

  Widget _buildServiceChoices() {
    return Row(
      children: [
        Expanded(
          child: _buildServiceOption(
            image: 'assets/cars/car.png',
            title: 'รถยนต์',
            price: 'เริ่มต้น ₭15000',
            isSelected: selectedService == 'car',
            onTap: () {
              setState(() => selectedService = 'car');
              _showServiceOptionsDialog('car');
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildServiceOption(
            image: 'assets/cars/images.png',
            title: 'มอเตอร์ไซค์',
            price: 'เริ่มต้น ₭10000',
            isSelected: selectedService == 'motorcycle',
            onTap: () {
              setState(() => selectedService = 'motorcycle');
              _showServiceOptionsDialog('motorcycle');
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildServiceOption(
            image: 'assets/cars/download.png',
            title: 'การจัดส่ง',
            price: 'เริ่มต้น ₭10000',
            isSelected: selectedService == 'delivery',
            onTap: () {
              setState(() => selectedService = 'delivery');
              _showServiceOptionsDialog('delivery');
            },
          ),
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
        // Remove fixed width to allow expansion
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.teal : const Color(0xFFEEEEEE),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        child: Column(
          children: [
            Image.asset(
              image, 
              height: 45, // เพิ่มความสูงของรูปจาก 36 เป็น 45
              fit: BoxFit.contain
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            Text(price,
                style: TextStyle(fontSize: 10, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderButton() {
    return SizedBox(
      width: double.infinity,
      height: 44, // Reduced height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        ),
        onPressed: () {},
        child: const Text(
          'เรียกรถ',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  void _showServiceOptionsDialog(String serviceType) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
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
                  Text(
                    serviceTitles[serviceType] ?? 'เลือกบริการ',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
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
                                  ? Colors.teal
                                  : const Color(0xFFEEEEEE),
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            visualDensity: const VisualDensity(
                                horizontal: 0,
                                vertical: -2), // Make the tile more compact
                            title: Text(
                              option['name'] ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            trailing: Text(
                              option['price'] ?? '',
                              style: TextStyle(
                                color:
                                    isSelected ? Colors.teal : Colors.grey[600],
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            onTap: () {
                              setModalState(() {
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
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'ยืนยัน',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
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

// Placeholder for Settings Page
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ການຕັ້ງຄ່າ", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Colors.teal),
            title: const Text("ໂປຮຟາຍ"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.history, color: Colors.teal),
            title: const Text("ປະຫວັດການເດີນທາງ"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.payment, color: Colors.teal),
            title: const Text("ພາກພື້ນ"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.language, color: Colors.teal),
            title: const Text("ພາສາ"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.temple_buddhist_outlined, color: Colors.teal),
            title: const Text("ຮູບເເບບ"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}