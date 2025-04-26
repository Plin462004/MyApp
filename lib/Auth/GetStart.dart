// Auth/GetStart.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SignUpScreen.dart';
import 'package:myflutter/Pages/Language.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      title: 'Welcom to Dokkeo App',
      description:
          'ແອັບພິເຄຊັນ ສໍາລັບເອີ້ນລົດ ບໍ່ວ່າທ່ານຈະໄປໃສ່ ກໍສະດວກສະບາຍເເຄ່ໃນເເອບດ່ຽວ',
      image: 'assets/cars/greetings.png',
    ),
    OnboardingData(
      title: 'ລົດຍົນ ',
      description: 'ສາມາດສະແກນ QR ແລະ ບາຣໂຄດໄດ້ຢ່າງໄວ ແລະ ຖືກຕ້ອງ',
      image: 'assets/cars/car.png',
    ),
    OnboardingData(
      title: 'ລົດຈັກ ',
      description: 'ວາງແຜນອາຫານ ໃຫ້ເໝາະສົມກັບແຕ່ລະຄົນ',
      image: 'assets/cars/images.png',
    ),
    OnboardingData(
      title: 'ຝາກສົ່ງພັດສະດຸຂອງທ່ານ',
      description: 'ວາງແຜນອາຫານ ໃຫ້ເໝາະສົມກັບແຕ່ລະຄົນ',
      image: 'assets/cars/download.pg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPage > 0
                      ? IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        )
                      : SizedBox(width: 40),
                  IconButton(
                    icon: Icon(Icons.language, color: Colors.teal),
                    onPressed: () => _navigateToLanguagePage(),
                    tooltip: 'เลือกภาษา',
                  ),
                ],
              ),
            ),
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _onboardingData.length,
                  itemBuilder: (context, index) {
                    return _buildOnboardingPage(_onboardingData[index]);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_currentPage < _onboardingData.length - 1)
                    TextButton(
                      onPressed: _navigateToLoginPage,
                      child: Text('Skip', style: TextStyle(color: Colors.teal)),
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardingData.length,
                  (index) => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: _currentPage == index ? 24 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.teal
                          : Colors.teal.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 40.0,
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage < _onboardingData.length - 1) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    _navigateToLoginPage();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 18,
                  ),
                  minimumSize: Size(200, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 3,
                ),
                child: Text(
                  _currentPage < _onboardingData.length - 1
                      ? 'Next'
                      : 'Get Started',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 3,
            child: Container(
              constraints: BoxConstraints(maxHeight: 250),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.teal, width: 2),
              ),
              child: ClipOval(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    data.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          Text(
            data.title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            data.description,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  void _navigateToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  // void _navigateToSignUpPage() {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => SignUpScreen()),
  //   );
  // }

  void _navigateToLanguagePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LanguagePage()),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String image;

  OnboardingData({
    required this.title,
    required this.description,
    required this.image,
  });
}
