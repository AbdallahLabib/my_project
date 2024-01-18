import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  // here i used a getter function or to be accurate abstract method 
  Future <bool> get isConnected ; 
}

class NetworkInfoImpl extends NetworkInfo{

  final InternetConnectionChecker connectionChecker ;

  NetworkInfoImpl({required this.connectionChecker});
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection ;
}