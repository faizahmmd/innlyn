import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innlyn/core/colors.dart';
import 'package:provider/provider.dart';

import '../core/providers/app_provider.dart';

class ConnectorListCardWidget extends StatefulWidget {
  final VoidCallback onTap;
  final String? imageUrl, name, gender, place;
  final double? distance;
  const ConnectorListCardWidget({Key? key, required this.onTap, this.imageUrl, this.name, this.gender, this.distance, this.place}) : super(key: key);

  @override
  State<ConnectorListCardWidget> createState() => _ConnectorListCardWidgetState();
}

class _ConnectorListCardWidgetState extends State<ConnectorListCardWidget> {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: true);
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
          width: double.infinity,
          height: 71,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: appProvider.selectedConnector?.name == widget.name?buttonColor:pureWhite
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Container(
                 width: 55,
                 height: 60,
                 decoration: const BoxDecoration(
                   color: greyLight1,
                   shape: BoxShape.circle,
                 ),
                 child: Image.asset(widget.imageUrl??'', fit: BoxFit.fill)
               ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                      height: 60,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              overflow: TextOverflow.ellipsis,

                              textAlign: TextAlign.start,

                              textDirection: TextDirection.rtl,

                              softWrap: true,

                              maxLines: 1,

                              textScaleFactor: 1,
                              text: TextSpan(
                                  text: widget.name??'',
                                  style: GoogleFonts.poppins(

                                      color: pureBlack,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' (${widget.gender})', style: GoogleFonts.poppins(

                                        color: pureBlack,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400
                                    ))
                                  ]
                              )
                          ),
                          Text(
                              '${widget.place}', style: GoogleFonts.poppins(
                              color: pureBlack,
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          )),
                          Text(
                              '${widget.distance} km', style: GoogleFonts.poppins(
                              color: primaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600
                          )),
                        ]
                      )
                  ),
                ),
              ]
            ),
          )
        ),
      ),
    );
  }
}
