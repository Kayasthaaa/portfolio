import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/src/contact/widgets/contact_widget.dart';
import 'package:portfolio/src/widget/app_texts.dart';
import 'package:portfolio/src/widget/title_texts.dart';
import 'package:url_launcher/url_launcher.dart';

class GetInTouch extends StatelessWidget {
  final bool isDarkMode;
  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'pkayastha6@gmail.com',
    query: 'subject=Contact from Portfolio&body=Hello Prajesh,',
  );

  GetInTouch({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: Container(
        padding: const EdgeInsets.all(20),
        color: isDarkMode ? Colors.black : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 67),
            TitleTexts(
              texts: 'Get In Touch',
              fontWeight: FontWeight.w400,
              color: isDarkMode
                  ? const Color.fromARGB(255, 211, 207, 207)
                  : Colors.black,
              fontSize: 34,
            ),
            const SizedBox(height: 30),
            _buildTextItem(
              "Let's build something amazing together—drop me a line, and let the magic begin! My keyboard's ready, your project's next, and I'm here to turn your ideas into reality. Whether it's big or small, let's make things happen and create something extraordinary!",
              12,
              isDarkMode,
            ),
            const SizedBox(height: 50),
            CustomBtn(
              isDarkMode: isDarkMode,
              onPressed: _launchEmail,
              text: 'Email Me',
            ),
            const SizedBox(height: 80),
            _buildSocialIcons(),
            const Spacer(),
            Texts(
              texts: '${DateTime.now().year} Kayastha © All Rights Reserved',
              fontSize: 11,
              color: isDarkMode
                  ? const Color.fromARGB(255, 216, 216, 216)
                  : Colors.black,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcons() {
    final iconColor =
        isDarkMode ? const Color.fromARGB(255, 235, 232, 232) : Colors.black;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIconButton(FontAwesomeIcons.github,
            'https://github.com/Kayasthaaa?tab=repositories', iconColor),
        const SizedBox(width: 10),
        _buildSocialIconButton(
            FontAwesomeIcons.linkedin,
            'https://www.linkedin.com/in/prajesh-kayastha-1208901b2/',
            iconColor),
        const SizedBox(width: 10),
        _buildSocialIconButton(FontAwesomeIcons.instagram,
            'https://www.instagram.com/prajesh_kayastha/', iconColor),
      ],
    );
  }

  Widget _buildSocialIconButton(IconData icon, String url, Color color) {
    return IconButton(
      icon: FaIcon(icon),
      onPressed: () => _launchURL(url),
      iconSize: 20,
      color: color,
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  Future<void> _launchEmail() async {
    if (await canLaunchUrl(_emailLaunchUri)) {
      await launchUrl(_emailLaunchUri);
    }
  }
}

Widget _buildTextItem(String text, double maxWidth, bool isDarkMode) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 60.0),
    child: Texts(
      texts: text,
      color:
          isDarkMode ? const Color.fromARGB(255, 235, 232, 232) : Colors.black,
      fontSize: maxWidth < 800 ? 15 : 13,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w400,
    ),
  );
}
