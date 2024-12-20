import '../../../../core/_core.dart';
import '../../../../entity/_entity.dart';
import '../../_home.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    required HomeDatasource datasource,
    required AppStorage storage,
  })  : _datasource = datasource,
        _storage = storage;

  final HomeDatasource _datasource;
  final AppStorage _storage;

  @override
  Future<List<ProductEntity>> getProducts() async {
    try {
      final resultDatasource = await _datasource.getProducts();

      List<ProductEntity> products = resultDatasource.map((product) => ProductEntity.fromMap(product)).toList();

      await _storage.saveProducts(products);

      return products;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductEntity> getProductById({required int productId}) async {
    try {
      final resultDatasource = await _datasource.getProductById(productId: productId);

      return ProductEntity.fromMap(resultDatasource);
    } catch (e) {
      rethrow;
    }
  }
}
