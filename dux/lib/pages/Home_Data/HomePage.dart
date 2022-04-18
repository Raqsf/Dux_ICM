import 'package:dux/models/weather_models.dart';
import 'package:dux/controllers/weather_controller.dart';
import 'package:flutter/material.dart';
import '../../models/card_model.dart';

import 'package:provider/provider.dart';

import '../../viewModels/forecast_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = "Flávio";
  final _weatherService = WeatherController();

  WeatherResponse? _response;

  void _search() async {
    final response = await _weatherService.getWeather();

    setState(() => _response = response);
  }

  @override
  void initState() {
    _search();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForecastViewModel>(
        builder: (context, model, child) => Scaffold(
                body: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                // HEADER
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      Text(
                                        username,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20.0),
                                      ),
                                      Text(" !",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                    ],
                                  )
                                ],
                              ),

                              // WEATHER
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  _response != null
                                      ? Row(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Text(
                                                    '${_response?.tempInfo.temperature} º')),
                                            Image.network(
                                                _response?.iconUrl ??
                                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/Error.svg/1200px-Error.svg.png",
                                                width: 20),
                                          ],
                                        )
                                      : Row(),
                                  _response != null
                                      ? Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,
                                              size: 15,
                                            ),
                                            Text('${_response?.cityName}'),
                                          ],
                                        )
                                      : Row()
                                ],
                              )
                            ],
                          )),

                      // TODAY'S INFO
                      Container(
                        decoration: const BoxDecoration(
                            color: Color(0xFFFAFAFA), // same as Colors.grey[50]
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Text(
                                  "Today",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ],
                            )),
                      )
                    ])),
                Container(
                  color: Colors.grey[50],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          "Your Schedule",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      const Class(),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          "Your Events",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      )
                    ],
                  ),
                ),
                /* TextButton(
                    onPressed: () => _search(), child: const Text("Press me")),
                if (_response != null)
                  Column(
                    children: [
                      Image.network(_response!.iconUrl),
                      Text('${_response?.tempInfo.temperature}º',
                          style: TextStyle(fontSize: 40)),
                      Text('${_response?.weatherInfo.description}')
                    ],
                  ), */
              ],
            )));
  }
}

class Class extends StatelessWidget {
  const Class({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.only(right: 10),
              height: 170,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Color(cards[index].cardBackground)),
              child: Stack(
                children: [
                  Positioned(
                      top: 13,
                      left: 13,
                      child: Icon(
                        Icons.circle,
                        color: Color(cards[index].secondColor),
                        size: 5,
                      )),
                  Positioned(
                      top: 5,
                      left: 20,
                      child: Icon(
                        Icons.circle,
                        color: Color(cards[index].secondColor),
                        size: 10,
                      )),
                  Positioned(
                      bottom: 90,
                      right: 10,
                      child: Icon(
                        Icons.circle,
                        color: Color(cards[index].secondColor),
                        size: 10,
                      )),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Icon(
                        Icons.circle,
                        color: Color(cards[index].secondColor),
                        size: 100,
                      )),
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cards[index].className,
                            style: const TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.watch_later_outlined,
                                        color: Colors.white, size: 15),
                                    const Padding(
                                        padding: EdgeInsets.only(right: 5)),
                                    Text(
                                        '${cards[index].startTime} - ${cards[index].endTime}',
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.place_outlined,
                                        color: Colors.white, size: 15),
                                    const Padding(
                                        padding: EdgeInsets.only(right: 5)),
                                    Text('Room ${cards[index].room}',
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                ],
              ));
        },
      ),
    );
  }
}
