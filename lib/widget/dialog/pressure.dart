//pressure unit alert dialog
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast/provider/units/pressure.dart';

void showPressureUnitDialog(BuildContext context) {
  final unitProvider = Provider.of<PressureUnitProvider>(
    context,
    listen: false,
  );
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('select-press-unit'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<PressureUnit>(
              title: Text("hpa".tr()),
              value: PressureUnit.hpa,
              groupValue: unitProvider.pressureUnit,
              onChanged: (value) {
                if (value != null) {
                  unitProvider.setPressureUnit(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<PressureUnit>(
              title: Text("mmhg".tr()),
              value: PressureUnit.mmhg,
              groupValue: unitProvider.pressureUnit,
              onChanged: (value) {
                if (value != null) {
                  unitProvider.setPressureUnit(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<PressureUnit>(
              title: Text('atm'.tr()),
              value: PressureUnit.atm,
              groupValue: unitProvider.pressureUnit,
              onChanged: (value) {
                if (value != null) {
                  unitProvider.setPressureUnit(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<PressureUnit>(
              title: Text('psi'.tr()),
              value: PressureUnit.psi,
              groupValue: unitProvider.pressureUnit,
              onChanged: (value) {
                if (value != null) {
                  unitProvider.setPressureUnit(value);
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
