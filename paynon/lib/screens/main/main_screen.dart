import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paynon/controller/user_controller.dart';
import 'package:paynon/controller/user_list_controller.dart';
import 'package:paynon/models/user/user_model.dart';
import 'package:paynon/utils/constant/color_constats.dart';
import 'package:paynon/utils/constant/image_constants.dart';
import 'package:paynon/utils/constant/text_constants.dart';
import 'package:paynon/widgets/payment_history_widget.dart';
import 'package:paynon/widgets/user_list_widget.dart';
import 'package:paynon/widgets/user_widget.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginController = ref.watch(userControllerProvider);
    var balance = loginController.value!.balance;
    var goal = 10000;

    final formatter = NumberFormat('#,##,000');

    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage: MemoryImage(const Base64Decoder().convert(loginController.value!.picture!)),
                      ),
                      const Text(
                        TextConstants.HOME_TEXT,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Raleway",
                          fontSize: 25,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            ref.read(userControllerProvider.notifier).logOut();
                          },
                          icon: const Icon(Icons.logout)
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                          text: TextConstants.YOUR,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontSize: 25,
                          ),
                        ),
                        TextSpan(
                          text: " " + TextConstants.BALANCE,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          ),
                        ),
                      ])),
                      Text(
                        "\$" + formatter.format(balance),
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Icon(Icons.payments_outlined,
                      color: ColorConstants.blue, size: 50)
                ],
              ),
              Wrap(
                runSpacing: 10,
                children: [
                  const Text(
                    TextConstants.NEXT_GOAL,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      fontSize: 22,
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 120,
                          width: 120,
                          child: CircularProgressIndicator(
                            value: balance / (goal),
                            strokeWidth: 20,
                            color: const Color(0xFFECE9FF),
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "\$10.000",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppings"),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Wrap(
                runSpacing: 30,
                children: [
                  const PaymentHistory(),
                  UserListWidget(loginController.value!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


