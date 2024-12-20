import '../../../../entity/_entity.dart';

abstract class HomeRepository {
  Future<List<ProductEntity>> getProducts();
  Future<ProductEntity> getProductById({required int productId});
}
