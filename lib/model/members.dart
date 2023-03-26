class Members {
  String? mid;
  String? nama;
  String? alamat;
  String? jeniskelamin;
  String? kontak;

  Members({
    this.mid,
    this.nama,
    this.alamat,
    this.jeniskelamin,
    this.kontak,
  });

  factory Members.fromJson(Map<String, dynamic> fromJson) {
    return Members(
      mid: fromJson['mid'],
      nama: fromJson['nama'],
      alamat: fromJson['alamat'],
      jeniskelamin: fromJson['jenis_kelamin'],
      kontak: fromJson['kontak'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mid': mid,
      'nama': nama,
      'alamat': alamat,
      'jenis_kelamin': jeniskelamin,
      'kontak': kontak,
    };
  }

  Members copyWith({
    String? mid,
    String? nama,
    String? alamat,
    String? jeniskelamin,
    String? kontak,
  }) {
    return Members(
      mid: mid ?? this.mid,
      nama: nama ?? this.nama,
      alamat: alamat ?? this.alamat,
      jeniskelamin: jeniskelamin ?? this.jeniskelamin,
      kontak: kontak ?? this.kontak,
    );
  }
}
