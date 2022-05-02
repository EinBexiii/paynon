
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:paynon/models/user/user_model.dart';

part 'payment_model.freezed.dart';
part 'payment_model.g.dart';

@freezed
abstract class Payment with _$Payment {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory Payment({
    required int id,
    required int date,
    required int amount,
    required bool received,
    required User user,
  }) = _Payment;



  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}
