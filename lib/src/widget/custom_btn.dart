// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:portfolio/src/widget/app_texts.dart';

class CustomModeButton extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onPressed;
  final String text;

  const CustomModeButton({
    super.key,
    required this.isDarkMode,
    required this.onPressed,
    required this.text,
  });

  @override
  _CustomModeButtonState createState() => _CustomModeButtonState();
}

class _CustomModeButtonState extends State<CustomModeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: 169,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color.fromARGB(255, 243, 187, 19)
                : (widget.isDarkMode
                    ? Colors.grey.shade800
                    : const Color.fromARGB(255, 201, 198, 198)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(
                Icons.file_download,
                size: 17,
                color: _isHovered
                    ? Colors.white
                    : (widget.isDarkMode ? Colors.white : Colors.black),
              ),
              const SizedBox(width: 5),
              Texts(
                texts: widget.text,
                color: _isHovered
                    ? Colors.white
                    : (widget.isDarkMode ? Colors.white : Colors.black),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
