import 'dart:developer';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_habitlink/Login/View/login_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Theme'),
            onTap: () {
              // Navigate to theme selection
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            onTap: () {
              // Navigate to language settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              // Navigate to notification settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              try {
                if (!context.mounted) return;
                FirebaseAuth.instance.signOut().then((value) async {
                  logout(context);
                });
              } catch (e) {
                log("Sign-In failed: $e");
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text('Sign-In failed: $e')),
                // );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    final navigator = Navigator.of(context);

    OkCancelResult result = await showOkCancelAlertDialog(
      context: context,
      title: 'Logout',
      message: 'Are you sure you want to log out?',
      defaultType: OkCancelAlertDefaultType.cancel,
      okLabel: '確定',
      cancelLabel: "取消",
    );
    if (result == OkCancelResult.cancel) return;
    navigator.pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
