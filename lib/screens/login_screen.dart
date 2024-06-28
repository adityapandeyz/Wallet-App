import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persist_wallet_app/services/login_services.dart';
import 'package:persist_wallet_app/widgets/custom_button.dart';
import 'package:persist_wallet_app/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../provider/google_signin_provider.dart';

/// The screen for the login functionality.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameOrEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameOrEmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Form(
                key: _loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      child: FaIcon(
                        FontAwesomeIcons.bitcoin,
                        size: 80,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      controller: usernameOrEmailController,
                      hintText: 'Username or email',
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                      ontap: () async {
                        HapticFeedback.vibrate();

                        if (_loginFormKey.currentState!.validate()) {
                          await LoginServices.loginUser(
                            context,
                            username: usernameOrEmailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                        }
                      },
                      hintText: 'Login',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            height: 10,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'OR',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            height: 10,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        ontap: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);

                          provider.signInWithGoogle();
                        },
                        hintText: 'Sign in with Google'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'By signing in, you agree to our Privacy Policy and Terms of Service.',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
