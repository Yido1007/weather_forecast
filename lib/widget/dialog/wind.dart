//wind unit alert dialog
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/provider/units/wind.dart';

void showWindSpeedUnitDialog(BuildContext context) {
  final unitProvider = Provider.of<WindSpeedUnitProvider>(
    context,
    listen: false,
  );
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('select-wind-unit'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<WindSpeedUnit>(
              title: Text('km/hour'.tr()),
              value: WindSpeedUnit.kmh,
              groupValue: unitProvider.windSpeedUnit,
              onChanged: (value) {
                if (value != null) {
                  unitProvider.setWindSpeedUnit(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<WindSpeedUnit>(
              title: Text('m/s'.tr()),
              value: WindSpeedUnit.ms,
              groupValue: unitProvider.windSpeedUnit,
              onChanged: (value) {
                if (value != null) {
                  unitProvider.setWindSpeedUnit(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<WindSpeedUnit>(
              title: Text('m/s'.tr()),
              value: WindSpeedUnit.mph,
              groupValue: unitProvider.windSpeedUnit,
              onChanged: (value) {
                if (value != null) {
                  unitProvider.setWindSpeedUnit(value);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
