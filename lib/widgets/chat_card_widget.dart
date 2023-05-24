import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/colors.dart';

class ChatCardWidget extends StatefulWidget {
  final bool isUserSender;
  final int index;
  final String message, time, imageUrl;
  const ChatCardWidget({Key? key, required this.isUserSender, required this.message, required this.time, required this.imageUrl, required this.index}) : super(key: key);

  @override
  State<ChatCardWidget> createState() => _ChatCardWidgetState();
}

class _ChatCardWidgetState extends State<ChatCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.index==0?24:0, bottom: 24),
      child: Row(
        mainAxisAlignment: widget.isUserSender?MainAxisAlignment.start:MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.isUserSender?Container(
            width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  color: pureWhite,
                  shape: BoxShape.circle
              ),
              child: Image.asset(widget.imageUrl, fit: BoxFit.fill)
          ):Container(),
          widget.isUserSender?const SizedBox(
            width: 12
          ):Container(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: widget.isUserSender?CrossAxisAlignment.start:CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width/1.6),
                decoration: BoxDecoration(
                  color: widget.isUserSender?greyLight4:primaryColor,
                  borderRadius: BorderRadius.only(topRight: const Radius.circular(26), topLeft: const Radius.circular(26), bottomLeft: Radius.circular(widget.isUserSender?0:26), bottomRight: Radius.circular(widget.isUserSender?26:0))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                      widget.message,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.visible,
                      maxLines: null,
                      style: GoogleFonts.poppins(
                          color: widget.isUserSender?pureBlack:pureWhite,
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                      )
                  )
                )
              ),

              Padding(
                padding: EdgeInsets.only(left: widget.isUserSender?5.0:0, top: 2, right: widget.isUserSender?0:5),
                child: Text(
                    widget.time,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.visible,
                    maxLines: null,
                    style: GoogleFonts.poppins(
                        color: pureBlack,
                        fontSize: 7,
                        fontWeight: FontWeight.w600
                    )
                ),
              )
            ]
          ),
          widget.isUserSender?Container():const SizedBox(
              width: 12
          ),
          widget.isUserSender?Container():Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  color: pureWhite,
                  shape: BoxShape.circle
              ),
              child: Image.asset(widget.imageUrl, fit: BoxFit.fill)
          ),
        ]
      )
    );
  }
}
