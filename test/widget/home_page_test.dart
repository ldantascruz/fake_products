import 'package:fake_products/entity/_entity.dart';
import 'package:fake_products/feature/home/_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' hide when;
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class MockProductStore extends Mock implements ProductStore {
  final ObservableList<ProductEntity> _defaultProducts = ObservableList.of([]);
  final Map<ProductEntity, bool> _favorites = {};

  @override
  ObservableList<ProductEntity> get filteredProducts => _defaultProducts;

  @override
  bool isFavorite(ProductEntity product) => _favorites[product] ?? false;

  @override
  bool get isLoading => super.noSuchMethod(Invocation.getter(#isLoading)) as bool;

  @override
  String? get errorMessage => super.noSuchMethod(Invocation.getter(#errorMessage)) as String?;

  void addProduct(ProductEntity product) {
    _defaultProducts.add(product);
  }

  void setFavorite(ProductEntity product, bool isFav) {
    _favorites[product] = isFav;
  }
}

void main() {
  late MockProductStore mockStore;
  late GoRouter router;

  setUpAll(() {
    router = GoRouter(
      initialLocation: '/home/home',
      routes: [
        GoRoute(
          name: HomeRoutesEnum.home.routeName,
          path: '/home/home',
          builder: (context, state) => HomePage(store: mockStore),
        ),
      ],
    );

    registerFallbackValue(const ProductEntity(
      id: 0,
      title: 'Fallback Product',
      price: 0.0,
      description: '',
      category: '',
      image: '',
      rating: RatingEntity(count: 0, rate: 0.0),
    ));
  });

  setUp(
    () {
      mockStore = MockProductStore();
      GetIt.I.registerSingleton<ProductStore>(mockStore);

      // Configure `isLoading` e `errorMessage` usando `when`
      when(() => mockStore.isLoading).thenReturn(false);
      when(() => mockStore.errorMessage).thenReturn(null);

      // Adicione produtos diretamente
      mockStore.addProduct(const ProductEntity(
        id: 1,
        title: 'Product 1',
        price: 19.99,
        description: 'Description 1',
        category: 'Category 1',
        image: 'http://test.com/product1.png',
        rating: RatingEntity(count: 10, rate: 4.5),
      ));

      mockStore.setFavorite(
        const ProductEntity(
          id: 1,
          title: 'Product 1',
          price: 19.99,
          description: 'Description 1',
          category: 'Category 1',
          image: 'http://test.com/product1.png',
          rating: RatingEntity(count: 10, rate: 4.5),
        ),
        true,
      );
    },
  );

  tearDown(() {
    GetIt.I.reset();
  });

  group('HomePage Widget Tests', () {
    testWidgets('shows loading indicator when isLoading is true', (WidgetTester tester) async {
      when(() => mockStore.isLoading).thenReturn(true);

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders HomePage correctly', (WidgetTester tester) async {
      when(() => mockStore.isLoading).thenReturn(true);
      when(() => mockStore.errorMessage).thenReturn(null);

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pump();

      expect(find.byKey(const Key('products_title')), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.favorite_outline_outlined), findsOneWidget);
    });

    testWidgets('renders HomePage with loaded products', (WidgetTester tester) async {
      when(() => mockStore.isLoading).thenReturn(false);
      when(() => mockStore.errorMessage).thenReturn(null);

      final simulatedProducts = ObservableList.of([
        const ProductEntity(
          id: 2,
          title: 'Loaded Product',
          price: 29.99,
          description: 'Description Loaded',
          category: 'Loaded Category',
          image: 'http://test.com/loadedproduct.png',
          rating: RatingEntity(count: 20, rate: 4.8),
        ),
      ]);

      mockStore.filteredProducts.clear();
      mockStore.filteredProducts.addAll(simulatedProducts);

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pump();

      expect(find.byKey(const Key('products_list')), findsOneWidget);
      expect(find.text('Loaded Product'), findsOneWidget);
    });

    testWidgets('displays list of filtered products', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pump();

      expect(find.text('Product 1'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });
  });
}
