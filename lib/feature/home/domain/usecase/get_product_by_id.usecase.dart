import '../../../../entity/_entity.dart';
import '../../_home.dart';

class GetProductByIdUsecase {
  final HomeRepository repository;

  GetProductByIdUsecase({required this.repository});

  Future<ProductEntity> call({required int productId}) async {
    try {
      return await repository.getProductById(productId: productId);
    } catch (e) {
      rethrow;
    }
  }
}
