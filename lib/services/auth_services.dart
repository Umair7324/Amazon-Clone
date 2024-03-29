// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/model/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/screens/auth_Screen.dart';
import 'package:amazon_clone/services/error_handling.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/bottom_navigation.dart';

class AuthServices {
  void userSignUP(
      BuildContext context, String email, String password, String name) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '',
          cart: []);
      http.Response res = await http.post(
          Uri.parse(
            '$uri/api/signup',
          ),
          body: user.toJson(),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8'
          });

      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, 'Account created! login with same credentials');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void userSignIn(BuildContext context, String email, String password) async {
    try {
      http.Response res = await http.post(
          Uri.parse(
            '$uri/api/signin',
          ),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8'
          });

      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUSer(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.of(context).pushNamedAndRemoveUntil(
                BottomNavigation.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUSerData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      http.Response tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userResponse = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUSer(userResponse.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void userLogOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('x-auth-token', '');
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AuthScreen.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
