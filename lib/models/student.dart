class Student {
  String? id;
  String firstName;
  String lastName;
  int grade;
  String? imgUrl;
  String address;
  String phone;
  String email;
  String? password;
  Student(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.grade,
      required this.address,
      this.imgUrl,
      required this.email,
      required this.phone});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'grade': grade,
      'address': address,
      'imgUrl': imgUrl,
      'email': email,
      'phone': phone
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        grade: json['grade'],
        address: json['address'],
        imgUrl: json['imgUrl'],
        phone: json['phone'],
        email: json['email']);
  }
}


// Example usage

//   String jsonStr = '{"id": 1, "name": "John Doe", "grade": "A", "imgUrl": "https://example.com/image.jpg"}';
//   Map<String, dynamic> jsonData = json.decode(jsonStr);
//   Student student = Student.fromJson(jsonData);

//   print('ID: ${student.id}');
//   print('Name: ${student.name}');
//   print('Grade: ${student.grade}');
//   print('Image URL: ${student.imgUrl}');
