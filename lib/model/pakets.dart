class Pakets {
  String? pid;
  String? oid;
  String? nama;
  String? jenis;
  int? harga;

  Pakets({
    this.pid,
    this.oid,
    this.nama,
    this.jenis,
    this.harga,
  });

  factory Pakets.fromJson(Map<String, dynamic> fromJson) {
    return Pakets(
      pid: fromJson['pid'],
      oid: fromJson['oid'],
      nama: fromJson['nama'],
      jenis: fromJson['nama_kelamin'],
      harga: fromJson['harga'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pid': pid,
      'oid': oid,
      'nama': nama,
      'nama_kelamin': jenis,
      'harga': harga,
    };
  }

  Pakets copyWith({
    String? pid,
    String? oid,
    String? nama,
    String? jenis,
    int? harga,
  }) {
    return Pakets(
      pid: pid ?? this.pid,
      oid: oid ?? this.oid,
      nama: nama ?? this.nama,
      jenis: jenis ?? this.jenis,
      harga: harga ?? this.harga,
    );
  }
}
