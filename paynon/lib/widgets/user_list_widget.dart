import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paynon/controller/user_list_controller.dart';
import 'package:paynon/models/user/user_model.dart';
import 'package:paynon/utils/constant/color_constats.dart';
import 'package:paynon/utils/constant/text_constants.dart';
import 'package:paynon/widgets/user_widget.dart';

class UserListWidget extends HookConsumerWidget {

  final User currentUser;

  const UserListWidget(this.currentUser, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userListController = ref.watch(userListControllerProvider);

    return Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            TextConstants.SEND_MONEY,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
              fontSize: 22,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 100,
          child: userListController.when(
            data: (users) {
              return AnimationLimiter(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: userListController.value!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(seconds: 1),
                      child: FadeInAnimation(
                        child: UserWidget(
                            user: userListController.value![index], currentAmount: currentUser.balance),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 15);
                  },
                ),
              );
            },
            error: (error, _) {
              return const Text("Erkam ist schwul");
            },
            loading: () {
              return const Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(child: CircularProgressIndicator(strokeWidth: 3, color: ColorConstants.blue))
              );
            },
          ),
        )
      ],
    );
  }


}
