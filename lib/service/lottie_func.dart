// weather_info.dart dosyanın en üstüne EKLE!

String getLottieAssetForWeather(String iconCode) {
  switch (iconCode) {
    case "01d":
      return "assets/lottie/clear-day.json";
    case "01n":
      return "assets/lottie/clear-night.json";
    case "02d":
      return "assets/lottie/cloudy-sun.json";
    case "02n":
      return "assets/lottie/cloudy-night.json";
    case "03d":
      return "assets/lottie/partly-cloudy.json";
    case "03n":
      return "assets/lottie/partly-cloudy.json";
    case "04d":
      return "assets/lottie/cloudy.json";
    case "04n":
      return "assets/lottie/cloudy.json";
    case "09d":
      return "assets/lottie/rainy.json";
    case "09n":
      return "assets/lottie/rainy.json";
    case "10d":
      return "assets/lottie/rainy-day.json";
    case "10n":
      return "assets/lottie/rainy-night.json";
    case "11d":
      return "assets/lottie/thunder.json";
    case "11n":
      return "assets/lottie/thunder.json";
    case "13d":
      return "assets/lottie/snow.json";
    case "13n":
      return "assets/lottie/snow.json";
    case "50d":
      return "assets/lottie/misty.json";
    case "50n":
      return "assets/lottie/misty.json";
    default:
      return "assets/lottie/sun.json";
  }
}
