import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../_home.dart';
import '../../../../entity/_entity.dart';

class FavoritesPage extends StatelessWidget {
  final ProductStore store;

  const FavoritesPage({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Favorites',
                        style: Theme.of(context).primaryTextTheme.headlineLarge,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Observer(
                builder: (_) {
                  final favorites = store.favoriteProducts;

                  if (favorites.isEmpty) {
                    return const Center(
                      child: Text('No favorite products yet.'),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const Divider(),
                    padding: const EdgeInsets.only(bottom: 40),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final ProductEntity product = favorites[index];

                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 22),
                        child: Row(
                          children: [
                            Image.network(
                              product.image,
                              width: 100,
                              fit: BoxFit.fitHeight,
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: Theme.of(context).primaryTextTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.yellow),
                                            const SizedBox(width: 8),
                                            Text(
                                              '${product.rating.rate} (${product.rating.count} reviews)',
                                              style: Theme.of(context).primaryTextTheme.labelMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: Theme.of(context).primaryTextTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
