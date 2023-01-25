import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';

class NetworkCheker {
  FlutterNetworkConnectivity flutterNetworkConnectivity=FlutterNetworkConnectivity(
    isContinousLookUp: true,
    lookUpDuration: const Duration(seconds: 5),
    lookUpUrl: 'example.com',
    );

   Future <bool> isInternetConnection () async{
      return  await flutterNetworkConnectivity.isInternetConnectionAvailable();
    }
}