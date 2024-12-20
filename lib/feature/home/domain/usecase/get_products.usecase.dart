import '../../../../entity/_entity.dart';
import '../../_home.dart';

class GetProductsUsecase {
  final HomeRepository repository;

  GetProductsUsecase({required this.repository});

  Future<List<ProductEntity>> call() async {
    try {
      return await repository.getProducts();
    } catch (e) {
      rethrow;
    }
  }
}
