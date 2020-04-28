class Restaurant {
  final String id;
  final String name;
  final String address;
  final String city;
  final String image;
  final String phone;

  Restaurant({
    this.id,
    this.name,
    this.address,
    this.city,
    this.image,
    this.phone,
  });

  factory Restaurant.fromJson(Map data) {
    return Restaurant(
      address: data['address'],
      city: data['city'],
      name: data['name'],
      image: data['image'],
      phone: data['phone'],
      id: data['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'city': city,
      'image': image,
      'phone': phone,
    };
  }
}
