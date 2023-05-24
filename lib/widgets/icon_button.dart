import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/colors.dart';

class CustomIconButton extends StatefulWidget {
  final String imagePath;
  final VoidCallback onTap;
  const CustomIconButton({Key? key, required this.imagePath, required this.onTap}) : super(key: key);

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            color: pureWhite,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color:greyLight1.withOpacity(0.5),
                blurRadius: 5.0,
                spreadRadius: 5,
          offset: const Offset(1,1)
              )
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: SvgPicture.asset(widget.imagePath, color: pureBlack)
        )
      )
    );
  }
}
