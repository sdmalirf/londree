class Transactions {
  String? tid;
  String? uid;
  String? oid;
  String? nama;
  String? berat;
  String? total;

  Transactions({
    this.tid,
    this.uid,
    this.oid,
    this.nama,
    this.berat,
    this.total,
  });

  factory Transactions.fromJson(Map<String, dynamic> fromJson) {
    return Transactions(
      tid: fromJson['tid'],
      uid: fromJson['uid'],
      oid: fromJson['oid'],
      nama: fromJson['nama'],
      berat: fromJson['berat'],
      total: fromJson['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tid': tid,
      'uid': uid,
      'oid': oid,
      'nama': nama,
      'berat': berat,
      'total': total,
    };
  }

  Transactions copyWith({
    String? tid,
    String? uid,
    String? oid,
    String? nama,
    String? berat,
    String? total,
  }) {
    return Transactions(
      tid: tid ?? this.tid,
      uid: uid ?? this.uid,
      oid: oid ?? this.oid,
      nama: nama ?? this.nama,
      berat: berat ?? this.berat,
      total: total ?? this.total,
    );
  }
}
