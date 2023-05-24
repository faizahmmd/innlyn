import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:innlyn/core/colors.dart';

class SocialSignInButton extends StatefulWidget {
  final String buttonImage;
  final VoidCallback onTap;
  final Color borderColor;
  final double width, height, iconWidth, iconHeight;
  const SocialSignInButton({Key? key, required this.buttonImage, required this.onTap, required this.borderColor, required this.width, required this.height, required this.iconWidth, required this.iconHeight}) : super(key: key);

  @override
  State<SocialSignInButton> createState() => _SocialSignInButtonState();
}

class _SocialSignInButtonState extends State<SocialSignInButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: widget.borderColor, width: 0.7)
              )

          ),
          fixedSize: MaterialStateProperty.all(Size(widget.width, widget.height)),
          backgroundColor: MaterialStateProperty.all(pureWhite)
      ),
      onPressed: widget.onTap,
      child: Padding(
        padding: EdgeInsets.all(widget.buttonImage=='assets/icons/apple.svg'?4: 10.0),
        child: SvgPicture.asset(widget.buttonImage, width: widget.iconWidth, height: widget.iconHeight),
      ),
    );
  }
}
