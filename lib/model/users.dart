class Users {
  String? uid;
  // String? name;
  // String? addres;
  String? email;
  String? password;
  // String? phone;
  // String? roles;

  Users({
    this.uid,
    // this.name,
    // this.addres,
    this.email,
    this.password,
    // this.phone,
    // this.roles,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      uid: json['uid'],
      // name: json['name'],
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
      // 'name': name,
      // 'addres': addres,
      'email': email,
      'password': password,
      // 'phone': phone,
      // 'role': roles,
    };
  }

  Users copyWith({
    String? uid,
    // String? name,
    // String? addres,
    String? email,
    String? password,
    // String? phone,
    // String? roles,
  }) {
    return Users(
      uid: uid ?? this.uid,
      // name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      // roles: roles ?? this.roles,
    );
  }
}
