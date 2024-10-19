import 'package:flutter/material.dart';
import 'package:portfolio/src/about_me/page/about_me.dart';
import 'package:portfolio/src/contact/page/contact.dart';
import 'package:portfolio/src/header/page/header.dart';
import 'package:portfolio/src/projects/page/projects.dart';
import 'package:portfolio/src/experience/experience.dart';
import 'package:portfolio/src/widget/app_texts.dart';

class PortfolioContent extends StatefulWidget {
  const PortfolioContent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PortfolioContentState createState() => _PortfolioContentState();
}

class _PortfolioContentState extends State<PortfolioContent> {
  bool _isDarkMode = true;
  final ScrollController _scrollController = ScrollController();

  final Map<String, GlobalKey> _sectionKeys = {
    'header': GlobalKey(),
    'about': GlobalKey(),
    'experience': GlobalKey(),
    'projects': GlobalKey(),
    'contact': GlobalKey(),
  };

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _scrollToSection(String sectionKey) {
    final key = _sectionKeys[sectionKey];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
    // Only pop the navigator if we're in a drawer
    if (Scaffold.of(context).isDrawerOpen) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool isSmallScreen = constraints.maxWidth < 800;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
            elevation: 0,
            title: Row(
              children: [
                Expanded(
                  child: Texts(
                    texts: 'Portfolio',
                    color: _isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                if (!isSmallScreen)
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildNavItem('Home', 'header'),
                        _buildNavItem('About', 'about'),
                        _buildNavItem('Experience', 'experience'),
                        _buildNavItem('Projects', 'projects'),
                        _buildNavItem('Contact', 'contact'),
                      ],
                    ),
                  ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(_isDarkMode
                            ? Icons.wb_sunny
                            : Icons.nightlight_round),
                        onPressed: _toggleDarkMode,
                        color: _isDarkMode ? Colors.white : Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            iconTheme:
                IconThemeData(color: _isDarkMode ? Colors.white : Colors.black),
          ),
          drawer: isSmallScreen
              ? Drawer(
                  child: Container(
                    color: _isDarkMode ? Colors.grey[900] : Colors.white,
                    child: ListView(
                      children: [
                        DrawerHeader(
                          decoration: BoxDecoration(
                            color: _isDarkMode ? Colors.black : Colors.blue,
                          ),
                          child: const Texts(
                            texts: 'Menu',
                            color: Colors.white,
                          ),
                        ),
                        _buildDrawerItem('Home', 'header'),
                        _buildDrawerItem('About', 'about'),
                        _buildDrawerItem('Experience', 'experience'),
                        _buildDrawerItem('Projects', 'projects'),
                        _buildDrawerItem('Contact', 'contact'),
                      ],
                    ),
                  ),
                )
              : null,
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Header(key: _sectionKeys['header'], isDarkMode: _isDarkMode),
                AboutMe(
                  key: _sectionKeys['about'],
                  isDarkMode: _isDarkMode,
                  toggleDarkMode: _toggleDarkMode,
                ),
                Experience(
                    key: _sectionKeys['experience'], isDarkMode: _isDarkMode),
                Projects(
                    key: _sectionKeys['projects'], isDarkMode: _isDarkMode),
                GetInTouch(
                    key: _sectionKeys['contact'], isDarkMode: _isDarkMode),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(String title, String sectionKey) {
    return TextButton(
      onPressed: () => _scrollToSection(sectionKey),
      child: Text(
        title,
        style: TextStyle(
          color: _isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String title, String sectionKey) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: _isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      onTap: () => _scrollToSection(sectionKey),
    );
  }
}
