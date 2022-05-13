import 'package:dux/pages/Annotations_Data/AllAnnotationsScreen.dart';
import 'package:dux/pages/Notes_Data/AllNotesScreen.dart';
import 'package:flutter/material.dart';

class NoteType extends StatelessWidget {
  const NoteType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const AllNotesScreen()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: Colors.teal[100]),
                    child: Center(
                        child: Text(
                      "Quick Notes",
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
                  ))),
          Expanded(
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllAnnotationsScreen()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: Colors.teal[200]),
                    child: Center(
                        child: Text(
                      'Notes',
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
                  ))),
        ],
      ),
    );
  }
}
