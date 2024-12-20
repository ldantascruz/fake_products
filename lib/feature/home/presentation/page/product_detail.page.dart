import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/_core.dart';
import '../../../../entity/_entity.dart';
import '../../_home.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailPage({super.key, required this.product});

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
                        onTap: () => context.pop(),
                        child: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Product Details',
                        style: Theme.of(context).primaryTextTheme.headlineLarge,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => context.push(HomeRoutesEnum.favorites.fullPath),
                    child: const Icon(Icons.favorite_outline_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Image.network(
                product.image,
                width: double.infinity,
                height: 309,
                fit: BoxFit.fitHeight,
              ),
              const SizedBox(height: 18),
              Text(
                product.title,
                style: Theme.of(context).primaryTextTheme.labelLarge,
              ),
              const SizedBox(height: 22),
              Row(
                spacing: 8,
                children: [
                  const Icon(Icons.star, color: AppColors.starColor),
                  Text(
                    '${product.rating.rate} (${product.rating.count} reviews)',
                    style: Theme.of(context).primaryTextTheme.labelMedium,
                  ),
                  const Spacer(),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).primaryTextTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 38),
              Row(
                spacing: 10,
                children: [
                  const Icon(
                    Icons.sort_outlined,
                    color: AppColors.primaryColor,
                    size: 24,
                  ),
                  // Txt Capitalize first letter to Uppercase
                  Text(
                    product.category.toUpperCase(),
                    style: Theme.of(context).primaryTextTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 38),
              Row(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.menu_outlined,
                    color: AppColors.primaryColor,
                    size: 24,
                  ),
                  // Txt Capitalize first letter to Uppercase
                  Expanded(
                    child: Text(
                      product.description,
                      style: Theme.of(context).primaryTextTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
