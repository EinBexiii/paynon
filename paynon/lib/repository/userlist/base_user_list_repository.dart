
import 'package:paynon/models/user/user_model.dart';

abstract class BaseUserListRepository {
  Future<List<User>> getUsers();
}
