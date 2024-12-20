import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/_core.dart';
import '../../../../entity/_entity.dart';
import '../../_home.dart';

class HomePage extends StatelessWidget {
  final ProductStore store;

  const HomePage({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    store.fetchProducts();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Products',
                    style: Theme.of(context).primaryTextTheme.headlineLarge,
                  ),
                  InkWell(
                    onTap: () => context.push(HomeRoutesEnum.favorites.fullPath),
                    child: const Icon(Icons.favorite_outline_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F1F2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  spacing: 8,
                  children: [
                    Icon(Icons.search, color: Color(0xFF37474F)),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search Anything',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF37474F),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Observer(
                builder: (_) {
                  if (store.isLoading) {
                    return const SizedBox(
                      height: 500,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (store.errorMessage != null) {
                    return SizedBox(
                      height: 500,
                      child: Center(
                        child: Text(
                          'Erro: ${store.errorMessage!}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const Divider(),
                    padding: const EdgeInsets.only(bottom: 40),
                    itemCount: store.products.length,
                    itemBuilder: (context, index) {
                      final ProductEntity product = store.products[index];

                      return InkWell(
                        onTap: () => context.push(HomeRoutesEnum.productDetail.fullPath, extra: product),
                        child: Container(
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
                                        const Icon(
                                          Icons.favorite_outline_outlined,
                                          color: AppColors.primaryLighterColor,
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
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
