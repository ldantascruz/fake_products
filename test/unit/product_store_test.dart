import 'package:fake_products/core/_core.dart';
import 'package:fake_products/entity/_entity.dart';
import 'package:fake_products/feature/home/_home.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' hide when;
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
    test('should update isLoading state during fetchProducts', () async {
      when(() => mockUsecase()).thenAnswer((_) async => []);

      final future = store.fetchProducts();

      expect(store.isLoading, isTrue);
      await future;
      expect(store.isLoading, isFalse);
    });

    test('should handle favorites toggling correctly', () async {
      const product = ProductEntity(
        id: 1,
        title: 'Test Product',
        price: 99.99,
        description: 'Description',
        category: 'Category',
        image: 'http://test.com/image.png',
        rating: RatingEntity(count: 10, rate: 4.5),
      );
      when(() => mockStorage.saveFavoriteProducts(any())).thenAnswer((_) async => {});

      store.toggleFavorite(product);

      expect(store.isFavorite(product), isTrue);
      store.toggleFavorite(product);
      expect(store.isFavorite(product), isFalse);
    });

    test('should search products correctly', () async {
      const product1 = ProductEntity(
        id: 1,
        title: 'Apple',
        price: 1.99,
        description: 'Fresh Apple',
        category: 'Fruit',
        image: 'http://test.com/apple.png',
        rating: RatingEntity(count: 5, rate: 4.0),
      );
      const product2 = ProductEntity(
        id: 2,
        title: 'Orange',
        price: 2.99,
        description: 'Fresh Orange',
        category: 'Fruit',
        image: 'http://test.com/orange.png',
        rating: RatingEntity(count: 10, rate: 4.5),
      );
      store.products = ObservableList.of([product1, product2]);

      store.setSearchQuery('apple');
      await Future.delayed(const Duration(milliseconds: 800));

      expect(store.filteredProducts, [product1]);
    });

    test('should retain full product list when search query is empty', () {
      const product1 = ProductEntity(
        id: 1,
        title: 'Product 1',
        price: 9.99,
        description: 'Description 1',
        category: 'Category 1',
        image: 'http://test.com/product1.png',
        rating: RatingEntity(count: 2, rate: 3.5),
      );
      const product2 = ProductEntity(
        id: 2,
        title: 'Product 2',
        price: 19.99,
        description: 'Description 2',
        category: 'Category 2',
        image: 'http://test.com/product2.png',
        rating: RatingEntity(count: 4, rate: 4.0),
      );
      store.products = ObservableList.of([product1, product2]);

      store.setSearchQuery('');

      expect(store.filteredProducts, [product1, product2]);
    });

    test('should persist favorites correctly on toggle', () async {
      const product = ProductEntity(
        id: 1,
        title: 'Favorite Product',
        price: 29.99,
        description: 'Favorite Description',
        category: 'Favorites',
        image: 'http://test.com/favorite.png',
        rating: RatingEntity(count: 3, rate: 5.0),
      );
      when(() => mockStorage.saveFavoriteProducts(any())).thenAnswer((_) async => {});

      store.toggleFavorite(product);

      verify(() => mockStorage.saveFavoriteProducts([product])).called(1);
    });
  });
}
