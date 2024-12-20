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

      final result = await usecase();

      expect(result, products);
      verify(() => mockRepository.getProducts()).called(1);
    });

    test('should rethrow an exception when the repository call fails', () async {
      when(() => mockRepository.getProducts()).thenThrow(Exception('Test error'));

      final call = usecase();

      expect(() => call, throwsA(isA<Exception>()));
      verify(() => mockRepository.getProducts()).called(1);
    });

    test('should handle empty list from repository', () async {
      when(() => mockRepository.getProducts()).thenAnswer((_) async => []);

      final result = await usecase();

      expect(result, isEmpty);
      verify(() => mockRepository.getProducts()).called(1);
    });

    test('should handle a large list of products', () async {
      final products = List.generate(
        1000,
        (index) => ProductEntity(
          id: index,
          title: 'Product $index',
          price: index.toDouble(),
          description: 'Description $index',
          category: 'Category $index',
          image: 'http://test.com/image$index.png',
          rating: RatingEntity(count: index, rate: 4.5),
        ),
      );
      when(() => mockRepository.getProducts()).thenAnswer((_) async => products);

      final result = await usecase();

      expect(result.length, 1000);
      expect(result, products);
    });

    test('should throw specific exception when repository throws', () async {
      when(() => mockRepository.getProducts()).thenThrow(Exception('Specific error'));

      final call = usecase();

      expect(() => call, throwsA(predicate((e) => e.toString().contains('Specific error'))));
    });

    test('should not call repository multiple times for the same usecase instance', () async {
      const products = [
        ProductEntity(
          id: 1,
          title: 'Test Product',
          price: 99.99,
          description: 'Description',
          category: 'Category',
          image: 'http://test.com/image.png',
          rating: RatingEntity(count: 10, rate: 4.5),
        ),
      ];
      when(() => mockRepository.getProducts()).thenAnswer((_) async => products);

      await usecase();
      await usecase();

      verify(() => mockRepository.getProducts()).called(2);
    });

    test('should return correct types for all products', () async {
      const products = [
        ProductEntity(
          id: 1,
          title: 'Test Product',
          price: 99.99,
          description: 'Description',
          category: 'Category',
          image: 'http://test.com/image.png',
          rating: RatingEntity(count: 10, rate: 4.5),
        ),
      ];
      when(() => mockRepository.getProducts()).thenAnswer((_) async => products);

      final result = await usecase();

      expect(result, isA<List<ProductEntity>>());
      expect(result.first.title, isA<String>());
      expect(result.first.price, isA<double>());
    });
  });
}
