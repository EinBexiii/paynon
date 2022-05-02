//import 'package:equatable/equatable.dart';
//import 'package:paynon/models/payment_model.dart';
//
//class PrivateUser extends Equatable {
//  final int id;
//  final String email;
//  final String firstName;
//  final String lastName;
//  final List<int> picture;
//  final String googleId;
//  final int balance;
//  final List<Payment> payments;
//
//  const PrivateUser(this.id, this.email, this.firstName, this.lastName,
//      this.picture, this.googleId, this.balance, this.payments);
//
//  @override
//  List<Object?> get props =>
//      [id, email, firstName, lastName, picture, googleId, balance, payments];
//
//  factory PrivateUser.fromMap(Map<String, dynamic> map) {
//    return PrivateUser(
//        map['id'] ?? 0,
//        map["email"] ?? "",
//        map["firstName"] ?? "",
//        map["lastName"] ?? "",
//        map["picture"] ?? List.empty(),
//        map["googleId"] ?? "",
//        map["balance"] ?? 0,
//        map["payments"] ?? List.empty()
//    );
//  }
//}

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:paynon/models/payment/payment_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class User with _$User {

  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory User({
    required int id,
    required String email,
    required String firstName,
    @Default("") String lastName,
    String? picture,
    String? googleId,
    @Default(0) int balance,
    List<Payment>? payments,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
}
