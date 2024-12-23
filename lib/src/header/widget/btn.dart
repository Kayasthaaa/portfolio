// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:portfolio/src/widget/app_texts.dart';

class HeaderBtn extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onPressed;
  final String text;

  const HeaderBtn({
    super.key,
    required this.isDarkMode,
    required this.onPressed,
    required this.text,
  });

  @override
  _HeaderBtnState createState() => _HeaderBtnState();
}

class _HeaderBtnState extends State<HeaderBtn> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: 155,
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.grey.shade800
                : (widget.isDarkMode
                    ? const Color.fromARGB(255, 243, 187, 19)
                    : const Color.fromARGB(255, 201, 198, 198)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.waving_hand_sharp,
                size: 17,
                color: _isHovered
                    ? Colors.white
                    : (widget.isDarkMode ? Colors.white : Colors.black),
              ),
              const SizedBox(width: 8),
              Texts(
                texts: widget.text,
                color: _isHovered
                    ? Colors.white
                    : (widget.isDarkMode ? Colors.white : Colors.black),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
