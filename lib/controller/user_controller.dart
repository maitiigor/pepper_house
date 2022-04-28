import 'package:pepper_house/locator.dart';
import 'package:pepper_house/models/user_model.dart';
import 'package:pepper_house/services/fire_auth.dart';

class UserController {
  late UserModel _currentUser;
  final FireAuth _fireAuth = locator.get<FireAuth>();
  UserController() {
    initUser();
  }
  Future<UserModel> initUser() async {
    _currentUser = await _fireAuth.getUser();
    return _currentUser;
  }

  UserModel get currentUser => _currentUser;
}
