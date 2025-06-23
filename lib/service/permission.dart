import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestLocationPermission(BuildContext context) async {
  final status = await Permission.location.request();

  if (status.isGranted) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Konum izni verildi!')));
  } else if (status.isDenied) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Konum izni reddedildi!')));
  } else if (status.isPermanentlyDenied) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('İzin ayarlardan verilmelidir.')));
    openAppSettings();
  }
}
