import 'package:fake_products/core/_core.dart';
import 'package:fake_products/entity/_entity.dart';
import 'package:fake_products/feature/home/_home.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeDatasource extends Mock implements HomeDatasource {}

class MockAppStorage extends Mock implements AppStorage {}

void main() {
  late HomeRepositoryImpl repository;
  late MockHomeDatasource mockDatasource;
  late MockAppStorage mockStorage;

  setUp(() {
    mockDatasource = MockHomeDatasource();
    mockStorage = MockAppStorage();
    repository = HomeRepositoryImpl(
      datasource: mockDatasource,
      storage: mockStorage,
    );
  });

  group('HomeRepositoryImpl', () {
    test('should return a list of ProductEntity when datasource call is successful', () async {
      // Arrange
      final productMap = {
        'id': 1,
        'title': 'Test Product',
        'price': 99.99,
        'description': 'Test Description',
        'category': 'Test Category',
        'image': 'http://test.com/image.png',
        'rating': {'count': 100, 'rate': 4.5},
      };
      final productEntity = ProductEntity.fromMap(productMap);
      when(() => mockDatasource.getProducts()).thenAnswer((_) async => [productMap]);
      when(() => mockStorage.saveProducts(any())).thenAnswer((_) async => {});

      // Act
      final result = await repository.getProducts();

      // Assert
      expect(result, [productEntity]);
      verify(() => mockDatasource.getProducts()).called(1);
      verify(() => mockStorage.saveProducts([productEntity])).called(1);
    });

    test('should rethrow an exception when datasource call fails', () async {
      // Arrange
      when(() => mockDatasource.getProducts()).thenThrow(Exception('Test error'));

      // Act
      final call = repository.getProducts();

      // Assert
      expect(() => call, throwsA(isA<Exception>()));
      verify(() => mockDatasource.getProducts()).called(1);
    });
  });
}
