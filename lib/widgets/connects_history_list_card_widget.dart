import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innlyn/core/colors.dart';

class ConnectHistoryListCardWidget extends StatefulWidget {
  const ConnectHistoryListCardWidget({Key? key}) : super(key: key);

  @override
  State<ConnectHistoryListCardWidget> createState() => _ConnectHistoryListCardWidgetState();
}

class _ConnectHistoryListCardWidgetState extends State<ConnectHistoryListCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.5, horizontal: 25),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: pureWhite,
          borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color:greyLight1.withOpacity(0.4),
                blurRadius: 6,
                spreadRadius: 3,
                offset: const Offset(1,1)//New
              )
            ]
        ),
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 55,
                    color: transparentColor,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                     const Padding(
                       padding: EdgeInsets.only(top: 7.0, right: 7),
                       child: DottedWidget(),
                     ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: transparentColor,
                              child: Text(
                                  'Sarjapur',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(
                                      color: pureBlack,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                  )
                              )
                            ),
                            const SizedBox(height: 10),
                            Container(
                                color: transparentColor,
                                child: Text(
                                    'Marathahalli Rd',
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.poppins(
                                        color: pureBlack,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                    )
                                )
                            )
                          ],
                        )
                      ]
                    )
                  )
                ),
                Container(
                  height: 55,
                  color: transparentColor,
                  child:  Text(
                      '\u{20B9} 300',
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                          color: pureBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w400
                      )
                  )
                )
              ]
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(height: 1, thickness: 1, color: greyLight1),
            ),
            Container(
                height: 25,
                color: transparentColor,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 15),
                        Text(
                            'Wed, Feb 08, 08:12 Am',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.poppins(
                                color: greyLight2,
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                            )
                        )

                      ]
                    ),
                    Text(
                        'Dropped',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400
                        )
                    )
                  ]
                )
            )
          ]
        )
        )
      ),
    );
  }
}

class DottedWidget extends StatelessWidget {
  const DottedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/green_dot_icon.svg', width: 8, height: 8),

          Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.3),
              child: Container(
                width: 1,
                height: 1,
                color: greyLight,
              )
          ),  Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.3),
              child: Container(
                width: 1,
                height: 1.5,
                color: greyLight,
              )
          ),  Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.3),
              child: Container(
                width: 1,
                height: 1.5,
                color: greyLight,
              )
          ),  Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.3),
              child: Container(
                width: 1,
                height: 1.5,
                color: greyLight,
              )
          ),  Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.3),
              child: Container(
                width: 1,
                height: 1,
                color: greyLight,
              )
          ),
          SvgPicture.asset('assets/icons/red_marker_icon.svg', width: 15, height: 15),
        ]
    );
  }
}

