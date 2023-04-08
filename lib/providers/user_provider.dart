import 'package:amazon_clone/model/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      email: '',
      name: '',
      password: '',
      address: '',
      type: '',
      token: '',
      cart: []);

  User get user => _user;

  void setUSer(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUSerFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
