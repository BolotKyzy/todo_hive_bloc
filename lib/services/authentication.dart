import 'package:hive_flutter/adapters.dart';
import 'package:todo_hive_bloc/models/user.dart';

class AuthenticationService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('userBox');

    _users.add(User('testUser', '123'));
    _users.add(User('bak', '124'));
  }

  Future<String?> authenticationUser(
      final String username, final String password) async {
    final success = await _users.values.any((element) =>
        element.username == username && element.password == password);

    if (success) {
      return username;
    } else {
      return null;
    }
  }
}
