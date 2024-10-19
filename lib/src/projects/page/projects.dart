// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:portfolio/src/widget/title_texts.dart';
import 'package:url_launcher/url_launcher.dart';

class Projects extends StatelessWidget {
  final bool isDarkMode;
  const Projects({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth;
        double horizontalPadding = maxWidth * 0.05;
        double verticalPadding = 50.0;

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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TitleTexts(
                    texts: "Some Things I've Worked on",
                    fontWeight: FontWeight.w400,
                    color: isDarkMode
                        ? const Color.fromARGB(255, 211, 207, 207)
                        : Colors.black,
                    fontSize: getAdaptiveFontSize(maxWidth),
                  ),
                  const SizedBox(height: 40),
                  ProjectGrid(isDarkMode: isDarkMode),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  double getAdaptiveFontSize(double maxWidth) {
    if (maxWidth > 1200) return 32;
    if (maxWidth > 900) return 28;
    if (maxWidth > 600) return 24;
    return 20;
  }
}

class ProjectGrid extends StatelessWidget {
  final bool isDarkMode;

  const ProjectGrid({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;
        double childAspectRatio;

        if (constraints.maxWidth > 1200) {
          crossAxisCount = 3;
          childAspectRatio = 1.1;
        } else if (constraints.maxWidth > 900) {
          crossAxisCount = 2;
          childAspectRatio = 1.2;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 2;
          childAspectRatio = 1.3;
        } else {
          crossAxisCount = 1;
          childAspectRatio = 1.4;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: 35,
              mainAxisSpacing: 35,
            ),
            itemCount: projectData.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final project = projectData[index];
              return ProjectCard(
                padding: project.padding,
                color: project.color,
                gradient: project.gradient,
                imageUrl: project.imageUrl,
                title: project.title,
                description: project.description,
                url: project.url,
                isDarkMode: isDarkMode,
              );
            },
          ),
        );
      },
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String url;
  final Gradient? gradient;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final bool isDarkMode;

  const ProjectCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.url,
    required this.isDarkMode,
    this.color,
    required this.padding,
    this.gradient,
  });

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: widget.isDarkMode ? Colors.black38 : Colors.grey[200],
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Calculate adaptive sizes
              double imageHeight = constraints.maxHeight * 0.55;
              double titleFontSize = constraints.maxHeight * 0.06;
              double descriptionFontSize = constraints.maxHeight * 0.04;
              double iconSize = constraints.maxHeight * 0.07;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: imageHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: widget.color,
                      gradient: widget.gradient,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: widget.padding,
                      child: Image.asset(
                        widget.imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w600,
                              color: widget.isDarkMode
                                  ? const Color.fromARGB(255, 243, 187, 19)
                                  : Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Expanded(
                            child: Text(
                              widget.description,
                              style: TextStyle(
                                fontSize: descriptionFontSize,
                                color: widget.isDarkMode
                                    ? Colors.white70
                                    : Colors.black87,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              icon: Icon(
                                Icons.open_in_new,
                                color: widget.isDarkMode
                                    ? const Color.fromARGB(255, 243, 187, 19)
                                    : Colors.black,
                                size: iconSize,
                              ),
                              onPressed: () => launchUrl(Uri.parse(widget.url)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProjectData {
  final String imageUrl;
  final String title;
  final String description;
  final String url;
  final Color? color;
  final Gradient? gradient;
  final EdgeInsetsGeometry padding;

  ProjectData({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.url,
    this.color,
    this.gradient,
    required this.padding,
  });
}

final List<ProjectData> projectData = [
  ProjectData(
    imageUrl: 'images/gyj.png',
    title: 'Gets you Job',
    description:
        'An app to create job listings and find job opportunities based on your preferences.',
    url: 'https://github.com/Kayasthaaa/GetsYOuJob',
    color: const Color.fromRGBO(0, 176, 116, 1),
    padding: const EdgeInsets.all(10),
  ),
  ProjectData(
    imageUrl: 'images/gov.png',
    title: 'Memory Plantation',
    description:
        'A government app where users can plant trees in memory of loved ones, supporting reforestation efforts.',
    url:
        'https://play.google.com/store/apps/details?id=com.moitfekarnali.memory_plantation&hl=en&gl=US',
    color: Colors.white,
    padding: const EdgeInsets.all(10),
  ),
  ProjectData(
    imageUrl: 'images/back.png',
    title: 'Map My Tree',
    description:
        'The admin-side of Memory Plantation, where admins plant trees selected by users for the reforestation project.',
    url:
        'https://play.google.com/store/apps/details?id=com.moitfekarnali.map_my_tree&hl=en&gl=US',
    color: Colors.white,
    padding: const EdgeInsets.all(0),
  ),
  ProjectData(
    imageUrl: 'images/gov.png',
    title: 'Gunaso',
    description:
        'A government app to anonymously or non-anonymously file complaints about societal issues.',
    url: 'https://gitlab.com/Kayasthaaa/gunaso/-/tree/second?ref_type=heads',
    gradient: const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color.fromARGB(255, 224, 224, 224),
        Color.fromARGB(255, 199, 180, 243),
        Color.fromARGB(255, 185, 159, 248),
        Color.fromARGB(255, 120, 97, 160),
        Color.fromARGB(255, 121, 82, 189),
        Colors.deepPurple,
        Color.fromARGB(255, 80, 44, 141),
      ],
    ),
    padding: const EdgeInsets.all(10),
  ),
  ProjectData(
    imageUrl: 'images/eatfitlogo.png',
    title: 'Eat Fit',
    description:
        'A fitness-focused app where users set schedules, choose meals, and have food delivered based on dietary preferences.',
    url: 'https://github.com/Kayasthaaa/EatFit',
    color: Colors.white,
    padding: const EdgeInsets.all(10),
  ),
  ProjectData(
    imageUrl: 'images/jew.png',
    title: 'Jewellery App',
    description:
        'An online jewelry shopping app offering a range of jewelry products with home delivery options.',
    url:
        'https://www.figma.com/design/bLQP9V1MFm2GWKeu1gIRUB/JewelryApp?node-id=2-3&node-type=canvas&t=XJAOP8FPD0j03CNK-0',
    color: Colors.white,
    padding: const EdgeInsets.all(10),
  ),
  ProjectData(
    imageUrl: 'images/rpa.png',
    title: 'Logistics',
    description:
        'A package delivery app allowing users to schedule pickups, send parcels, and track deliveries to their desired address.',
    url:
        'https://www.figma.com/design/d6vDd33vOAxOr2qYHAd4kN/Logistics?node-id=0-1&node-type=canvas&t=uwQJyHRrjAxVYzmC-0',
    color: Colors.white,
    padding: const EdgeInsets.all(10),
  ),
  ProjectData(
    imageUrl: 'images/icon.png',
    title: 'Trippy',
    description:
        'A travel app for planning trips, meeting new people, and enjoying group travel experiences.',
    url: 'https://github.com/Kayasthaaa/Trippy/tree/eigth',
    color: Colors.white,
    padding: const EdgeInsets.all(10),
  ),
  ProjectData(
    imageUrl: 'images/Logo.png',
    title: 'Mediflow',
    description:
        'A digital health platform for ordering medicines, booking appointments, and managing medical records—your personal healthcare assistant.',
    url: 'https://github.com/Kayasthaaa/Mediflow',
    color: Colors.white,
    padding: const EdgeInsets.all(10),
  ),
];
