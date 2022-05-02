import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paynon/models/user/user_model.dart';
import 'package:paynon/widgets/send_money_widget.dart';

class UserWidget extends StatefulWidget {

  final User user;
  final int currentAmount;

  const UserWidget({Key? key, required this.user, required this.currentAmount}) : super(key: key);

  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {

  int amount = 10;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 100,
          width: 90,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.memory(
                const Base64Decoder().convert(widget.user.picture!),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 4,
          child: Text(
            widget.user.firstName,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontSize: 20,
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SendMoneyWidget(user: widget.user, currentMoney: widget.currentAmount);
                    });
              },
            ),
          ),
        ),
      ],
    );
  }
}
