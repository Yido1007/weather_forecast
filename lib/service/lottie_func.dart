// weather_info.dart dosyanın en üstüne EKLE!

String getLottieAssetForWeather(String iconCode) {
  switch (iconCode) {
    case "01d":
      return "assets/lottie/sun.json";
    case "01n":
      return "assets/lottie/moon.json";
    case "02d":
    case "02n":
      return "assets/lottie/partly_cloudy.json";
    case "03d":
    case "03n":
    case "04d":
    case "04n":
      return "assets/lottie/cloud.json";
    case "09d":
    case "09n":
      return "assets/lottie/rain.json";
    case "10d":
    case "10n":
      return "assets/lottie/rain.json";
    case "11d":
    case "11n":
      return "assets/lottie/thunder.json";
    case "13d":
    case "13n":
      return "assets/lottie/snow.json";
    default:
      return "assets/lottie/sun.json"; // fallback
  }
}
