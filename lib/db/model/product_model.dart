import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salicta_mobile/db/model/review.dart';
import 'package:salicta_mobile/firebase_bloc/model/db_model.dart';

class ProductModel extends DBModel {
  String title;
  String description;
  String category;
  List<String> color;
  String itemCode;
  List<String> images;
  List<Review> reviews;
  int price;
  int stock;
  int rating;

  ProductModel({
    DocumentReference? ref,
    required this.title,
    required this.itemCode,
    required this.category,
    required this.price,
    required this.description,
    required this.images,
    required this.stock,
    required this.color,
    required this.rating,
    required this.reviews,
  }) : super(ref: ref);

  static ProductModel fromJson(Map<String, dynamic> data) {
    return ProductModel(
      title: data['title'] ?? '',
      itemCode: data['itemCode'] ?? '',
      category: data['category'] ?? '',
      price: data['price'] ?? 0,
      description: data['description'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      reviews: [],
      stock: data['stock'] ?? 0,
      color: List<String>.from(data['color'] ?? []),
      rating: data['rating'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "itemCode": itemCode,
      "category": category,
      "price": price,
      "description": description,
      "images": images,
      "stock": stock,
      "color": color,
      "rating": rating,
    };
  }
}
