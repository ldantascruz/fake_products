import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../core/_core.dart';
import '_home.dart';

class HomeSetupLocator {
  void _datasource(GetIt instance) {
    instance.registerLazySingleton<HomeDatasource>(
      () => HomeDatasourceImpl(
        httpClient: instance.get<Dio>(),
      ),
    );
  }

  void _repository(GetIt instance) {
    instance.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(
        datasource: instance.get<HomeDatasource>(),
        storage: instance.get<AppStorage>(),
      ),
    );
  }

  void _usecase(GetIt instance) {
    instance.registerLazySingleton<GetProductsUsecase>(
      () => GetProductsUsecase(
        repository: instance.get<HomeRepository>(),
      ),
    );
  }

  void _cubit(GetIt instance) {
    instance.registerFactory<ProductStore>(
      () => ProductStore(
        getProductsUsecase: instance.get<GetProductsUsecase>(),
      ),
    );
  }

  void call(GetIt instance) {
    _datasource(instance);
    _repository(instance);
    _usecase(instance);
    _cubit(instance);
  }
}
