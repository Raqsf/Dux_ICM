import 'dart:html';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = "Flávio";

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Row(
              children: [
                const Text(
                  "Hi ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  username,
                  style: TextStyle(
                      color: Color.fromARGB(250, 5, 156, 156),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const Text(" !",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            )
          ],
        ));
  }
}
