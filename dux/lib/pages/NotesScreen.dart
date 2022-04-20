import 'package:flutter/material.dart';

class Notes extends StatelessWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dux'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(child: Text('NOTES')),
    );
  }
}
