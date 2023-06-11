class Request {
  int id;
  String requestSender;
  String firstName;
  String lastName;
  String address;
  int grade;
  String status;

  Request({
    required this.id,
    required this.requestSender,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.grade,
    required this.status,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'],
      requestSender: json['requestSender'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: json['address'],
      grade: json['grade'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requestSender': requestSender,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'grade': grade,
      'status': status,
    };
  }
}
