import 'package:equatable/equatable.dart';

class RatingEntity extends Equatable {
  final double rate;
  final int count;

  const RatingEntity({
    required this.rate,
    required this.count,
  });

  RatingEntity copyWith({
    double? rate,
    int? count,
  }) {
    return RatingEntity(
      rate: rate ?? this.rate,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    try {
      return {
        'rate': rate,
        'count': count,
      };
    } catch (e) {
      throw Exception('Error on convert RatingEntity to Map $e');
    }
  }

  factory RatingEntity.fromMap(Map<String, dynamic> map) {
    try {
      return RatingEntity(
        rate: (map['rate'] as num).toDouble(),
        count: map['count'] as int,
      );
    } catch (e) {
      throw Exception('Error on convert Map to RatingEntity $e');
    }
  }

  @override
  String toString() {
    return 'RatingEntity(rate: $rate, count: $count)';
  }

  @override
  List<Object?> get props => [rate, count];
}
