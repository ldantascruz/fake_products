import '../../../../entity/_entity.dart';

abstract class HomeRepository {
  Future<List<ProductEntity>> getProducts();
}
