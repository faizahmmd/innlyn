import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/colors.dart';

class CustomButton extends StatefulWidget {
  final String buttonLabel;
  final Color backGroundColor;
  final VoidCallback onTap;
  final bool loading;
  final double buttonWidth, buttonTextSize;
  const CustomButton({Key? key, required this.buttonLabel, required this.backGroundColor, required this.onTap, required this.buttonWidth, this.buttonTextSize = 18, this.loading = false}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: Size(widget.buttonWidth, MediaQuery.of(context).size.height/14<55?55:MediaQuery.of(context).size.height/14),
          backgroundColor: widget.backGroundColor,
          textStyle: GoogleFonts.poppins(
              color: pureWhite,
              fontSize: widget.buttonTextSize,
              fontWeight: FontWeight.w600
          )
      ),
      onPressed: widget.onTap,
      child: widget.loading?const SizedBox(width: 30, height: 30, child: CircularProgressIndicator(color: pureWhite)):Text(widget.buttonLabel),
    );
  }
}
