import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/src/set_options.dart';
import 'package:salicta_mobile/db/model/address.dart';
import 'package:salicta_mobile/firebase_bloc/repo/firebase_repository.dart';
import '../model/customer_model.dart';

class CustomerRepository extends FirebaseRepository<CustomerModel> {
  CustomerRepository() : super("Customers");

  @override
  CustomerModel fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return CustomerModel(
      ref: snapshot.reference,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      profileImage: data['profileImage'] ?? '',
      tel: data['tel'] ?? '',
      address: List<Map<String, dynamic>>.from(data['address'] ?? [])
          .map<Address>((e) => Address.fromJson(e))
          .toList(growable: false),
      status: data['status'] ?? 'pending',
      favourites: List<DocumentReference>.from(data['favourites'] ?? []),
    );
  }

  @override
  Map<String, Object?> toMap(CustomerModel value, SetOptions? options) {
    return {
      'email': value.email,
      'name': value.name ?? '',
      'profileImage': value.profileImage ?? '',
      'address': value.address ?? '',
      'tel': value.tel ?? "",
      'status': value.status,
      'favourites': value.favourites ?? [],
    };
  }
}
