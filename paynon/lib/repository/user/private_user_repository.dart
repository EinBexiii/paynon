import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paynon/models/user/user_model.dart';
import 'package:paynon/network/network.dart';
import 'package:paynon/utils/google/google_constant.dart';

import 'base_private_user_repository.dart';

final userRepositoryProvider =
    Provider<PrivateUserRepository>((ref) => PrivateUserRepository(ref.read));

class PrivateUserRepository extends BasePrivateUserRepository {

  final Reader _read;

  PrivateUserRepository(this._read);

  @override
  Future<User> login(String? token) async {
    try {
      if (token == null) {
        final g = await GoogleConstant.googleSignIn.signIn();

        if (g != null) {
          final auth = await g.authentication;
          final idToken = auth.idToken;

          token = idToken;
        }
      }

      final response = await _read(NetworkProvider.dioProvider)
          .post(NetworkProvider.API_URL + "/authentication", queryParameters: {"token": token});

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);

        if (data.isNotEmpty) {
          return User.fromJson(data);
        }
      }

      return User.fromJson(const <String, dynamic>{});
    } on DioError catch (err) {
      print(err);
      throw Exception(err.response?.statusMessage);
    } on SocketException catch (err) {
      throw Exception("Connection");
    } on Exception catch (err) {
      throw Exception(err);
    }
  }

  @override
  Future<User?> addNewPayment(int targetUserId, int amount) async{
    try {

      final response = await _read(NetworkProvider.dioProvider).post(
          NetworkProvider.API_URL + "/user/payment",
          queryParameters: {"amount": amount, "targetUserId": targetUserId});

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);

        if (data.isNotEmpty) {
          return User.fromJson(data);
        }
      }

      return User.fromJson(const <String, dynamic>{});
    } on DioError catch (err) {
      print(err);
      throw Exception(err.response?.statusMessage);
    } on SocketException catch (err) {
      throw Exception("Connection");
    } on Exception catch (err) {
      throw Exception(err);
    }
  }

  @override
  Future<User?> loginDirectly() async {
    final g = await GoogleConstant.googleSignIn.signInSilently();

    if (g == null) {
      return null;
    }

    final auth = await g.authentication;
    final idToken = auth.idToken;

    if (idToken == null) {
      return null;
    }

    return await login(idToken);
  }

  @override
  Future<void> logout() async {
    await GoogleConstant.googleSignIn.signOut();
  }
}
