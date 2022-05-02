
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paynon/models/user/user_model.dart';
import 'package:paynon/repository/userlist/user_list_repository.dart';

import '../models/failure.dart';

final userListControllerProvider = StateNotifierProvider<UserListController, AsyncValue<List<User>>>(
        (ref) => UserListController(ref.read)..getUsers());

class UserListController extends StateNotifier<AsyncValue<List<User>>> {
  final Reader _read;

  UserListController(this._read) : super(const AsyncValue.loading());

  Future<void> getUsers() async {
    try{
      final users = await _read(userListRepositoryProvider).getUsers();


      state = AsyncValue.data(users);
      print(users);

    }on Failure catch(e, st) {
      state = AsyncValue.error(e, stackTrace: st);
    }
  }
}
