import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paynon/screens/login/login_screen.dart';
import 'package:paynon/screens/welcome/welcome_second.dart';
import 'package:paynon/utils/constant/color_constats.dart';
import 'package:paynon/utils/constant/image_constants.dart';
import 'package:paynon/utils/constant/text_constants.dart';
import 'package:paynon/widgets/state_widget.dart';

class WelcomeFirst extends StatelessWidget {
  const WelcomeFirst({Key? key}) : super(key: key);

  final defaultPadding = const EdgeInsets.symmetric(horizontal: 40);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, right: 40, left: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            ImageConstants.LOGO_PATH,
                            scale: 12.0,
                          ),
                          const Text(
                            TextConstants.PAYNON_TEXT,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 25,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        TextConstants.WELCOME_TEXT,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  ImageConstants.CARD_PATH,
                ),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        TextConstants.PAY_SAFE_TEXT,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        TextConstants.PAY_SAFE_DESC_TEXT,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Poppins",
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(right: 40, left: 40, bottom: 40),
              //margin: defaultPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    spacing: 5,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        decoration: const BoxDecoration(
                          color: Color(0xff676767),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xffC4C4C4),
                          shape: BoxShape.circle,
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => const WelcomeSecond(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ));
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 40)
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(ColorConstants.blue),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                                  )
                              )
                      ),
                      child: const Text(
                        TextConstants.START_NOW_TEXT,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: "Raleway"
                        ),
                      )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
