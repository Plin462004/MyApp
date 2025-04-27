// main.dart
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'Setting/Setting.dart';
import 'Menu/FoodMenuPage.dart';
import 'Homepage/HomePage.dart';
import 'Homepage/Delivery.dart';

// *** เพิ่มฟังก์ชัน main() ตรงนี้ ***
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('lo')], // ภาษาอังกฤษ, ภาษาลาว
      path: 'assets/Lang', // เปลี่ยนตรงนี้ถ้าโฟลเดอร์ภาษาอยู่ที่อื่น
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}
// *******************************************

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'แอปของฉัน',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const MainHomePage(),
    );
  }
}

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int selectedIndex = 0;

  final List<Widget> _pages = const [
    Dokkeo(),
    FoodMenuPage(),
    MaximApp(),
    Setting(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            child: Row(
              children: List.generate(4, (index) {
                return Expanded(
                  child: Container(
                    color: selectedIndex == index ? Colors.teal : Colors.transparent,
                  ),
                );
              }),
            ),
          ),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.teal,
            unselectedItemColor: Colors.grey[500],
            currentIndex: selectedIndex,
            onTap: onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: "ຫນ້າຫຼັກ".tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.cable),
                label: "ອໍເດີ".tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.star),
                label: "ລາຍການໂປດ".tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.menu),
                label: "ເມນູ".tr(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
