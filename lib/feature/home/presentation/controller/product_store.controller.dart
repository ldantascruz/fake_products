import 'package:mobx/mobx.dart';
import '../../../../entity/_entity.dart';
import '../../_home.dart';

part 'product_store.controller.g.dart';

class ProductStore = ProductStoreBase with _$ProductStore;

abstract class ProductStoreBase with Store {
  final GetProductsUsecase getProductsUsecase;

  ProductStoreBase({required this.getProductsUsecase});

  @observable
  ObservableList<ProductEntity> products = ObservableList<ProductEntity>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> fetchProducts() async {
    try {
      isLoading = true;
      errorMessage = null;

      final result = await getProductsUsecase();
      products = ObservableList.of(result);
    } catch (e) {
      errorMessage = 'Erro ao carregar produtos: $e';
    } finally {
      isLoading = false;
    }
  }
}
