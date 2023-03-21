import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionTable {
  String? uid;
  String? nama;
  String? berat;
  String? total;

  TransactionTable({
    this.uid,
    this.nama,
    this.berat,
    this.total,
  });

  factory TransactionTable.fromFireStore(Map<String, dynamic> fromFireStore) {
    return TransactionTable(
      uid: fromFireStore['uid'],
      nama: fromFireStore['nama'],
      berat: fromFireStore['berat'],
      total: fromFireStore['total'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'nama': nama,
      'berat': berat,
      'total': total,
    };
  }

  TransactionTable copyWith({
    String? uid,
    String? nama,
    String? berat,
    String? total,
  }) {
    return TransactionTable(
      uid: uid ?? this.uid,
      nama: nama ?? this.nama,
      berat: berat ?? this.berat,
      total: total ?? this.total,
    );
  }
}
