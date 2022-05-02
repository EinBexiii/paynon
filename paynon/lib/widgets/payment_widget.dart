import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paynon/models/payment/payment_model.dart';

class PaymentWidget extends StatefulWidget {

  final Payment payment;

  const PaymentWidget({Key? key, required this.payment}) : super(key: key);

  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(widget.payment.received ? Icons.payments_outlined: Icons.apartment_outlined),
            const SizedBox(
              width: 10,
            ),
            Text(
                widget.payment.user.firstName + " " + widget.payment.user.lastName,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontSize: 16,
                )
            ),
          ],
        ),
         Text(
          widget.payment.received ? "+\$" + widget.payment.amount.toString() : "-\$" + widget.payment.amount.toString().replaceAll("-", ""),
          style: TextStyle(
            color: widget.payment.received ? const Color(0xff90E3B0) : const Color(0xffD96B6B),
            fontFamily: "Poppins",
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
