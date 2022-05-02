import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paynon/controller/user_controller.dart';
import 'package:paynon/models/payment/payment_model.dart';
import 'package:paynon/utils/constant/text_constants.dart';
import 'package:paynon/widgets/payment_widget.dart';

class PaymentHistory extends HookConsumerWidget {
  const PaymentHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userListController = ref.watch(userControllerProvider);

    return Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            TextConstants.RECENT_TRANSACTIONS,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
              fontSize: 22,
            ),
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        SizedBox(
          height: 70,
          child: userListController.when(
            data: (user){

              List<Payment> payments = [...?user!.payments];
              payments.sort((a, b) => b.date.compareTo(a.date));

              return AnimationLimiter(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: payments.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (_, index){
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(seconds: 1),
                      child: FadeInAnimation(
                        child: PaymentWidget(payment: payments[index]),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 15);
                  },
                ),
              );
            },
            error: (err, _){
              return Container();
            },
            loading: (){
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
