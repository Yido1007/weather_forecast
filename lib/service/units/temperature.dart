import 'package:weather_forecast/provider/units/temperature.dart';

double convertTemperature(double value, TemperatureUnit unit) {
  switch (unit) {
    case TemperatureUnit.celsius:
      return value;
    case TemperatureUnit.fahrenheit:
      return value * 9 / 5 + 32;
    case TemperatureUnit.kelvin:
      return value + 273.15;
  }
}

String unitSymbol(TemperatureUnit unit) {
  switch (unit) {
    case TemperatureUnit.celsius:
      return '°C';
    case TemperatureUnit.fahrenheit:
      return '°F';
    case TemperatureUnit.kelvin:
      return 'K';
  }
}

String temperatureUnitFullName(TemperatureUnit temperatureunit) {
  switch (temperatureunit) {
    case TemperatureUnit.celsius:
      return 'Santigrat (°C)';
    case TemperatureUnit.fahrenheit:
      return 'Fahrenheit (°F)';
    case TemperatureUnit.kelvin:
      return 'Kelvin (K)';
  }
}
