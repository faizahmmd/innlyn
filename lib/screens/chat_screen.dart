import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innlyn/core/services/navigation_service.dart';
import 'package:innlyn/widgets/chat_card_widget.dart';
import 'package:provider/provider.dart';

import '../core/colors.dart';
import '../core/providers/app_provider.dart';
import '../widgets/textfield.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textEditingController = TextEditingController();
  late StreamSubscription<bool> keyboardSubscription;
  bool keyboard = false;
  @override
  void initState() {
    super.initState();

    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      if(visible){
        setState(() {
          keyboard = true;
        });
      }else{
        setState(() {
          keyboard = false;
        });
      }

    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: greyLight1.withOpacity(0.7)
    ));
    final appProvider = Provider.of<AppProvider>(context, listen: true);
    return Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: pureWhite,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: pureWhite,
                        boxShadow: [
                          BoxShadow(
                              color:greyLight1.withOpacity(0.5),
                              blurRadius: 5.0,
                              spreadRadius: 5,
                              offset: const Offset(1,1)//New
                          )
                        ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 35.0, right: 35, top: 16, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width:50,
                                  height: 50,
                                  child: Stack(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Container(
                                                decoration: const BoxDecoration(
                                                    color: pureWhite,
                                                    shape: BoxShape.circle
                                                ),
                                                child: Image.asset('assets/icons/connector_dummy.png', fit: BoxFit.fill)
                                            )
                                        ),
                                        Positioned(
                                            top: 0,
                                            right: 2,
                                            child: Container(
                                                width: 10,
                                                height: 10,
                                                decoration: const BoxDecoration(
                                                    color: primaryColor,
                                                    shape: BoxShape.circle
                                                )
                                            )
                                        )
                                      ]
                                  )),
                              const SizedBox(
                                width: 15
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width/2.1,
                                      child: Text(
                                          'Sam Leon',
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: GoogleFonts.poppins(
                                              color: pureBlack,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600
                                          )
                                      )
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width/2.1,
                                      child: Text(
                                          'Active',
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
                                ]
                              )
                            ]
                          ),
                          GestureDetector(
                            onTap: (){
                              navigationService.navigatePop();
                            },
                            child: Container(
                              width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: pureWhite,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color:greyLight1.withOpacity(0.5),
                                          blurRadius: 5.0,
                                          spreadRadius: 5,
                                          offset: const Offset(1,1)//New
                                      )
                                    ]
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: SvgPicture.asset('assets/icons/close_icon.svg', color: pureBlack)
                                )
                            ),
                          )
                        ]
                      )
                    )
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                        itemCount: appProvider.chatList.length,
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        itemBuilder: (BuildContext context, int index) {
                          return ChatCardWidget(isUserSender: appProvider.chatList[index].isUserSender, message: appProvider.chatList[index].message, imageUrl: appProvider.chatList[index].imageUrl, time: appProvider.chatList[index].time, index: index);
                        })
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 25),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: greyLight4,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: CustomTextField(prefixIcon: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SvgPicture.asset('assets/icons/smiley_icon.svg')
                                ), maxLines: 1, textSize: 12, textAlignCenter: false, showBorder: false, showShadow: true, textEditingController: textEditingController, onChanged: (value){}, hintText: 'Type here...', onSubmit: (value) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                })
                          )),
                          const SizedBox(
                            width: 15
                          ),
                          GestureDetector(
                            onTap: (){
                            },
                            child: Container(
                                width: 48,
                                height: 48,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: SvgPicture.asset('assets/icons/microphone_icon.svg', color: pureWhite, width: 20, height: 28),
                                )
                            ),
                          )
                        ]
                    )
                  )
                ]
              )
          )
        )
    );
  }
}
