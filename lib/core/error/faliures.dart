import 'package:equatable/equatable.dart';
import 'package:flutter_maps/core/constants/faliure_messeges.dart';

abstract class Faliure extends Equatable {
  final String errorMsg = 'unKnown error,please try again';
}

class OfflineFaliure extends Faliure {
  @override
  String get errorMsg => OFFLINE_FALIURE_MESSEGE;

  @override
  List<Object?> get props => [];
}

class ServerFaliure extends Faliure {
  @override
  String get errorMsg => SERVER_FALIURE_MESSEGE;
  @override
  List<Object?> get props => [];
}

class EmptyCacheFaliure extends Faliure {
  @override
  String get errorMsg => EMPTY_CACHE_FALIURE_MESSEGE;
  @override
  List<Object?> get props => [];
}
