class Users {
  String? uid;
  String? oid;
  String? name;
  String? role;
  // String? addres;
  String? email;
  String? password;
  // String? phone;
  // String? roles;

  Users({
    this.uid,
    this.oid,
    this.name,
    this.role,
    // this.addres,
    this.email,
    this.password,
    // this.phone,
    // this.roles,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      uid: json['uid'],
      oid: json['oid'],
      name: json['name'],
      role: json['role'],
      // addres: json['addres'],
      email: json['email'],
      password: json['password'],
      // phone: json['phone'],
      // roles: json['roles'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'oid': oid,
      'name': name,
      'role': role,
      // 'addres': addres,
      'email': email,
      'password': password,
      // 'phone': phone,
      // 'role': roles,
    };
  }

  Users copyWith({
    String? uid,
    String? oid,
    String? name,
    String? role,
    // String? addres,
    String? email,
    String? password,
    // String? phone,
    // String? roles,
  }) {
    return Users(
      uid: uid ?? this.uid,
      oid: oid ?? this.oid,
      name: name ?? this.name,
      role: role ?? this.role,
      email: email ?? this.email,
      password: password ?? this.password,
      // roles: roles ?? this.roles,
    );
  }
}
