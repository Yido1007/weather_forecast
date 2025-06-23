import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestLocationPermission(BuildContext context) async {
  final status = await Permission.location.request();

  if (status.isGranted) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('permission-granted'.tr())));
  } else if (status.isDenied) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('permission-dennied'.tr())));
  } else if (status.isPermanentlyDenied) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('permission-settings'.tr())));
    openAppSettings();
  }
}
