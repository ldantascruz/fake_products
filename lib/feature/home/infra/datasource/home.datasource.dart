abstract class HomeDatasource {
  Future<List<dynamic>> getProducts();
  Future<dynamic> getProductById({required int productId});
}
