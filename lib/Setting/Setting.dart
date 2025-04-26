// Setting/Setting.dart
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomePage(),
      routes: {
       
        '/report': (context) => const DummyPage(title: 'ລີວິວການບໍລິການ'),
        '/support': (context) => const DummyPage(title: 'ຝ່າຍສະໜັບສະໜຸນ'),
        '/payment': (context) => const DummyPage(title: 'ຮູບແບບການຊຳລະເງິນ'),
        '/promo': (context) => const DummyPage(title: 'ໂຄດໂປຣໂມຊັ່ນ'),
        '/about': (context) => const DummyPage(title: 'ຂໍ້ມູນແອບ'),
        '/share': (context) => const DummyPage(title: 'ແຊຣ໌ລິ້ງສຳລັບໂຫຼດແອັບຯ'),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Increased the height of the AppBar from kToolbarHeight to 80
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: InkWell(
              onTap: () {
                // You can add navigation or action here if needed
                Navigator.pushNamed(context, '/about');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50, // Increased size
                          height: 50, // Increased size
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Dokkeo",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("ສຸລັນ ໄຊຍະວົງ", style: TextStyle(fontSize: 16)),
                            Text("+856 20 7665 4347", style: TextStyle(fontSize: 14, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Image.asset('assets/cars/car.png', fit: BoxFit.contain),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "ສ້າງລາຍໄດ້ໃນການເດີນທາງ",
                        style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 255, 255, 255)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black26,
                            foregroundColor: Colors.white,
                            // Increased vertical padding from 10 to 15 for a taller button
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            "ລົງທະບຽນເປັນຄົນຂັບລົດ",
                            style: TextStyle(fontSize: 16), // Increased font size
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                _buildMenuItem(context, Icons.message_outlined, "ລີວິວການບໍລິການ", '/report'),
                _buildMenuItem(context, Icons.report_problem, "ຝ່າຍສະໜັບສະໜຸນ", '/support'),
                _buildMenuItem(context, Icons.notifications, "ການແຈ້ງເຕືອນ", '/notifications'),
                _buildMenuItem(context, Icons.payment, "ຮູບແບບການຊຳລະເງິນ", '/payment'),
                _buildMenuItem(context, Icons.confirmation_number, "ໂຄດໂປຣໂມຊັ່ນ", '/promo'),

                Container(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/share');
                        },
                        child: Text("ແຊຣ໌ລິ້ງສຳລັບໂຫຼດແອັບຯ", style: TextStyle(color: Colors.grey[700])),
                      ),
                      const Icon(Icons.share, color: Colors.grey),
                    ],
                  ),
                ),

                _buildMenuItem(context, Icons.info, "ຂໍ້ມູນແອບ", '/about'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String text, String route) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[700], size: 24),
            const SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}

class DummyPage extends StatelessWidget {
  final String title;
  const DummyPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("ກັບຄືນ"),
            ),
          ],
        ),
      ),
    );
  }
}