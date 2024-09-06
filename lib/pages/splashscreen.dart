// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    bool permissionsGranted = await _requestPermissions();

    while (!permissionsGranted) {
      // Show a dialog to force the user to grant permission
      permissionsGranted = await _showPermissionRequestDialog();
    }

    // Navigate to the main app after permissions are handled
    if (mounted && permissionsGranted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  Future<bool> _requestPermissions() async {
    // Request storage and manage external storage permissions simultaneously
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    // Check if any of the permissions are denied or permanently denied
    if (statuses[Permission.storage]?.isDenied == true ||
        statuses[Permission.manageExternalStorage]?.isDenied == true) {
      return false;
    }

    if (statuses[Permission.storage]?.isPermanentlyDenied == true ||
        statuses[Permission.manageExternalStorage]?.isPermanentlyDenied ==
            true) {
      return false;
    }

    // If all permissions are granted
    return statuses[Permission.storage]?.isGranted == true &&
        statuses[Permission.manageExternalStorage]?.isGranted == true;
  }

  Future<bool> _showPermissionRequestDialog() async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible:
              false, // Prevent dismissing the dialog by tapping outside
          builder: (context) => AlertDialog(
            title: const Text('Permissions Required'),
            content: const Text(
                'This app requires storage access to function properly. Please grant the required permissions.'),
            actions: [
              TextButton(
                onPressed: () async {
                  // Open app settings if permission is permanently denied
                  if (await Permission.storage.isPermanentlyDenied ||
                      await Permission
                          .manageExternalStorage.isPermanentlyDenied) {
                    await openAppSettings();
                  } else {
                    // Retry requesting permissions
                    Navigator.of(context).pop(await _requestPermissions());
                  }
                },
                child: const Text('Grant Permissions'),
              ),
            ],
          ),
        ) ??
        false; // Return false if the dialog is dismissed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "assets/images/otunba_JSY.jpeg",
                // height: 150,
              )),
        ),
      ),
    );
  }
}
