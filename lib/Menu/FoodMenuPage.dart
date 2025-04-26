// Menu/FoodMenuPage.dart
import 'package:flutter/material.dart';
import 'package:myflutter/Menu/map.dart';

import '../Auth/GetStart.dart';
import '../Auth/LoginCard.dart';
import '../Menu/map.dart';

class FoodMenuPage extends StatefulWidget {
  const FoodMenuPage({super.key});

  @override
  State<FoodMenuPage> createState() => _FoodMenuPageState();
}

class _FoodMenuPageState extends State<FoodMenuPage> {
  late PageController _pageController;
  int _currentPage = 0;
  final int _bannerCount = 4;
  bool _isDisposed = false;
  final int _virtualPageCount = 10000;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _virtualPageCount ~/ 2);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isDisposed) {
        Future.delayed(const Duration(seconds: 5), _autoSlide);
      }
    });
  }

  void _autoSlide() {
    if (!_isDisposed && _pageController.hasClients) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      if (!_isDisposed) {
        Future.delayed(const Duration(seconds: 4), _autoSlide);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isPad = screenWidth > 768;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: _buildDrawer(),
      appBar: AppBar(
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
                setState(() {
                  // highlight สูตรอาหาร
                });
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
                setState(() {});
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 160,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      if (!_isDisposed) {
                        setState(() {
                          _currentPage = index % _bannerCount;
                        });
                      }
                    },
                    itemBuilder: (context, index) {
                      return _buildBanner(
                          "assets/images/salar${(index % _bannerCount) + 1}.png");
                    },
                    itemCount: _virtualPageCount,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          _bannerCount,
                          (index) => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentPage == index
                                      ? Colors.teal
                                      : Colors.white.withOpacity(0.7),
                                ),
                              )),
                    ),
                  )
                ],
              ),
            ),
            // Summary Cards - Responsive Grid
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildSummaryCard(
                    "assets/icons/mental-health.png",
                    "Tasks",
                    "0 Tasks",
                    Colors.blue,
                    width: isTablet
                        ? (screenWidth - 64) / 4
                        : (screenWidth - 48) / 2,
                  ),
                  _buildSummaryCard(
                    "assets/icons/service.png",
                    "Habits",
                    "0 Habits",
                    Colors.pink,
                    width: isTablet
                        ? (screenWidth - 64) / 4
                        : (screenWidth - 48) / 2,
                  ),
                  _buildSummaryCard(
                    "assets/icons/learning.png",
                    "Finances",
                    "0 Expenses",
                    Colors.teal,
                    width: isTablet
                        ? (screenWidth - 64) / 4
                        : (screenWidth - 48) / 2,
                  ),
                  _buildSummaryCard(
                    "assets/icons/greetings.png",
                    "Wellness",
                    "1 Entries",
                    Colors.black87,
                    width: isTablet
                        ? (screenWidth - 64) / 4
                        : (screenWidth - 48) / 2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Tags - Allow to wrap based on screen size
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildTag("🥖 ปราศจากกลูเตน"),
                  _buildTag("🍎 โซเดียมต่ำ"),
                  _buildTag("🪐 โปรตีนสูง"),
                  _buildTag("🪀 หัวใจแข็งแรง"),
                  _buildTag("🦬 มังสวิรัติ"),
                  _buildTag("🥦 วีแกน"),
                  _buildTag("🌽 คีโต")
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("ບໍລິການຂອງພວກເຮົາ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("เพิ่มเติม", style: TextStyle(color: Colors.teal[700]))
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Scrollable Service Cards - Using icons instead of images
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildServiceCard(
                    Icons.directions_car,
                    "ລົດຍົນ ເລີ່ມຕົ້ນ 10.000 Kip",
                    Colors.blue,
                    width: isPad ? 180 : 160,
                  ),
                  _buildServiceCard(
                    Icons.motorcycle,
                    "ລົດຈັກ ເລີ່ມຕົ້ນ 10.000 Kip",
                    Colors.orange,
                    width: isPad ? 180 : 160,
                  ),
                  _buildServiceCard(
                    Icons.delivery_dining,
                    "ການຈັດສົ່ງ ເລີ່ມຕົ້ນ 10.000 Kip",
                    Colors.green,
                    width: isPad ? 180 : 160,
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Full-width bottom cards
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
              child: Column(
                children: [
                  _buildFullWidthCard(
                    Icons.check_circle_outline,
                    "Tasks",
                    "0 Tasks",
                    Colors.blue,
                  ),
                  const SizedBox(height: 12),
                  _buildFullWidthCard(
                    Icons.access_time,
                    "Schedule",
                    "No upcoming events",
                    Colors.teal,
                  ),
                  const SizedBox(height: 12),
                  _buildFullWidthCard(
                    Icons.bar_chart,
                    "Statistics",
                    "View your progress",
                    Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Drawer และฟังก์ชันอื่นๆ คงเดิม
  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            accountName: Text(
              "ชื่อผู้ใช้",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text("user@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.teal,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.login, color: Colors.teal),
            title: const Text('Log In'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GetStartedScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock_reset, color: Colors.teal),
            title: const Text('Log'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginCard()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.teal),
            title: const Text('Get'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GetStartedScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.restaurant_menu, color: Colors.teal),
            title: const Text('MAP'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite, color: Colors.teal),
            title: const Text('รายการโปรด'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.logout),
              label: const Text("ออกจากระบบ"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner(String imagePath) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(color: Colors.teal[900])),
    );
  }

  // New method to build service cards with icons instead of images
  Widget _buildServiceCard(IconData icon, String title, Color color,
      {double? width}) {
    return Container(
      width: width ?? 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 48,
                color: color,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // Updated to accept dynamic width
  Widget _buildSummaryCard(
      String imagePath, String title, String subtitle, Color color,
      {double? width}) {
    return Container(
      width: width ?? (MediaQuery.of(context).size.width - 48) / 2,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            height: 28,
            width: 28,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 14)),
        ],
      ),
    );
  }

  // New full-width card widget
  Widget _buildFullWidthCard(
      IconData icon, String title, String subtitle, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 36),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    _pageController.dispose();
    super.dispose();
  }
}
