import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_habitlink/Login/ViewModel/auth_strategy.dart';
import 'package:flutter_habitlink/Utility/avoid_fast_button_click_mixin.dart';
import 'package:flutter_habitlink/main_navigation_page.dart';

class LoginPage extends StatelessWidget with AvoidFastButtonClickMixin {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to HabitLink',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              _iconButton(
                context,
                GoogleAuthStrategy(),
                icon: const Icon(Icons.account_circle),
                title: 'Sign in with Google',
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Platform.isIOS
                  ? _iconButton(
                      context,
                      AppleAuthStrategy(),
                      icon: const Icon(Icons.apple),
                      title: 'Sign in with Apple',
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton(BuildContext context, AuthStrategy authStrategy, {String? title, Icon? icon, ButtonStyle? style}) {
    return ElevatedButton.icon(
        icon: icon,
        label: Text(title ?? ''),
        style: style,
        onPressed: () {
          if (isRedundantClick(DateTime.now())) return;
          _handleSignIn(authStrategy, context);
        });
  }

  Future<void> _handleSignIn(AuthStrategy strategy, BuildContext context) async {
    final authContext = AuthContext(strategy);
    try {
      await authContext.signIn();
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainNavigation()),
        );
      }
    } catch (e) {
      log("Sign-In failed: $e");
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Sign-In failed: $e')),
      // );
    }
  }
}
