import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  static Future<bool> isInternetAvailable() async {
    final result = await Connectivity().checkConnectivity();

    return result != ConnectivityResult.none;
  }
}