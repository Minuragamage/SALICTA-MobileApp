import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String name;
  String image;
  String key;

  CategoryModel({
    DocumentReference? ref,
    required this.name,
    required this.key,
    required this.image,
  });
}
