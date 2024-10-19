import 'package:flutter/material.dart';
import 'package:portfolio/src/widget/app_texts.dart';
import 'package:portfolio/src/widget/custom_btn.dart';
import 'package:portfolio/src/widget/title_texts.dart';

class AboutMe extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleDarkMode;
  const AboutMe({
    super.key,
    required this.isDarkMode,
    required this.toggleDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth;
        bool isSmallScreen = maxWidth < 800;
        return Container(
          width: maxWidth,
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color.fromRGBO(38, 38, 38, 1)
                : Colors.grey.shade50,
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? Colors.black.withOpacity(0.5)
                    : Colors.white.withOpacity(0.8),
                blurRadius: 20,
                spreadRadius: 20,
                offset: const Offset(0, -10),
              ),
            ],
          ),
          child: SizedBox(
            height: isSmallScreen ? 900 : 700,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: maxWidth * 0.07,
                vertical: isSmallScreen ? 40 : 70,
              ),
              child: isSmallScreen
                  ? _buildSmallScreenLayout(maxWidth, isDarkMode)
                  : _buildLargeScreenLayout(maxWidth, isDarkMode),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSmallScreenLayout(double maxWidth, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTexts(
          texts: 'About me',
          fontWeight: FontWeight.w400,
          color: isDarkMode
              ? const Color.fromARGB(255, 211, 207, 207)
              : Colors.black,
          fontSize: maxWidth * 0.05,
        ),
        const SizedBox(height: 30),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextSection(maxWidth, isDarkMode),
                const SizedBox(height: 30),
                CustomModeButton(
                  isDarkMode: isDarkMode,
                  onPressed: () {},
                  text: 'Download CV',
                ),
                const SizedBox(height: 30),
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'images/me.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLargeScreenLayout(double maxWidth, bool isDarkMode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 3 / 3.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'images/me.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 75),
            ],
          ),
        ),
        SizedBox(width: maxWidth * 0.05),
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleTexts(
                texts: 'About me',
                fontWeight: FontWeight.w400,
                color: isDarkMode
                    ? const Color.fromARGB(255, 211, 207, 207)
                    : Colors.black,
                fontSize: maxWidth * 0.022,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextSection(maxWidth, isDarkMode),
                      const SizedBox(height: 100),
                      CustomModeButton(
                        isDarkMode: isDarkMode,
                        onPressed: () {},
                        text: 'Download CV',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextSection(double maxWidth, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRichTextItem(
          "• Hey! I'm a Flutter wizard and proud ",
          "London Metropolitan University",
          " graduate. After 2 years of coding, I'm swapping my keyboard for a project management cape—ready to turn chaos into clarity!",
          maxWidth,
          isDarkMode,
        ),
        const SizedBox(height: 25),
        _buildTextItem(
          "•  In 2 years as a Flutter dev, I've built 8+ apps, from government projects to personal apps, and everything in between—food, medical, and travel apps included! Now, I'm diving into project management, ready to keep teams on track and projects running smoother than ever!",
          maxWidth,
          isDarkMode,
        ),
        const SizedBox(height: 25),
        _facts('• Fun facts about me', maxWidth, isDarkMode),
        const SizedBox(height: 20),
        _buildTextItem(
          '• 🚀 Once spent more time debugging than sleeping (true story, but worth it).',
          maxWidth,
          isDarkMode,
        ),
        const SizedBox(height: 20),
        _buildTextItem(
          "• 🎯 I firmly believe that pineapple does belong on pizza, and I'll defend it with passion!",
          maxWidth,
          isDarkMode,
        ),
        const SizedBox(height: 20),
        _buildTextItem(
          '• ⚽ Managed to craft 8+ apps in 2 years—and still found time to play football!',
          maxWidth,
          isDarkMode,
        ),
      ],
    );
  }

  Widget _buildTextItem(String text, double maxWidth, bool isDarkMode) {
    return Texts(
      texts: text,
      color:
          isDarkMode ? const Color.fromARGB(255, 235, 232, 232) : Colors.black,
      fontSize: maxWidth < 800 ? 15 : 13,
      textAlign: TextAlign.justify,
      fontWeight: FontWeight.w400,
    );
  }

  Widget _facts(String text, double maxWidth, bool isDarkMode) {
    return Texts(
      texts: text,
      color: isDarkMode
          ? const Color.fromARGB(255, 243, 187, 19)
          : const Color.fromARGB(255, 201, 151, 2),
      fontSize: maxWidth < 800 ? 15 : 13,
      textAlign: TextAlign.justify,
      fontWeight: FontWeight.w500,
    );
  }

  Widget _buildRichTextItem(String beforeText, String highlightedText,
      String afterText, double maxWidth, bool isDarkMode) {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        style: TextStyle(
          color: isDarkMode
              ? const Color.fromARGB(255, 235, 232, 232)
              : Colors.black,
          fontSize: maxWidth < 800 ? 15 : 13,
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(text: beforeText),
          TextSpan(
            text: highlightedText,
            style: const TextStyle(
              color: Color.fromARGB(255, 243, 187, 19),
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(text: afterText),
        ],
      ),
    );
  }
}
