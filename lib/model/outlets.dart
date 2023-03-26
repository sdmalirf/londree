class Outlets {
  String? oid;
  String? nama;
  String? alamat;
  String? kontak;

  Outlets({
    this.oid,
    this.nama,
    this.alamat,
    this.kontak,
  });

  factory Outlets.fromJson(Map<String, dynamic> fromJson) {
    return Outlets(
      oid: fromJson['oid'],
      nama: fromJson['nama'],
      alamat: fromJson['alamat'],
      kontak: fromJson['kontak'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'oid': oid,
      'nama': nama,
      'alamat': alamat,
      'kontak': kontak,
    };
  }

  Outlets copyWith({
    String? oid,
    String? nama,
    String? alamat,
    String? kontak,
  }) {
    return Outlets(
      oid: oid ?? this.oid,
      nama: nama ?? this.nama,
      alamat: alamat ?? this.alamat,
      kontak: kontak ?? this.kontak,
    );
  }
}
