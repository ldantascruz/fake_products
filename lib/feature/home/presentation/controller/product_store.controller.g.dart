// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductStore on ProductStoreBase, Store {
  Computed<List<ProductEntity>>? _$filteredProductsComputed;

  @override
  List<ProductEntity> get filteredProducts => (_$filteredProductsComputed ??=
          Computed<List<ProductEntity>>(() => super.filteredProducts,
              name: 'ProductStoreBase.filteredProducts'))
      .value;

  late final _$productsAtom =
      Atom(name: 'ProductStoreBase.products', context: context);

  @override
  ObservableList<ProductEntity> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<ProductEntity> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$favoriteProductsAtom =
      Atom(name: 'ProductStoreBase.favoriteProducts', context: context);

  @override
  ObservableList<ProductEntity> get favoriteProducts {
    _$favoriteProductsAtom.reportRead();
    return super.favoriteProducts;
  }

  @override
  set favoriteProducts(ObservableList<ProductEntity> value) {
    _$favoriteProductsAtom.reportWrite(value, super.favoriteProducts, () {
      super.favoriteProducts = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'ProductStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: 'ProductStoreBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$hasFetchedProductsAtom =
      Atom(name: 'ProductStoreBase.hasFetchedProducts', context: context);

  @override
  bool get hasFetchedProducts {
    _$hasFetchedProductsAtom.reportRead();
    return super.hasFetchedProducts;
  }

  @override
  set hasFetchedProducts(bool value) {
    _$hasFetchedProductsAtom.reportWrite(value, super.hasFetchedProducts, () {
      super.hasFetchedProducts = value;
    });
  }

  late final _$searchQueryAtom =
      Atom(name: 'ProductStoreBase.searchQuery', context: context);

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$fetchProductsAsyncAction =
      AsyncAction('ProductStoreBase.fetchProducts', context: context);

  @override
  Future<void> fetchProducts() {
    return _$fetchProductsAsyncAction.run(() => super.fetchProducts());
  }

  late final _$loadFavoritesAsyncAction =
      AsyncAction('ProductStoreBase.loadFavorites', context: context);

  @override
  Future<void> loadFavorites() {
    return _$loadFavoritesAsyncAction.run(() => super.loadFavorites());
  }

  late final _$toggleFavoriteAsyncAction =
      AsyncAction('ProductStoreBase.toggleFavorite', context: context);

  @override
  Future<void> toggleFavorite(ProductEntity product) {
    return _$toggleFavoriteAsyncAction.run(() => super.toggleFavorite(product));
  }

  late final _$ProductStoreBaseActionController =
      ActionController(name: 'ProductStoreBase', context: context);

  @override
  void setSearchQuery(String query) {
    final _$actionInfo = _$ProductStoreBaseActionController.startAction(
        name: 'ProductStoreBase.setSearchQuery');
    try {
      return super.setSearchQuery(query);
    } finally {
      _$ProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products},
favoriteProducts: ${favoriteProducts},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
hasFetchedProducts: ${hasFetchedProducts},
searchQuery: ${searchQuery},
filteredProducts: ${filteredProducts}
    ''';
  }
}
