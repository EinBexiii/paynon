
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paynon/controller/user_controller.dart';
import 'package:paynon/models/user/user_model.dart';
import 'package:paynon/utils/constant/color_constats.dart';
import 'package:paynon/utils/constant/text_constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SendMoneyWidget extends ConsumerStatefulWidget {

  final User user;
  final int currentMoney;

  const SendMoneyWidget({Key? key, required this.user, required this.currentMoney}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SendMoneyWidgetState();
  }
}

class _SendMoneyWidgetState extends ConsumerState<SendMoneyWidget> {

  int amount = 1;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaY: 5,
        sigmaX: 5,
      ),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32)),
        title: const Text(
          "Send money",
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 50, vertical: 20),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text:  TextSpan(
                children: [
                  const TextSpan(
                    text:
                    TextConstants.SEND_MONEY_TEXT,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      fontFamily: "Poppins",
                    ),
                  ),
                  TextSpan(
                    text: widget.user.firstName + " " + widget.user.lastName + "?",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    child: IconButton(
                      splashRadius: 1,
                      onPressed: () {
                        if(amount-1 >= 1) {
                          setState(() {
                            amount = amount -1;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                      color: ColorConstants.blue,
                    ),
                    backgroundColor: ColorConstants.blue,
                  ),
                  Text(
                    "\$" + amount.toString(),
                    style: const TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 22
                    ),
                  ),
                  CircleAvatar(
                    child: IconButton(
                      splashRadius: 1,
                      onPressed: () {
                        if(amount + 1 <= widget.currentMoney) {
                          setState(() {
                            amount = amount + 1;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      color: ColorConstants.blue,
                    ),
                    backgroundColor: ColorConstants.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              runSpacing: 8.0,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      BuildContext context2;
                      await ref.read(userControllerProvider.notifier).addPayment(widget.user.id, amount)
                          .then((value) => {
                            context2 = Navigator.of(context).context,
                            Navigator.pop(context),
                          })
                          .catchError((err) => {

                          });
                    },
                    style: ButtonStyle(
                        elevation:
                        MaterialStateProperty.all(0),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 60)
                        ),
                        backgroundColor:
                        MaterialStateProperty.all(
                            ColorConstants.blue),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(9)
                            )
                        )
                    ),
                    child: const Text(
                      "Send",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins"),
                    )
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        elevation:
                        MaterialStateProperty.all(0),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 60)),
                        backgroundColor:
                        MaterialStateProperty.all(
                            const Color(0xffEAE4FF)),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(9),
                            )
                        )
                    ),
                    child: const Text(
                      "Back",
                      style: TextStyle(
                          fontSize: 20,
                          color: ColorConstants.blue,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins"),
                    )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
