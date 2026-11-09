import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const GhSpeedAlert());
}

class GhSpeedAlert extends StatelessWidget {
  const GhSpeedAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double speed = 0;
  int? speedLimit;
  bool monitoring = false;
  String gpsStatus = 'GPS NOT CONNECTED';

  StreamSubscription<Position>? subscription;
  final FlutterTts tts = FlutterTts();
  DateTime lastWarning = DateTime(2000);

  Future<void> startMonitoring() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();

    if (!enabled) {
      setState(() => gpsStatus = 'PLEASE ENABLE GPS');
      return;
    }

    LocationPermission permission =
        await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() => gpsStatus = 'LOCATION PERMISSION DENIED');
      return;
    }

    const settings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 2,
    );

    await subscription?.cancel();

    subscription = Geolocator.getPositionStream(
      locationSettings: settings,
    ).listen((Position position) {
      final double currentSpeed =
          (position.speed * 3.6).clamp(0.0, 300.0).toDouble();
  

      setState(() {
        speed = currentSpeed;
        gpsStatus = 'GPS CONNECTED';
      });

      checkSpeed();
    });

    setState(() {
      monitoring = true;
      gpsStatus = 'WAITING FOR GPS SIGNAL';
    });
  }

  Future<void> checkSpeed() async {
    if (speedLimit == null || speed <= speedLimit! + 3) {
      return;
    }

    if (DateTime.now().difference(lastWarning).inSeconds < 15) {
      return;
    }

    lastWarning = DateTime.now();

    await tts.speak(
      'Warning. You are above the selected speed limit.',
    );
  }

  Future<void> stopMonitoring() async {
    await subscription?.cancel();

    setState(() {
      monitoring = false;
      gpsStatus = 'GPS MONITORING STOPPED';
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080A0F),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'GH SPEED ALERT',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color(0xFF171D29),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.red, width: 2),
              ),
              child: Column(
                children: [
                  const Text('CURRENT VEHICLE SPEED'),
                  const SizedBox(height: 10),
                  Text(
                    speed.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 85,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'KM/H',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    speedLimit == null
                        ? 'ROAD LIMIT: NOT VERIFIED'
                        : 'SELECTED LIMIT: $speedLimit KM/H',
                    style: const TextStyle(
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Icon(
              Icons.directions_car,
              size: 75,
              color: Colors.white,
            ),

            const Center(
              child: Text(
                'Gs. 6075-26',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              gpsStatus,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<int>(
              value: speedLimit,
              decoration: const InputDecoration(
                labelText: 'Select a test speed threshold',
                border: OutlineInputBorder(),
              ),
              items: [30, 50, 80, 100, 120].map((limit) {
                return DropdownMenuItem(
                  value: limit,
                  child: Text('$limit km/h'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => speedLimit = value);
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed:
                  monitoring ? stopMonitoring : startMonitoring,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.all(17),
              ),
              child: Text(
                monitoring
                    ? 'STOP GPS MONITORING'
                    : 'START GPS MONITORING',
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'GH SPEED ALERT 2.0',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54),
            ),

            const Text(
              'Developed by Jacob Femeyibor',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
