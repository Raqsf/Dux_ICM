/* import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import './SelectBondedDevicePage.dart';

// import './helpers/LineChart.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({Key? key}) : super(key: key);

  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<BluetoothScreen> {
  // Initializing the Bluetooth connection state to be unknown
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  // Initializing a global key, as it would help us in showing a SnackBar later
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // Get the instance of the Bluetooth
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  // Track the Bluetooth connection with the remote device
  BluetoothConnection? connection;

  int? _deviceState;

  bool isDisconnecting = false;

  Map<String, Color> colors = {
    'onBorderColor': Colors.green,
    'offBorderColor': Colors.red,
    'neutralBorderColor': Colors.transparent,
    'onTextColor': Colors.green.shade700,
    'offTextColor': Colors.red.shade700,
    'neutralTextColor': Colors.blue,
  };

  // To track whether the device is still connected to Bluetooth
  bool get isConnected => connection != null && connection!.isConnected;

  // Define some variables, which will be required later
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice? _device;
  bool _connected = false;
  bool _isButtonUnavailable = false;

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    _deviceState = 0; // neutral

    // If the bluetooth of the device is not enabled,
    // then request permission to turn on bluetooth
    // as the app starts up
    enableBluetooth();

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        if (_bluetoothState == BluetoothState.STATE_OFF) {
          _isButtonUnavailable = true;
        }
        getPairedDevices();
      });
    });
  }

  @override
  void dispose() {
    // Avoid memory leak and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }

  // Request Bluetooth permission from the user
  Future<bool> enableBluetooth() async {
    // Retrieving the current Bluetooth state
    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    // If the bluetooth is off, then turn it on first
    // and then retrieve the devices that are paired.
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices();
      return true;
    } else {
      await getPairedDevices();
    }
    return false;
  }

  // For retrieving and storing the paired devices
  // in a list.
  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await _bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    // It is an error to call [setState] unless [mounted] is true.
    if (!mounted) {
      return;
    }

    // Store the [devices] list in the [_devicesList] for accessing
    // the list outside this class
    setState(() {
      _devicesList = devices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Bluetooth Serial'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Divider(),
            ListTile(
                title: const Text(
              'General',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            SwitchListTile(
              title: const Text('Enable Bluetooth'),
              value: _bluetoothState.isEnabled,
              onChanged: (bool value) {
                // Do the request and update with the true value then
                future() async {
                  // async lambda seems to not working
                  if (value)
                    await FlutterBluetoothSerial.instance.requestEnable();
                  else
                    await FlutterBluetoothSerial.instance.requestDisable();
                }

                future().then((_) {
                  setState(() {});
                });
              },
            ),
            ListTile(
              title: const Text('Bluetooth status'),
              subtitle: Text(_bluetoothState.toString()),
              trailing: ElevatedButton(
                child: const Text('Settings'),
                onPressed: () {
                  FlutterBluetoothSerial.instance.openSettings();
                },
              ),
            ),
            /* ListTile(
              title: const Text('Local adapter name'),
              subtitle: Text(_name),
              onLongPress: null,
            ),
            ListTile(
              title: _discoverableTimeoutSecondsLeft == 0
                  ? const Text("Discoverable")
                  : Text(
                      "Discoverable for ${_discoverableTimeoutSecondsLeft}s"),
              subtitle: const Text("PsychoX-Luna"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: _discoverableTimeoutSecondsLeft != 0,
                    onChanged: null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () async {
                      print('Discoverable requested');
                      final int timeout = (await FlutterBluetoothSerial.instance
                          .requestDiscoverable(60))!;
                      if (timeout < 0) {
                        print('Discoverable mode denied');
                      } else {
                        print(
                            'Discoverable mode acquired for $timeout seconds');
                      }
                      setState(() {
                        _discoverableTimeoutTimer?.cancel();
                        _discoverableTimeoutSecondsLeft = timeout;
                        _discoverableTimeoutTimer =
                            Timer.periodic(Duration(seconds: 1), (Timer timer) {
                          setState(() {
                            if (_discoverableTimeoutSecondsLeft < 0) {
                              FlutterBluetoothSerial.instance.isDiscoverable
                                  .then((isDiscoverable) {
                                if (isDiscoverable ?? false) {
                                  print(
                                      "Discoverable after timeout... might be infinity timeout :F");
                                  _discoverableTimeoutSecondsLeft += 1;
                                }
                              });
                              timer.cancel();
                              _discoverableTimeoutSecondsLeft = 0;
                            } else {
                              _discoverableTimeoutSecondsLeft -= 1;
                            }
                          });
                        });
                      });
                    },
                  )
                ],
              ),
            ), */
            Divider(),
            ListTile(
                title: const Text(
              'Devices discovery and connection',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            /* SwitchListTile(
              title: const Text('Auto-try specific pin when pairing'),
              subtitle: const Text('Pin 1234'),
              value: _autoAcceptPairingRequests,
              onChanged: (bool value) {
                setState(() {
                  _autoAcceptPairingRequests = value;
                });
                if (value) {
                  FlutterBluetoothSerial.instance.setPairingRequestHandler(
                      (BluetoothPairingRequest request) {
                    print("Trying to auto-pair with Pin 1234");
                    if (request.pairingVariant == PairingVariant.Pin) {
                      return Future.value("1234");
                    }
                    return Future.value(null);
                  });
                } else {
                  FlutterBluetoothSerial.instance
                      .setPairingRequestHandler(null);
                }
              },
            ), */
            ListTile(
              title: Text(
                'Device:',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              subtitle: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "PAIRED DEVICES",
                          style: TextStyle(fontSize: 24, color: Colors.blue),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            DropdownButton(
                              items: _getDeviceItems(),
                              onChanged: (value) => setState(
                                  () => _device = value as BluetoothDevice),
                              value: _devicesList.isNotEmpty ? _device : null,
                            ),
                            ElevatedButton(
                              onPressed: _isButtonUnavailable
                                  ? null
                                  : _connected
                                      ? _disconnect
                                      : _connect,
                              child:
                                  Text(_connected ? 'Disconnect' : 'Connect'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: new BorderSide(
                              /* color: _deviceState == 0
                                  ? colors['neutralBorderColor']
                                  : _deviceState == 1
                                      ? colors['onBorderColor']
                                      : colors['offBorderColor'], */
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          elevation: _deviceState == 0 ? 4 : 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "DEVICE 1",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: _deviceState == 0
                                          ? colors['neutralTextColor']
                                          : _deviceState == 1
                                              ? colors['onTextColor']
                                              : colors['offTextColor'],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: _connected
                                      ? _sendOnMessageToBluetooth
                                      : null,
                                  child: Text("ON"),
                                ),
                                TextButton(
                                  onPressed: _connected
                                      ? _sendOffMessageToBluetooth
                                      : null,
                                  child: Text("OFF"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.blue,
                  ),
                ],
              ),
              /* title: ElevatedButton(
                  child: const Text('Explore discovered devices'),
                  onPressed: () async {
                    final BluetoothDevice? selectedDevice =
                        await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return DiscoveryPage();
                        },
                      ),
                    );

                    if (selectedDevice != null) {
                      print('Discovery -> selected ' + selectedDevice.address);
                    } else {
                      print('Discovery -> no device selected');
                    }
                  }), */
            ),
            ListTile(
              title: ElevatedButton(
                child: const Text('Connect to paired device to chat'),
                onPressed: () async {
                  final BluetoothDevice? selectedDevice =
                      await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SelectBondedDevicePage(checkAvailability: false);
                      },
                    ),
                  );

                  if (selectedDevice != null) {
                    print('Connect -> selected ' + selectedDevice.address);
                    // _startChat(context, selectedDevice);
                  } else {
                    print('Connect -> no device selected');
                  }
                },
              ),
            ),
            Divider(),
            ListTile(title: const Text('Multiple connections example')),
            /* ListTile(
              title: ElevatedButton(
                child: ((_collectingTask?.inProgress ?? false)
                    ? const Text('Disconnect and stop background collecting')
                    : const Text('Connect to start background collecting')),
                onPressed: () async {
                  if (_collectingTask?.inProgress ?? false) {
                    await _collectingTask!.cancel();
                    setState(() {
                      /* Update for `_collectingTask.inProgress` */
                    });
                  } else {
                    final BluetoothDevice? selectedDevice =
                        await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return SelectBondedDevicePage(
                              checkAvailability: false);
                        },
                      ),
                    );

                    if (selectedDevice != null) {
                      await _startBackgroundTask(context, selectedDevice);
                      setState(() {
                        /* Update for `_collectingTask.inProgress` */
                      });
                    }
                  }
                },
              ),
            ),
            ListTile(
              title: ElevatedButton(
                child: const Text('View background collected data'),
                onPressed: (_collectingTask != null)
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ScopedModel<BackgroundCollectingTask>(
                                model: _collectingTask!,
                                child: BackgroundCollectedPage(),
                              );
                            },
                          ),
                        );
                      }
                    : null,
              ),
            ), */
          ],
        ),
      ),
    );
  }

  // Method to connect to bluetooth
  void _connect() async {
    print("CONNECT");
    if (_device == null) {
      show('No device selected');
    } else {
      print(isConnected);
      if (!isConnected) {
        print("HELLO");
        print(_device?.address);
        await BluetoothConnection.toAddress(_device?.address)
            .then((_connection) {
          print('Connected to the device');
          connection = _connection;
          setState(() {
            _connected = true;
          });

          connection?.input?.listen(null).onDone(() {
            if (isDisconnecting) {
              print('Disconnecting locally!');
            } else {
              print('Disconnected remotely!');
            }
            if (this.mounted) {
              setState(() {});
            }
          });
        }).catchError((error) {
          print('Cannot connect, exception occurred');
          print(error);
        });
        show('Device connected');

        /* setState(() => _isButtonUnavailable = false );*/
      }
    }
  }

  // Method to disconnect bluetooth
  void _disconnect() async {
    /* setState(() {
      _isButtonUnavailable = true;
      _deviceState = 0;
    }); */

    await connection?.close();
    show('Device disconnected');
    if (!connection!.isConnected) {
      setState(() {
        _connected = false;
        //_isButtonUnavailable = false;
      });
    }
  }

  // Method to show a Snackbar,
  // taking message as the text
  Future show(
    String message, {
    Duration duration: const Duration(seconds: 3),
  }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    //_scaffoldKey.currentContext
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          message,
        ),
        duration: duration,
      ),
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devicesList.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devicesList.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name ?? ""),
          value: device,
        ));
      });
    }
    return items;
  }

  /* void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ChatPage(server: server);
        },
      ),
    );
  } */

  // Method to send message,
  // for turning the Bluetooth device on
  void _sendOnMessageToBluetooth() async {
    connection?.output.add(ascii.encode("1" "\r\n"));
    await connection?.output.allSent;
    show('Device Turned On');
    setState(() {
      _deviceState = 1; // device on
    });
  }

  // Method to send message,
  // for turning the Bluetooth device off
  void _sendOffMessageToBluetooth() async {
    connection?.output.add(ascii.encode("0" "\r\n"));
    await connection?.output.allSent;
    show('Device Turned Off');
    setState(() {
      _deviceState = -1; // device off
    });
  }

  /* Future<void> _startBackgroundTask(
    BuildContext context,
    BluetoothDevice server,
  ) async {
    try {
      _collectingTask = await BackgroundCollectingTask.connect(server);
      await _collectingTask!.start();
    } catch (ex) {
      _collectingTask?.cancel();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error occured while connecting'),
            content: Text("${ex.toString()}"),
            actions: <Widget>[
              new TextButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  } */
}
 */