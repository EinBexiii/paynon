

import 'dart:ffi';

import 'package:paynon/models/payment/payment_model.dart';
import 'package:paynon/models/user/user_model.dart';

abstract class BasePrivateUserRepository {

  Future<User> login(String? token);
  Future<User?> loginDirectly();
  Future<User?> addNewPayment(int targetUserId, int amount);
  Future<void> logout();
}
