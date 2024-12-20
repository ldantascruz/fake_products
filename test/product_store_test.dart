import 'package:fake_products/core/_core.dart';
import 'package:fake_products/entity/_entity.dart';
import 'package:fake_products/feature/home/_home.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetProductsUsecase extends Mock implements GetProductsUsecase {}

class MockAppStorage extends Mock implements AppStorage {}

void main() {
  late ProductStore store;
  late MockGetProductsUsecase mockUsecase;
  late MockAppStorage mockStorage;

  setUp(() {
    mockUsecase = MockGetProductsUsecase();
    mockStorage = MockAppStorage();
    store = ProductStore(
      getProductsUsecase: mockUsecase,
      appStorage: mockStorage,
    );
  });

  group('ProductStore', () {
    test('should fetch products and update state correctly', () async {
      // Arrange
      const product = ProductEntity(
        id: 1,
        title: 'Test Product',
        price: 99.99,
        description: 'Test Description',
        category: 'Test Category',
        image: 'http://test.com/image.png',
        rating: RatingEntity(count: 100, rate: 4.5),
      );
      when(() => mockUsecase()).thenAnswer((_) async => [product]);

      // Act
      await store.fetchProducts();

      // Assert
      expect(store.products, [product]);
      expect(store.isLoading, false);
      verify(() => mockUsecase()).called(1);
    });

    test('should handle errors when fetching products', () async {
      // Arrange
      when(() => mockUsecase()).thenThrow(Exception('Test error'));

      // Act
      await store.fetchProducts();

      // Assert
      expect(store.errorMessage, isNotNull);
      expect(store.isLoading, false);
    });
  });
}
