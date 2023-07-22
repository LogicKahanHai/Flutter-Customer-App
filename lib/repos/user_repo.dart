import 'package:pk_customer_app/models/models.dart';

class UserRepo {
  static UserModel? user;

  static set setUser(UserModel user) => UserRepo.user = user;

  static UserModel? get getUser => UserRepo.user;

  static bool get isUser => user != null;

  static void clearUser() => user = null;

  static void updateUser(UserModel user) => UserRepo.user = user;
}
