import 'dart:async';
import 'dart:math';

import 'package:dux/models/weather_models.dart';
import 'package:dux/providers/schedule_provider.dart';
import 'package:dux/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_constants.dart';
import '../../functions/future_functions.dart';
import '../../models/card_model.dart';
import 'package:intl/intl.dart';

// import 'package:pedometer/pedometer.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../models/schedule_model.dart';
import '../../providers/steps_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  String username = "Flávio";
  final _weatherService = WeatherService();

  WeatherResponse? _response;

  double x = 0.0;
  double y = 0.0;
  double z = 0.0;
  int steps = 0;
  double distance = 0.0;
  double previousDistance = 0.0;

  void _search() async {
    final response = await _weatherService.getWeather();

    if (mounted) {
      setState(() => _response = response);
    }
  }

  @override
  void initState() {
    _search();
    super.initState();
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    refreshOrGetHomeData(context);

    if (_isLoading == true) {
      Future.wait([refreshOrGetHomeData(context)]).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  double getValue(double x, double y, double z) {
    double magnitude = sqrt(x * x + y * y + z * z);
    getPreviousValue();
    double modDistance = magnitude - previousDistance;
    setPreviousValue(magnitude);
    return modDistance;
  }

  void setPreviousValue(double distance) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setDouble("preValue", distance);
  }

  void getPreviousValue() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      previousDistance = _pref.getDouble("preValue") ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<AccelerometerEvent>(
            stream: SensorsPlatform.instance.accelerometerEvents,
            builder: (context, snapShort) {
              if (snapShort.hasData) {
                x = snapShort.data!.x;
                y = snapShort.data!.y;
                z = snapShort.data!.z;
                distance = getValue(x, y, z);
                if (distance > 6) {
                  steps++;
                  Provider.of<StepsProvider>(context, listen: false)
                      .updateSteps();
                  refreshOrGetHomeData(context);
                }
              }
              return ListView(
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
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                                  padding:
                                                      const EdgeInsets.only(
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
                                        : Row(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Consumer<StepsProvider>(
                                            builder: (context, stepsProvider,
                                                    child) =>
                                                stepsProvider.today != null
                                                    ? Row(children: [
                                                        const Icon(Icons
                                                            .directions_walk),
                                                        Text(
                                                            '${context.watch<StepsProvider>().today?.steps}')
                                                      ]) /* Text(
                                                            'DB ${stepsProvider.today?.steps}') */
                                                    : child!,
                                            child: const Text(""))
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )),

                        // TODAY'S INFO
                        Container(
                          decoration: const BoxDecoration(
                              color:
                                  Color(0xFFFAFAFA), // same as Colors.grey[50]
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Text(
                                    "Today",
                                    style:
                                        Theme.of(context).textTheme.headline2,
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
                        const Today(isClass: true),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            "Your Events",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                        const Today(isClass: false),
                      ],
                    ),
                  ),
                ],
              );
            }));
  }
}

// Class/Event
class Today extends StatefulWidget {
  const Today({Key? key, required this.isClass}) : super(key: key);

  final bool isClass;

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
  var rng = Random().nextInt(100);
  List<ScheduleM> allClasses = [];
  List<ScheduleM> todayClasses = [];

  @override
  Widget build(BuildContext context) {
    void getClasses() {
      int day = getDay();
      todayClasses = [];
      switch (day) {
        case 0:
          for (int i = 0; i < allClasses.length; i++) {
            if (allClasses[i].day.toLowerCase() == "monday" &&
                allClasses[i].subject != "") {
              todayClasses.add(allClasses[i]);
            }
          }
          break;
        case 1:
          for (int i = 0; i < allClasses.length; i++) {
            if (allClasses[i].day.toLowerCase() == "tuesday" &&
                allClasses[i].subject != "") {
              todayClasses.add(allClasses[i]);
            }
          }
          break;
        case 2:
          for (int i = 0; i < allClasses.length; i++) {
            if (allClasses[i].day.toLowerCase() == "wednesday" &&
                allClasses[i].subject != "") {
              todayClasses.add(allClasses[i]);
            }
          }
          break;
        case 3:
          for (int i = 0; i < allClasses.length; i++) {
            if (allClasses[i].day.toLowerCase() == "thursday" &&
                allClasses[i].subject != "") {
              todayClasses.add(allClasses[i]);
            }
          }
          break;
        case 4:
          for (int i = 0; i < allClasses.length; i++) {
            if (allClasses[i].day.toLowerCase() == "friday" &&
                allClasses[i].subject != "") {
              todayClasses.add(allClasses[i]);
            }
          }
          break;
        default:
      }
    }

    return SizedBox(
        height: 170,
        child: Consumer<SchedulelProvider>(
            builder: (context, scheduleProvider, child) {
          allClasses = scheduleProvider.items;
          getClasses();
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: widget.isClass ? todayClasses.length : cardsEvent.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 170,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: ColorsConstant.homeColors[
                          (index + rng) % ColorsConstant.homeColors.length][0]),
                  child: Stack(
                    children: [
                      // DECORATION
                      Positioned(
                          top: 13,
                          left: 13,
                          child: Icon(
                            Icons.circle,
                            color: ColorsConstant.homeColors[(index + rng) %
                                ColorsConstant.homeColors.length][1],
                            size: 5,
                          )),
                      Positioned(
                          top: 5,
                          left: 20,
                          child: Icon(
                            Icons.circle,
                            color: ColorsConstant.homeColors[(index + rng) %
                                ColorsConstant.homeColors.length][1],
                            size: 10,
                          )),
                      Positioned(
                          bottom: 90,
                          right: 10,
                          child: Icon(
                            Icons.circle,
                            color: ColorsConstant.homeColors[(index + rng) %
                                ColorsConstant.homeColors.length][1],
                            size: 10,
                          )),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Icon(
                            Icons.circle,
                            color: ColorsConstant.homeColors[(index + rng) %
                                ColorsConstant.homeColors.length][1],
                            size: 100,
                          )),
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Class Name
                              Text(
                                widget.isClass
                                    ? todayClasses[index].subject
                                    : cardsEvent[index].title,
                                style: const TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Column(
                                  children: [
                                    // Time
                                    Row(
                                      children: [
                                        const Icon(Icons.watch_later_outlined,
                                            color: Colors.white, size: 15),
                                        const Padding(
                                            padding: EdgeInsets.only(right: 5)),
                                        Text(
                                            '${widget.isClass ? todayClasses[index].hours : cardsEvent[index].startTime}',
                                            style: const TextStyle(
                                                color: Colors.white)),
                                      ],
                                    ),
                                    // Place
                                    if (!widget.isClass)
                                      Row(
                                        children: [
                                          const Icon(Icons.place_outlined,
                                              color: Colors.white, size: 15),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5)),
                                          Text(cardsEvent[index].place,
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
          );
        }));
  }
}

int getDay() {
  DateTime date = DateTime.now();
  String dateFormat = DateFormat('EEEE').format(date);
  int d = 0;
  switch (dateFormat) {
    case ("Monday"):
      break;
    case ("Tuesday"):
      d = 1;
      break;
    case ("Wednesday"):
      d = 2;
      break;
    case ("Thursday"):
      d = 3;
      break;
    case ("Friday"):
      d = 4;
      break;
    case ("Saturday"):
      d = 5;
      break;
    case ("Sunday"):
      d = 6;
      break;
  }
  return d;
}
