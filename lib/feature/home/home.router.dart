import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../entity/_entity.dart';
import '_home.dart';

extension FullPath on HomeRoutesEnum {
  String get fullPath => '${HomeRouter.basePath}/$routePath';
}

enum HomeRoutesEnum {
  home('home', 'home'),
  productDetail('product-detail', 'product-detail'),
  favorites('favorites', 'favorites');

  const HomeRoutesEnum(
    this.routePath,
    this.routeName,
  );

  final String routePath;
  final String routeName;
}

class HomeRouter {
  HomeRouter._();

  static const String basePath = '/home';

  static List<RouteBase> routes = [
    GoRoute(
      name: HomeRoutesEnum.home.routeName,
      path: HomeRoutesEnum.home.fullPath,
      builder: (context, state) {
        final store = GetIt.I.get<ProductStore>();
        return HomePage(store: store);
      },
    ),
    GoRoute(
      name: HomeRoutesEnum.productDetail.routeName,
      path: HomeRoutesEnum.productDetail.fullPath,
      builder: (context, state) {
        final product = state.extra as ProductEntity;

        return ProductDetailPage(product: product);
      },
    ),
    GoRoute(
      name: HomeRoutesEnum.favorites.routeName,
      path: HomeRoutesEnum.favorites.fullPath,
      builder: (context, state) {
        return const FavoritesPage();
      },
    ),
  ];
}
