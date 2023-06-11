class Teacher {
  int? id;
  String firstName;
  String lastName;
  int experience;
  String? availableTime;
  String? imgUrl;
  double rate;
  String? description;
  double price;
  String subject;
  String address;
  String status;
  String phone;
  String email;
  String? password;
  Teacher(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.experience,
      this.availableTime,
      this.imgUrl,
      this.rate = 0.0,
      this.description,
      required this.price,
      required this.subject,
      required this.address,
      this.status = 'online',
      required this.phone,
      this.password,
      required this.email});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      experience: json['experience'],
      availableTime: json['availableTime'],
      imgUrl: json['imgUrl'],
      rate: json['rate'],
      description: json['description'],
      price: json['price'],
      subject: json['subject'],
      address: json['address'],
      status: json['status'],
      phone: json['phone'],
      email: json['email']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'experience': experience,
      'availableTime': availableTime,
      'imgUrl': imgUrl,
      'rate': rate,
      'description': description,
      'price': price,
      'subject': subject,
      'address': address,
      'status': status,
      'phone': phone,
      'email': email,
    };
  }
}
