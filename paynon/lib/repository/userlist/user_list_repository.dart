import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paynon/models/user/user_model.dart';
import 'package:paynon/network/network.dart';
import 'package:paynon/repository/userlist/base_user_list_repository.dart';

final userListRepositoryProvider =
    Provider<UserListRepository>((ref) => UserListRepository(ref.read));

class UserListRepository extends BaseUserListRepository {
  final Reader _read;

  final String endpoint = NetworkProvider.API_URL + "/user/all";

  UserListRepository(this._read);

  @override
  Future<List<User>> getUsers() async {
    try {
      final response = await _read(NetworkProvider.dioProvider).get(endpoint);

      if (response.statusCode == 200) {
        return (response.data as List).map((e) {
          User user = User.fromJson(e);

          if (user.picture == null) {
            user = user.copyWith(
                picture:
                    "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");
          }
          return user;
        }).toList();
      }
      return List.empty();
    } on DioError catch (err) {
      print(err);
      throw Exception(err.response?.statusMessage);
    } on SocketException catch (err) {
      print(err);
      throw Exception("Connection");
    } on Exception catch (err) {
      throw Exception(err);
    }
  }
}
