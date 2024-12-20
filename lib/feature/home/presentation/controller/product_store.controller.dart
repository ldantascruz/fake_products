import 'package:mobx/mobx.dart';
import '../../../../core/_core.dart';
import '../../../../entity/_entity.dart';
import '../../_home.dart';

part 'product_store.controller.g.dart';

class ProductStore = ProductStoreBase with _$ProductStore;

abstract class ProductStoreBase with Store {
  ProductStoreBase({
    required GetProductsUsecase getProductsUsecase,
    required AppStorage appStorage,
  })  : _appStorage = appStorage,
        _getProductsUsecase = getProductsUsecase {
    loadFavorites();
  }

  final GetProductsUsecase _getProductsUsecase;
  final AppStorage _appStorage;
  final Debouncer _debouncer = Debouncer(milliseconds: 800);

  @observable
  ObservableList<ProductEntity> products = ObservableList<ProductEntity>();

  @observable
  ObservableList<ProductEntity> favoriteProducts = ObservableList<ProductEntity>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  bool hasFetchedProducts = false;

  @action
  Future<void> fetchProducts() async {
    if (hasFetchedProducts) return;

    try {
      isLoading = true;
      errorMessage = null;

      final result = await _getProductsUsecase();
      products = ObservableList.of(result);
    } catch (e) {
      errorMessage = 'Erro ao carregar produtos: $e';
    } finally {
      isLoading = false;
      hasFetchedProducts = true;
    }
  }

  @observable
  String searchQuery = '';

  @computed
  List<ProductEntity> get filteredProducts {
    if (searchQuery.isEmpty) {
      return products.toList();
    }

    return products.where((product) => product.title.toLowerCase().contains(searchQuery.toLowerCase())).toList();
  }

  @action
  void setSearchQuery(String query) {
    _debouncer.run(() {
      searchQuery = query;
    });
  }

  @action
  Future<void> loadFavorites() async {
    try {
      final favorites = await _appStorage.getFavoriteProducts();
      favoriteProducts = ObservableList.of(favorites);
    } catch (e) {
      errorMessage = 'Erro ao carregar favoritos: $e';
    }
  }

  @action
  Future<void> toggleFavorite(ProductEntity product) async {
    if (favoriteProducts.contains(product)) {
      favoriteProducts.remove(product);
    } else {
      favoriteProducts.add(product);
    }
    await _appStorage.saveFavoriteProducts(favoriteProducts.toList());

    favoriteProducts = ObservableList.of(favoriteProducts);
  }

  bool isFavorite(ProductEntity product) {
    return favoriteProducts.any((fav) => fav.id == product.id);
  }
}
