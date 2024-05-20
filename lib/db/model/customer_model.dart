import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salicta_mobile/firebase_bloc/model/db_model.dart';
import 'package:salicta_mobile/db/model/address.dart';

class CustomerModel extends DBModel {
  String? name;
  String email;
  String profileImage;
  String? tel;
  String status;
  List<Address> address;
  List<DocumentReference> favourites;

  CustomerModel({
    DocumentReference? ref,
    this.name,
    required this.email,
    required this.status,
    required this.profileImage,
    required this.address,
    required this.favourites,
    this.tel,
  }) : super(ref: ref);

  @override
  CustomerModel clone() {
    return CustomerModel(
      ref: ref,
      name: name,
      email: email,
      profileImage: profileImage,
      address: address,
      tel: tel,
      status: status,
      favourites: favourites,
    );
  }

  @override
  String toString() {
    return 'CustomerModel{name: $name, email: $email, profileImage: $profileImage, tel: $tel, status: $status, address: $address}';
  }
}
