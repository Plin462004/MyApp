// Pages/Language.dart
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final List<Map<String, dynamic>> languages = [
    {'name': 'ລາວ', 'locale': Locale('LA'), 'flag': 'assets/flags/laos.png'},
    {'name': 'English', 'locale': Locale('EN'), 'flag': 'assets/flags/usa.png'},
    {'name': 'ไทย', 'locale': Locale('TH'), 'flag': 'assets/flags/Thai.png'},
    {'name': 'Chinese', 'locale': Locale('CH'), 'flag': 'assets/flags/ch.png'},
    {'name': 'Vietnamese', 'locale': Locale('VI'), 'flag': 'assets/flags/vietnam.png'},
  ];

  late Locale selectedLocale;

  @override
  void initState() {
    super.initState();
    // หลีกเลี่ยงการใช้ context.locale ที่นี่
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedLocale = context.locale; // ปลอดภัยในการใช้ context ที่นี่
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'select_language'.tr(),
          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: Colors.grey[50],
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          itemCount: languages.length,
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey[300],
            indent: 14,
            endIndent: 14,
            height: 1,
          ),
          itemBuilder: (context, index) {
            final language = languages[index];
            final Locale locale = language['locale'];

            return ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
              leading: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(language['flag']),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                  ],
                ),
              ),
              title: Text(
                language['name'],
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
              ),
              trailing: selectedLocale == locale
                  ? const Icon(Icons.check_circle, color: Colors.green, size: 20)
                  : null,
              onTap: () async {
                await context.setLocale(locale);
                setState(() => selectedLocale = locale);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${'language_selected'.tr()}: ${language['name']}'),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
