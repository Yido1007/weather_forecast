import 'package:easy_localization/easy_localization.dart';
import 'package:weather_forecast/provider/units/pressure.dart';

double convertPressure(double value, PressureUnit unit) {
  switch (unit) {
    case PressureUnit.hpa:
      return value;
    case PressureUnit.mmhg:
      return value * 0.750062;
    case PressureUnit.atm:
      return value / 1013.25;
    case PressureUnit.psi:
      return value * 0.0145038;
  }
}

String pressureUnitFullName(PressureUnit unit) {
  switch (unit) {
    case PressureUnit.hpa:
      return "hpa".tr();
    case PressureUnit.mmhg:
      return "mmhg".tr();
    case PressureUnit.atm:
      return "atm".tr();
    case PressureUnit.psi:
      return "psi".tr();
  }
}

String pressureUnitSymbol(PressureUnit unit) {
  switch (unit) {
    case PressureUnit.hpa:
      return 'hPa';
    case PressureUnit.mmhg:
      return 'mmHg';
    case PressureUnit.atm:
      return 'atm';
    case PressureUnit.psi:
      return 'psi';
  }
}
