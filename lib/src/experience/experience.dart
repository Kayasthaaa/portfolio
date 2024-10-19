import 'package:flutter/material.dart';
import 'package:portfolio/src/widget/app_texts.dart';
import 'package:portfolio/src/widget/title_texts.dart';

class Experience extends StatefulWidget {
  final bool isDarkMode;

  const Experience({super.key, required this.isDarkMode});

  @override
  // ignore: library_private_types_in_public_api
  _ExperienceState createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
  String selectedCompany = 'Khaanpin';

  final Map<String, Map<String, dynamic>> companies = {
    'Khaanpin': {
      'period': '2023 - Current',
      'position': 'Flutter Developer',
      'details': [
        'Led identity fraud detection analysis using anomaly detection, clustering, and classification techniques, leading to improved fraud detection and prevention measures',
        'Led supervised learning model to predict future worker performance based on their current experience',
        'Developed proof of concept of volume forecasting models for capacity management across diverse client scenarios',
        'Participated in ad hoc analysis for the experiment conducted, playing a key role in generating and interpreting the outcome results to drive data-driven decision-making processes and inform future strategies',
        'Conducted knowledge sessions on AI for the engineering team as well as external stakeholders, sharing insights and best practices to enhance understanding and adoption of AI technologies both within and outside the company',
        'Collaborated with cross-functional teams, including data engineers, business analysts, and product managers, to identify business problems, design analytics solutions, and communicate findings.',
      ],
    },
    'Intropros Technologies': {
      'period': '2022 - 2023',
      'position': 'Flutter Developer',
      'details': [
        'Developed and published 6 Flutter apps across various industries, including government and international clients, with a focus on performance, user experience, and scalability.',
        'Led the development of 3 government apps—Map My Tree, Memory Plantation, and Gunaso—focusing on engaging citizens in environmental and social initiatives.',
        'Handled 2 international app clients, overseeing the development of logistics and e-commerce platforms (Jshop), ensuring smooth project delivery and client satisfaction.',
        'Led and mentored a team of interns, providing guidance on Flutter development best practices, code quality, and project management.',
        'Successfully led a project team from concept to completion for an in-house app (Gets You Job), collaborating with stakeholders to deliver a job-matching platform'
      ],
    },
    'Mediflow Solutions': {
      'period': '2021 - 2022',
      'position': 'Flutter Developer',
      'details': [
        'Developed and published two medical apps',
        'Collaborated closely with doctors and government officials to ensure app features align with medical standards and user needs.',
        'Led the end-to-end development of mobile applications, including UI design, API integration, and performance optimization.',
        'Ensured compliance with medical regulations and privacy standards while integrating innovative features.',
        'Engaged in agile development practices to deliver timely updates and bug fixes based on user feedback.'
      ],
    },
    'Nepal Payment Solutions': {
      'period': '2020 - 2021',
      'position': 'Native App Developer Intern',
      'details': [
        'Played a significant role in developing Urban Rooms, a room rental app, using Native Java, handling the end-to-end implementation of essential features',
        'Collaborated with senior developers to enhance functionality for multiple high-security banking apps, working with sensitive data.',
        'Gained experience in debugging, troubleshooting, and improving app performance in a high-stakes environment'
      ],
    },
    'Easy Design Solutiions': {
      'period': '2019 - 2020',
      'position': 'Event Handling Assistant and Web Developer',
      'details': [
        'Assisted in the planning and execution of multiple medical events, ensuring smooth coordination and timely completion of event-related tasks.',
        'Gained hands-on experience in project management by overseeing logistics, schedules, and team coordination for various events.',
        'Collaborated with cross-functional teams, including medical professionals and event organizers, to manage attendee registrations and ensure seamless event operations.',
        'Contributed to web development tasks, including designing and maintaining event websites to enhance user experience and improve attendee engagement.',
        'Leveraged technical expertise to integrate event information, schedules, and updates on digital platforms, improving accessibility for participants.',
        'Assisted in troubleshooting real-time technical issues during events, ensuring minimal disruption and smooth flow of operations.',
        'Demonstrated excellent time management and multitasking skills by balancing event handling responsibilities with web development projects.'
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth;
        double height = MediaQuery.of(context).size.height * 0.999;
        return Container(
          width: maxWidth,
          height: height,
          color: widget.isDarkMode ? Colors.black : Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 60),
              TitleTexts(
                texts: 'Experience',
                fontWeight: FontWeight.w400,
                color: widget.isDarkMode
                    ? const Color.fromARGB(255, 211, 207, 207)
                    : Colors.black,
                fontSize: 34,
              ),
              const SizedBox(height: 10),
              const Texts(
                texts: 'Roles that have shaped my expertise.',
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 243, 187, 19),
                fontSize: 17,
              ),
              const SizedBox(height: 50),
              Expanded(
                child:
                    maxWidth > 800 ? _buildWideLayout() : _buildNarrowLayout(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWideLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: _buildCompanyList(),
        ),
        const SizedBox(width: 40),
        const VerticalDivider(
          color: Color.fromARGB(255, 243, 187, 19),
          thickness: 1,
          width: 1,
        ),
        Expanded(
          flex: 2,
          child: _buildCompanyDetails(),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: _buildCompanyList(),
        ),
        const Divider(
          color: Color.fromARGB(255, 243, 187, 19),
          thickness: 1,
          height: 1,
        ),
        Expanded(
          flex: 2,
          child: _buildCompanyDetails(),
        ),
      ],
    );
  }

  Widget _buildCompanyList() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double listWidth =
            constraints.maxWidth > 600 ? 300 : constraints.maxWidth * 0.8;
        double horizontalPadding = constraints.maxWidth > 600
            ? 160
            : 100; // Significantly increased left padding
        return Container(
          padding: EdgeInsets.only(left: horizontalPadding),
          color: widget.isDarkMode ? Colors.black : Colors.white,
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: listWidth,
              child: ListView(
                padding: const EdgeInsets.only(
                    top: 24), // Added top padding to match details section
                children: companies.keys.map((company) {
                  bool isSelected = company == selectedCompany;
                  return IntrinsicWidth(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (widget.isDarkMode
                                ? const Color.fromARGB(255, 243, 187, 19)
                                : const Color.fromARGB(255, 196, 196, 196))
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        title: Texts(
                          texts: company,
                          fontSize: 16,
                          color: isSelected
                              ? (widget.isDarkMode
                                  ? Colors.white
                                  : Colors.black87)
                              : (widget.isDarkMode
                                  ? const Color.fromARGB(255, 243, 187, 19)
                                  : Colors.black),
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        subtitle: Texts(
                          texts: companies[company]!['period'],
                          fontSize: 14,
                          color: isSelected
                              ? (widget.isDarkMode
                                  ? Colors.white70
                                  : Colors.black54)
                              : (widget.isDarkMode
                                  ? Colors.white70
                                  : Colors.black54),
                        ),
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        onTap: () {
                          setState(() {
                            selectedCompany = company;
                          });
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompanyDetails() {
    final details = companies[selectedCompany]!;
    return LayoutBuilder(
      builder: (context, constraints) {
        double horizontalPadding = constraints.maxWidth > 600 ? 75 : 16;
        return Container(
          padding: EdgeInsets.only(left: horizontalPadding, right: 24),
          color: widget.isDarkMode ? Colors.black : Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24), // Added to align with company list
              Text(
                details['position'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: widget.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Texts(
                texts: details['period'],
                fontSize: 18,
                textAlign: TextAlign.justify,
                color: widget.isDarkMode ? Colors.white70 : Colors.black54,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: (details['details'] as List<String>).map((detail) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.arrow_right,
                              color: Color.fromARGB(255, 243, 187, 19)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Texts(
                              texts: detail,
                              color: widget.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
