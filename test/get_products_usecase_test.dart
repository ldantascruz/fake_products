import 'package:fake_products/entity/_entity.dart';
import 'package:fake_products/feature/home/_home.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late GetProductsUsecase usecase;
  late MockHomeRepository mockRepository;

  setUp(() {
    mockRepository = MockHomeRepository();
    usecase = GetProductsUsecase(repository: mockRepository);
  });

  group('GetProductsUsecase', () {
    test('should return a list of ProductEntity when the repository call is successful', () async {
      // Arrange
      const products = [
        ProductEntity(
          id: 1,
          title: 'Test Product',
          price: 99.99,
          description: 'Test Description',
          category: 'Test Category',
          image: 'http://test.com/image.png',
          rating: RatingEntity(count: 100, rate: 4.5),
        ),
      ];
      when(() => mockRepository.getProducts()).thenAnswer((_) async => products);

      // Act
      final result = await usecase();

      // Assert
      expect(result, products);
      verify(() => mockRepository.getProducts()).called(1);
    });

    test('should rethrow an exception when the repository call fails', () async {
      // Arrange
      when(() => mockRepository.getProducts()).thenThrow(Exception('Test error'));

      // Act
      final call = usecase();

      // Assert
      expect(() => call, throwsA(isA<Exception>()));
      verify(() => mockRepository.getProducts()).called(1);
    });
  });
}
