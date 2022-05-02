import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide Provider;
import 'package:paynon/controller/user_controller.dart';
import 'package:paynon/utils/constant/color_constats.dart';
import 'package:paynon/utils/constant/image_constants.dart';
import 'package:paynon/utils/constant/text_constants.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1.0),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: WillPopScope(
            onWillPop: () async => false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(ImageConstants.LOGIN_PATH),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Wrap(
                    runSpacing: 25,
                    children: [
                      const Text(
                        TextConstants.LOGIN_TEXT,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                      Wrap(
                        runSpacing: 20,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.email_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                TextConstants.EMAIL_TEXT,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Colors.black),
                            decoration: InputDecoration(
                                hintText: TextConstants.EMAIL_PLACEHOLDER_TEXT,
                                isDense: true,
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey.withOpacity(0.4),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 12),
                                enabledBorder: border,
                                focusedBorder: border
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                        runSpacing: 20,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.lock_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                TextConstants.PASSWORD_TEXT,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Colors.black),
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: TextConstants.PASSWORD_PLACEHOLDER_TEXT,
                                isDense: true,
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey.withOpacity(0.4),
                                ),

                                //suffixIcon: IconButton(
                                //  splashRadius: 6,
                                //  icon: Icon(
                                //    Icons.visibility_off_outlined,
                                //    color: Colors.grey.withOpacity(0.7),
                                //  ),
                                //  onPressed: () {
                                //    //TODO
                                //  },
                                //),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 12),
                                enabledBorder: border,
                                focusedBorder: border
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                TextConstants.FORGOT_PASSWORD,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    children: [
                      ElevatedButton(
                          onPressed: () {

                          },
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 40)),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xffEAE4FF)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                              ))),
                          child: const Text(
                            TextConstants.SIGNUP_PASSWORD,
                            style: TextStyle(
                                fontSize: 20,
                                color: ColorConstants.blue,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins"),
                          )
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 50
                                  )
                              ),
                              backgroundColor: MaterialStateProperty.all(ColorConstants.blue),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))
                              )
                          ),
                          child: const Text(
                            TextConstants.LOGIN_TEXT,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins"),
                          )
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const Text(
                        TextConstants.GOOGLE_LOGIN_TEXT,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Poppins"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          ref.read(userControllerProvider.notifier).login();
                        },
                        borderRadius: BorderRadius.circular(32),
                        child: Image.asset(
                          ImageConstants.GOOGLE_LOGO_PATH,
                          scale: 50,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                )
              ],
            ),
          ),
        ));
  }
}
