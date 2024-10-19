import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/src/header/widget/btn.dart';
import 'package:portfolio/src/widget/app_texts.dart';
import 'package:url_launcher/url_launcher.dart';

class Header extends StatelessWidget {
  final bool isDarkMode;
  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'pkayastha6@gmail.com',
    query: 'subject=Contact from Portfolio&body=Hello Prajesh,',
  );
  Header({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth;
        double height = MediaQuery.of(context).size.height * 0.96;
        return Container(
          width: maxWidth,
          height: height,
          color: isDarkMode ? Colors.black : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Lottie.asset(
                  'images/lottie.json',
                  repeat: true,
                  animate: true,
                ),
              ),
              SizedBox(height: height * 0.02),
              Texts(
                texts: 'Hi, My name is',
                color: const Color.fromARGB(255, 243, 187, 19),
                fontSize: maxWidth * 0.02,
                fontWeight: FontWeight.w700,
              ),
              Texts(
                texts: 'Prajesh Kayastha',
                color: isDarkMode
                    ? const Color.fromARGB(255, 211, 207, 207)
                    : Colors.black,
                fontSize: maxWidth * 0.04,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: height * 0.01),
              Texts(
                texts: 'Flutter dev by day, project magician by night',
                color: isDarkMode
                    ? const Color.fromARGB(255, 168, 168, 168)
                    : Colors.grey[700],
                fontSize: maxWidth * 0.02,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: height * 0.01),
              Texts(
                texts:
                    '2 years of coding, now making projects disappear... into success!',
                color: isDarkMode
                    ? const Color.fromARGB(255, 168, 168, 168)
                    : Colors.grey[700],
                fontSize: maxWidth * 0.02,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 55),
              HeaderBtn(
                isDarkMode: isDarkMode,
                onPressed: _launchEmail,
                text: 'Say Hello',
              ),
              const SizedBox(height: 55),
            ],
          ),
        );
      },
    );
  }

  Future<void> _launchEmail() async {
    if (await canLaunchUrl(_emailLaunchUri)) {
      await launchUrl(_emailLaunchUri);
    }
  }
}
