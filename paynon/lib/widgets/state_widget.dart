import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paynon/controller/user_controller.dart';
import 'package:paynon/screens/login/login_screen.dart';
import 'package:paynon/screens/main/main_screen.dart';
import 'package:paynon/utils/constant/color_constats.dart';

class StateWidget extends HookConsumerWidget {
  const StateWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginController = ref.watch(userControllerProvider);

    return loginController.when(
      data: (user){
        if(user == null) {
          return const LoginScreen();
        }
        return const MainScreen();
      },
      error: (error, _){
        return const Text("ERROR");
      },
      loading: (){
        return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator(strokeWidth: 3, color: ColorConstants.blue))
        );
      },
    );
  }
}
