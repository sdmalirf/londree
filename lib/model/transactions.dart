class Transactions {
  String? tid;
  String? uid;
  String? nama;
  String? berat;
  String? total;

  Transactions({
    this.tid,
    this.uid,
    this.nama,
    this.berat,
    this.total,
  });

  factory Transactions.fromJson(Map<String, dynamic> fromJson) {
    return Transactions(
      tid: fromJson['tid'],
      uid: fromJson['uid'],
      nama: fromJson['nama'],
      berat: fromJson['berat'],
      total: fromJson['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tid': tid,
      'tid': uid,
      'nama': nama,
      'berat': berat,
      'total': total,
    };
  }

  Transactions copyWith({
    String? tid,
    String? uid,
    String? nama,
    String? berat,
    String? total,
  }) {
    return Transactions(
      tid: tid ?? this.tid,
      uid: uid ?? this.uid,
      nama: nama ?? this.nama,
      berat: berat ?? this.berat,
      total: total ?? this.total,
    );
  }
}
