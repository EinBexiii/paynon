import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paynon/controller/user_controller.dart';
import 'package:paynon/models/user/user_model.dart';
import 'package:paynon/screens/login/login_screen.dart';
import 'package:paynon/screens/main/main_screen.dart';
import 'package:paynon/screens/welcome/welcome_first.dart';
import 'package:paynon/widgets/state_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  if (Platform.isWindows) {
    WidgetsFlutterBinding.ensureInitialized();

    await WindowManager.instance.ensureInitialized();
    await WindowManager.instance.waitUntilReadyToShow();
    await WindowManager.instance.setAlwaysOnTop(true);
  }

  runApp(const ProviderScope(child: MyApp()));
}

final firstAppStartedStateProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();

  final bool? firstStart = prefs.getBool("APP_STARTED_BEN");

  if(firstStart == null || firstStart == false) {
    await prefs.setBool("APP_STARTED_BEN", true);
    return true;
  }

  return false;
});


class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    AsyncValue<bool> appStarted = ref.watch(firstAppStartedStateProvider);

    return MaterialApp(
      title: 'PayNon',
      debugShowCheckedModeBanner: false,
      home: appStarted.when(
        data: (boolean) {
          if(boolean) {
            return const WelcomeFirst();
          }

          return const StateWidget();
        },
        error: (error, _){
          return const Text("ERROR!");
        },
        loading: () {
          return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator(strokeWidth: 2))
          )
          ;
        }
      )
    );
  }

// This widget is the root of your application.
}
