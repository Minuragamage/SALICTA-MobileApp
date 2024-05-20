import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salicta_mobile/db/model/notification_model.dart';
import 'package:salicta_mobile/firebase_bloc/repo/firebase_repository.dart';

class NotificationRepository extends FirebaseRepository<NotificationModel> {
  NotificationRepository() : super('Notifications');

  @override
  NotificationModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data()!;

    return NotificationModel(
      ref: snapshot.reference,
      title: data['title'] ?? '',
      createdAt: data['createdAt'],
      type: data['type'],
      isRead: data['isRead'] ?? false,
      description: data['description'] ?? '',
      targetUserId: data['targetUserId'] ?? '',
      targetUserRef: data['targetUserRef'],
    );
  }

  @override
  Map<String, Object?> toMap(NotificationModel value, SetOptions? options) {
    return {
      'title': value.title,
      'description': value.description,
      'type': value.type ?? '',
      'isRead': value.isRead,
      'targetUserId': value.targetUserId,
      'targetUserRef': value.targetUserRef,
      'createdAt': value.createdAt,
    };
  }
}
