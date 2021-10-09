import 'package:FirebaseEcommerce/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class SavedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: "Saved",)
        ],
      ),
    );
  }
}
