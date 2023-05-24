import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';
import 'button.dart';
import 'connects_history_list_card_widget.dart';

class IncomingRequestWidget extends StatefulWidget {
  final VoidCallback onAccept, onReject;
  const IncomingRequestWidget({Key? key, required this.onAccept, required this.onReject}) : super(key: key);

  @override
  State<IncomingRequestWidget> createState() => _IncomingRequestWidgetState();
}

class _IncomingRequestWidgetState extends State<IncomingRequestWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height/1.0,
        width: MediaQuery.of(context).size.width/1.0,
        child: DraggableScrollableSheet(
            minChildSize:0.78,
            maxChildSize: 1,
            initialChildSize: 0.78,
            builder: (BuildContext context, ScrollController scrollController) {
              return Stack(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height/1.0,
                      width: MediaQuery.of(context).size.width/1.0,
                      decoration: BoxDecoration(
                          color: pureWhite,
                          boxShadow: [
                          BoxShadow(
                          color:greyLight1.withOpacity(0.5),
              blurRadius: 5.0,
              spreadRadius: 5,
              offset: const Offset(1,1)//New
              )
              ],
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))
                      ),
                      child: Center(
                        child: SingleChildScrollView(
                            controller: scrollController,
                            physics: const NeverScrollableScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 43.0, right: 43, top: 35, bottom: 43),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/1.3,
                                  child: Text(
                                      'Sam Leon requesting to you for connection.... ',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          color: pureBlack,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500
                                      )
                                  )
                                ),
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height/200
                                  ),
                                  AvatarGlow(
                                    glowColor: primaryColor,
                                    endRadius: 80.0,
                                    duration: const Duration(milliseconds: 1000),
                                    repeat: true,
                                    showTwoGlows: true,
                                    repeatPauseDuration: const Duration(milliseconds: 200),
                                    child: Material(     // Replace this child with your own
                                      elevation: 8.0,
                                      shape: const CircleBorder(),
                                      child: CircleAvatar(
                                        backgroundColor: pureWhite.withOpacity(0.4),
                                        foregroundColor: pureWhite,
                                        radius: 40.0,
                                        child: Image.asset(
                                          'assets/icons/connector_dummy.png',
                                          height: 70,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height/200
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width/1.3,
                                      child: Text(
                                          'Sam Leon',
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: GoogleFonts.poppins(
                                              color: pureBlack,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600
                                          )
                                      )
                                  ),
                                  const SizedBox(
                                      height: 1
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width/1.3,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/icons/black_marker_icon.svg', color: pureBlack, width: 16, height: 16),
                                          const SizedBox(
                                              width: 5
                                          ),
                                          Text(
                                              'Kundanahalli Gate',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                  color: pureBlack,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400
                                              )
                                          ),
                                        ],
                                      )
                                  ),
                                  const SizedBox(
                                      height: 1
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width/1.3,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.only(top: 1),
                                            child: Text(
                                                '4.3',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                    color: pureBlack,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400
                                                )
                                            ),
                                          ),
                                          const SizedBox(
                                              width: 5
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 1.0),
                                            child: SvgPicture.asset('assets/icons/star.svg', width: 14, height: 14),
                                          )

                                        ]
                                      )
                                  ),
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height/50
                                  ),
                                  const Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: greyLight1
                                  ),
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height/50
                                  ),
                                  Container(
                                      height: 55,
                                      width: MediaQuery.of(context).size.width/1.3,
                                      color: transparentColor,
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
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
                                  ),
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height/50
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 70,
                                        height: MediaQuery.of(context).size.height/20,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: greyLight1

                                        ),
                                        child: Center(
                                          child: Text(
                                              'Price',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: GoogleFonts.poppins(
                                                  color: pureBlack,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400
                                              )
                                          ),
                                        )
                                      ),
                                      const SizedBox(width: 20),
                                      Container(
                                          width: 70,
                                          height: MediaQuery.of(context).size.height/20,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: primaryColor

                                          ),
                                          child: Center(
                                            child: Text(
                                                '\u{20B9} 3000',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: GoogleFonts.poppins(
                                                    color: pureWhite,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600
                                                )
                                            ),
                                          )
                                      )
                                    ]
                                  ),
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height/50
                                  ),
                                  const Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: greyLight1
                                  ),
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height/30
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height/16,
                                        child: CustomButton(buttonLabel: 'Reject', buttonWidth: MediaQuery.of(context).size.width/3.2, backGroundColor: errorColor, onTap: widget.onReject),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context).size.width/10
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context).size.height/16,
                                        child: CustomButton(buttonLabel: 'Accept', buttonWidth: MediaQuery.of(context).size.width/3.2, backGroundColor: primaryColor, onTap: widget.onAccept
)
                                      )
                                    ]
                                  ),
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height/50
                                  ),
                                ]
                              ),
                            )
                        ),
                      )
                  )
                ],
              );
            }
        )
    );
  }
}
