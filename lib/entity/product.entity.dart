import 'package:equatable/equatable.dart';

import 'rating.entity.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingEntity rating;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  ProductEntity copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    RatingEntity? rating,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    try {
      return {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': rating.toMap(),
      };
    } catch (e) {
      throw Exception('Error on convert ProductEntity to Map $e');
    }
  }

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    try {
      return ProductEntity(
        id: map['id'],
        title: map['title'],
        price: (map['price'] as num).toDouble(),
        description: map['description'],
        category: map['category'],
        image: map['image'],
        rating: RatingEntity.fromMap(map['rating']),
      );
    } catch (e) {
      throw Exception('Error on convert Map to ProductEntity $e');
    }
  }

  @override
  String toString() {
    return 'ProductEntity(id: $id, title: $title, price: $price, description: $description, category: $category, image: $image, rating: $rating)';
  }

  @override
  List<Object?> get props => [id, title, price, description, category, image, rating];
}
