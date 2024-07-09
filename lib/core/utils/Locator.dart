import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../core/utils/validations.dart';
import '../Router/Router.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => Routes());
  locator.registerLazySingleton(() => Validation());
  locator.registerLazySingleton(() => GlobalKey<ScaffoldState>());
  locator.registerLazySingleton(() => GlobalKey<NavigatorState>());
}
