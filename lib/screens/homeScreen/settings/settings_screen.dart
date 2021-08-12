import 'package:flutter/material.dart';
import 'package:shop_app/shared/constants.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text('SettingsScreen'),
            TextButton(
              child: Text('Sign Out'),
              onPressed: () {
                signOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
