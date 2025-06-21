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

String pressureUnitFullName(PressureUnit pressureunitname) {
  switch (pressureunitname) {
    case PressureUnit.hpa:
      return 'Hektopascal (hPa)';
    case PressureUnit.mmhg:
      return 'Milimetre Cıva (mmHg)';
    case PressureUnit.atm:
      return 'Atmosfer (atm)';
    case PressureUnit.psi:
      return 'Psi (psi)';
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
