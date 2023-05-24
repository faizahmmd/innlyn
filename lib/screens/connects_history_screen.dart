import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innlyn/core/services/navigation_service.dart';

import '../core/colors.dart';
import '../widgets/connects_history_list_card_widget.dart';
import '../widgets/icon_button.dart';

class ConnectsHistoryScreen extends StatefulWidget {
  const ConnectsHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ConnectsHistoryScreen> createState() => _ConnectsHistoryScreenState();
}

class _ConnectsHistoryScreenState extends State<ConnectsHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
            children: [
Padding(
  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
  child:   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CustomIconButton(imagePath: 'assets/icons/back_arrow.svg', onTap: (){
        navigationService.navigatePop();
      }),
      Text(
          'Connects History',
          textAlign: TextAlign.start,
          style: GoogleFonts.poppins(
              color: pureBlack,
              fontSize: 22,
              fontWeight: FontWeight.w600
          )
      ),
      const SizedBox(
          width: 30,
          height: 30
      )
    ]
  ),
),
              const SizedBox(
                height: 25
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                    itemCount: 15,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return const ConnectHistoryListCardWidget();
                    }),
              )
            ]
          ),
        )
      ),
    );
  }
}
