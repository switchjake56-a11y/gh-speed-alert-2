import 'package:flutter/material.dart';

void main() {
  runApp(const GhSpeedAlert());
}

class GhSpeedAlert extends StatelessWidget {
  const GhSpeedAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GH SPEED ALERT',
      theme: ThemeData.dark(),
      home: const Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  static const red = Color(0xFFFF2020);
  static const background = Color(0xFF080A0F);
  static const panel = Color(0xFF171D29);

  Widget tile(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.blueGrey),
      ),
      child: Column(
        children: [
          Icon(icon, color: red, size: 32),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.speed, color: red, size: 40),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        'GH SPEED ALERT',
                        style: TextStyle(
                          color: red,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'DRIVE SAFE. LIVE LONG.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF252D3D),
                      Color(0xFF090B12),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: red, width: 2),
                ),
                child: const Column(
                  children: [
                    Text(
                      'CURRENT SPEED',
                      style: TextStyle(
                        color: Colors.white70,
                        letterSpacing: 3,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      '--',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 82,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'km/h',
                      style: TextStyle(
                        color: red,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Divider(color: Colors.white24),
                    Text(
                      'SPEED LIMIT: NOT YET VERIFIED',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: panel,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.directions_car,
                      size: 75,
                      color: Colors.white,
                    ),
                    Text(
                      'GH SPEED ALERT',
                      style: TextStyle(
                        color: red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Gs. 6075-26',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Vehicle identification display',
                      style: TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              const Row(
                children: [
                  Icon(Icons.gps_fixed, color: Colors.green),
                  SizedBox(width: 8),
                  Text('GPS STATUS: NOT CONNECTED'),
                ],
              ),

              const SizedBox(height: 18),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.45,
                children: [
                  tile(Icons.map, 'MAP & ROAD INFO'),
                  tile(Icons.camera_alt, 'SPEED SIGN RECOGNITION'),
                  tile(Icons.notifications_active, 'VOICE ALERTS'),
                  tile(Icons.camera, 'SPEED CAMERA ALERTS'),
                  tile(Icons.history, 'JOURNEY HISTORY'),
                  tile(Icons.shield, 'ROAD SAFETY TIPS'),
                ],
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'YOUR SAFETY, OUR PRIORITY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'GH SPEED ALERT 2.0 | Developed by Jacob Femeyibor',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
