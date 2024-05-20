import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salicta_mobile/firebase_bloc/model/db_model.dart';

class NotificationModel extends DBModel {
  String type;
  String title;
  String? description;
  bool isRead;
  Timestamp createdAt;
  DocumentReference targetUserRef;
  String targetUserId;

  NotificationModel({
    DocumentReference? ref,
    required this.title,
    required this.createdAt,
    required this.type,
    this.description,
    required this.isRead,
    required this.targetUserId,
    required this.targetUserRef,
  }) : super(ref: ref);
}
