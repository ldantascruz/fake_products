import 'package:fake_products/core/_core.dart';
import 'package:fake_products/entity/_entity.dart';
import 'package:fake_products/feature/_feature.dart';
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
    test('should save products locally after fetching', () async {
      final productMap = {
        'id': 1,
        'title': 'Test Product',
        'price': 99.99,
        'description': 'Description',
        'category': 'Category',
        'image': 'http://test.com/image.png',
        'rating': {'count': 10, 'rate': 4.5},
      };
      final productEntity = ProductEntity.fromMap(productMap);
      when(() => mockDatasource.getProducts()).thenAnswer((_) async => [productMap]);
      when(() => mockStorage.saveProducts(any())).thenAnswer((_) async => {});

      final result = await repository.getProducts();

      expect(result, [productEntity]);
      verify(() => mockDatasource.getProducts()).called(1);
      verify(() => mockStorage.saveProducts([productEntity])).called(1);
    });

    test('should handle empty data from datasource', () async {
      when(() => mockDatasource.getProducts()).thenAnswer((_) async => []);
      when(() => mockStorage.saveProducts(any())).thenAnswer((_) async => {});

      final result = await repository.getProducts();

      expect(result, isEmpty);
    });

    test('should throw specific exception when datasource throws', () async {
      when(() => mockDatasource.getProducts()).thenThrow(Exception('Specific error'));

      final call = repository.getProducts();

      expect(() => call, throwsA(predicate((e) => e.toString().contains('Specific error'))));
    });

    test('should not save products locally when datasource fails', () async {
      when(() => mockDatasource.getProducts()).thenThrow(Exception('Fetch failed'));

      final call = repository.getProducts();

      await expectLater(() => call, throwsA(isA<Exception>()));
      verifyNever(() => mockStorage.saveProducts(any()));
    });

    test('should ensure data integrity when saving locally', () async {
      final productMap = {
        'id': 1,
        'title': 'Test Product',
        'price': 99.99,
        'description': 'Description',
        'category': 'Category',
        'image': 'http://test.com/image.png',
        'rating': {'count': 10, 'rate': 4.5},
      };
      final productEntity = ProductEntity.fromMap(productMap);
      when(() => mockDatasource.getProducts()).thenAnswer((_) async => [productMap]);
      when(() => mockStorage.saveProducts(any())).thenAnswer((_) async => {});

      final result = await repository.getProducts();

      expect(result.first.id, equals(productEntity.id));
      expect(result.first.title, equals(productEntity.title));
    });
  });
}
