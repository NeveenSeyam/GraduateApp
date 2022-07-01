import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView.builder(
          itemBuilder: (cox, index) => const Text(""),
        ),
      ),
    );
  }
}
