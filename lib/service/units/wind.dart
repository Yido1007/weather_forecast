import 'package:easy_localization/easy_localization.dart';
import 'package:weather_forecast/provider/units/wind.dart';

double convertWindSpeed(double value, WindSpeedUnit unit) {
  switch (unit) {
    case WindSpeedUnit.ms:
      return value;
    case WindSpeedUnit.kmh:
      return value * 3.6;
    case WindSpeedUnit.mph:
      return value * 2.23694;
  }
}

String windSpeedUnitFullName(WindSpeedUnit unit) {
  switch (unit) {
    case WindSpeedUnit.kmh:
      return 'km/hour'.tr();
    case WindSpeedUnit.ms:
      return 'm/s'.tr();
    case WindSpeedUnit.mph:
      return 'mph'.tr();
  }
}

String windSpeedUnitSymbol(WindSpeedUnit unit) {
  switch (unit) {
    case WindSpeedUnit.kmh:
      return 'km/s';
    case WindSpeedUnit.ms:
      return 'm/s';
    case WindSpeedUnit.mph:
      return 'mph';
  }
}
