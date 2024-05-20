import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salicta_mobile/db/model/product_model.dart';
import 'package:salicta_mobile/db/model/review.dart';
import 'package:salicta_mobile/firebase_bloc/repo/firebase_repository.dart';

class ProductRepository extends FirebaseRepository<ProductModel> {
  ProductRepository() : super("Products");

  @override
  ProductModel fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data()!;
    return ProductModel(
      ref: snapshot.reference,
      title: data['title'],
      color: List<String>.from(data['color'] ?? []).toList(growable: false),
      description: data['description'] ?? '',
      category: data['category'],
      stock: data['stock'],
      price: data['price'],
      itemCode: data['itemCode'],
      rating: data['rating'],
      images: List<String>.from(data['images'] ?? []).toList(growable: false),
      reviews: List<Map<String, dynamic>>.from(data['reviews'] ?? [])
          .map((e) => Review.fromJson(e))
          .toList(),
    );
  }

  @override
  Map<String, Object?> toMap(ProductModel value, SetOptions? options) {
    return {
      'title': value.title,
      'description': value.description,
      'category': value.category,
      'stock': value.stock,
      'price': value.price,
      'itemCode': value.itemCode,
      'images': value.images,
      'color': value.color,
      'rating': value.rating,
      'reviews': (value.reviews).map((e) => e.toJson()),
    };
  }
}
