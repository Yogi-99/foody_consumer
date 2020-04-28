class User {
  final String id;
  final String username;
  final String fullName;
  final String email;
  final String password;
  final String phone;
  final String image;
  final String type;
  final String address;
  final String city;

  User({
    this.id,
    this.username,
    this.type,
    this.image,
    this.fullName,
    this.email,
    this.password,
    this.phone,
    this.address,
    this.city,
  });

  factory User.fromJson(Map data) {
    return User(
      email: data['email'],
      fullName: data['full_name'],
      id: data['id'],
      image: data['image'],
      password: data['password'],
      username: data['username'],
      type: data['email'],
      phone: data['phone'],
      address: data['address'],
      city: data['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'image': image,
      'password': password,
      'username': username,
      'type': type,
      'phone': phone,
      'address': address,
      'city': city,
    };
  }
}
