//temperature unit alert dialog
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/provider/units/temperature.dart';

void showTemperatureUnitDialog(BuildContext context) {
  final unitProvider = Provider.of<TemperatureUnitProvider>(
    context,
    listen: false,
  );
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('select-temp-unit'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<TemperatureUnit>(
              title: Text('celsius'.tr()),
              value: TemperatureUnit.celsius,
              groupValue: unitProvider.unit,
              onChanged: (value) {
                if (value != null) {
                  unitProvider.setUnit(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<TemperatureUnit>(
              title: const Text('Fahrenheit (°F)'),
              value: TemperatureUnit.fahrenheit,
              groupValue: unitProvider.unit,
              onChanged: (value) {
                if (value != null) {
                  unitProvider.setUnit(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<TemperatureUnit>(
              title: const Text('Kelvin (K)'),
              value: TemperatureUnit.kelvin,
              groupValue: unitProvider.unit,
              onChanged: (value) {
                if (value != null) {
                  unitProvider.setUnit(value);
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
