import 'package:flutter/material.dart';

import 'components/body.dart';

class UserProfileEditScreen extends StatelessWidget {
  const UserProfileEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sua thong tin ca nhan"),
      ),
      body: const Body(),
    );
  }
}
