
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paynon/models/failure.dart';
import 'package:paynon/models/user/user_model.dart';
import 'package:paynon/repository/user/private_user_repository.dart';

final userControllerProvider = StateNotifierProvider<UserController, AsyncValue<User?>>(
    (ref) => UserController(ref.read)..loginDirectly());

class UserController extends StateNotifier<AsyncValue<User?>> {

  final Reader _read;

  UserController(this._read) : super(const AsyncValue.loading());

  Future<void> login() async {
    try{
      final user = await _read(userRepositoryProvider).login(null);


      state = AsyncValue.data(user);

    }on Failure catch(e, st) {
      state = AsyncValue.error(e, stackTrace: st);
    }
  }

  Future<void> loginDirectly() async {
    try{
      final user = await _read(userRepositoryProvider).loginDirectly();

      state = AsyncValue.data(user);

      print(state.value);
    }on Failure catch(e, st) {
      state = AsyncValue.error(e, stackTrace: st);
    }
  }

  Future<void> yes() async {
    if(state.value != null) {
      state = AsyncValue.data(state.value!.copyWith(balance: state.value!.balance + 1));
    }

  }

  Future<void> logOut() async {
    await _read(userRepositoryProvider).logout();

    state = const AsyncValue.data(null);
  }

  Future<void> addPayment(int targetUserId, int amount) async {
    try{
      final user = await _read(userRepositoryProvider).addNewPayment(targetUserId, amount);

      state = AsyncValue.data(user);
    }on Failure catch(e, st) {
      state = AsyncValue.error(e, stackTrace: st);
      throw Exception(e);
    }
  }
}
