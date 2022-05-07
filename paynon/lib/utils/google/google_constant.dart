import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleConstant {
  static GoogleSignIn googleSignIn = GoogleSignIn(clientId: Platform.isIOS ? "406606233683-aba99r480m677ile4rebo8fn64bfht0h.apps.googleusercontent.com" : "406606233683-tch1q93ogb9f811ncqf4q44ia257jmri.apps.googleusercontent.com");
}
