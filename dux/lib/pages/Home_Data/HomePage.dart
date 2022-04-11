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
    return ListView(
      // shrinkWrap: true,
      children: [
        Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.topLeft,
              colors: [
                Colors.blue,
                Colors.white,
              ],
            )),
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Hi ",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                username,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.0),
                              ),
                              Text(" !",
                                  style: Theme.of(context).textTheme.bodyText1),
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: const [
                              Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Text("20 ºC")),
                              Icon(Icons.wb_sunny_outlined,
                                  color: Colors.yellow)
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(Icons.location_on_outlined),
                              Text("Local"),
                            ],
                          )
                        ],
                      )
                    ],
                  )),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(children: [
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Text(
                              "Today",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Your Schedule",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ],
                            ),
                            Row(
                                // children: [Class(className: "Biology")],
                                ),
                            Row(
                              children: [
                                Text(
                                  "Your Events",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ],
                            ),
                            Row()
                          ],
                        ))
                  ]))
            ])),
      ],
    );
  }
}

class Class extends StatefulWidget {
  const Class({Key? key, required String className}) : super(key: key);

  @override
  State<Class> createState() => _ClassState();
}

class _ClassState extends State<Class> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      height: 200,
      // width: 350,
      child: ListView.builder(
        // itemCount: cards.lenght,
        itemBuilder: (context, index) {
          return Container();
        },
      ),
    );
  }
}
