import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../feature/_feature.dart';
import '../../_core.dart';

final getIt = GetIt.instance;

class AppLocator {
  Future<void> setupLocator() async {
    getIt.registerLazySingleton<Dio>(() => Dio());
    getIt.registerLazySingleton<AppStorage>(() => AppStorage());

    HomeSetupLocator().call(getIt);
  }
}
