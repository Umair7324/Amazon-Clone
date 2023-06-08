// ignore_for_file: file_names

import 'package:amazon_clone/services/auth_services.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/text_field.dart';

import '../constants/global_variables.dart';
import 'package:flutter/material.dart';

enum Auth {
  signIn,
  signUp,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const routeName = '/auth-screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final signUpformKEy = GlobalKey<FormState>();
  final signInFormKey = GlobalKey<FormState>();
  Auth auth = Auth.signUp;

  final AuthServices authServices = AuthServices();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  void signUp() {
    authServices.userSignUP(context, emailController.text, passController.text,
        nameController.text);
  }

  void signIn() {
    authServices.userSignIn(context, emailController.text, passController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalVariables.greyBackgroundCOlor,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            ListTile(
              tileColor: auth == Auth.signUp
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                'Create a account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signUp,
                  groupValue: auth,
                  onChanged: (Auth? value) {
                    setState(() {
                      auth = value!;
                    });
                  }),
            ),
            if (auth == Auth.signUp)
              Form(
                  key: signUpformKEy,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Column(
                      children: [
                        CustomTextField(
                            controller: nameController, text: 'Username'),
                        CustomTextField(
                            controller: emailController, text: 'Email'),
                        CustomTextField(
                            controller: passController, text: 'Password'),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                            ontap: () {
                              if (signUpformKEy.currentState!.validate()) {
                                signUp();
                              }
                            },
                            text: 'Sign Up')
                      ],
                    ),
                  )),
            ListTile(
              tileColor: auth == Auth.signIn
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                'Sign-In.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signIn,
                  groupValue: auth,
                  onChanged: (Auth? value) {
                    setState(() {
                      auth = value!;
                    });
                  }),
            ),
            if (auth == Auth.signIn)
              Form(
                key: signInFormKey,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Column(
                    children: [
                      CustomTextField(
                          controller: emailController, text: 'Email'),
                      CustomTextField(
                          controller: passController, text: 'Password'),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          ontap: (() {
                            if (signInFormKey.currentState!.validate()) {
                              signIn();
                            }
                          }),
                          text: 'Sign In'),
                    ],
                  ),
                ),
              ),
          ],
        )));
  }
}
