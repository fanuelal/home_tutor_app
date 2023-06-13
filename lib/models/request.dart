class Request {
  String? id;
  String requestSender;
  String requestReciver;
  String teacherName;
  String subject;
  String teacherImg;
  String studentImg;
  String studentName;
  String address;
  int grade;
  String status;
  bool isAccepted;
  Request({
    this.id,
    required this.requestSender,
    required this.requestReciver,
    required this.teacherName,
    required this.subject,
    required this.teacherImg,
    required this.studentImg,
    required this.studentName,
    required this.address,
    required this.grade,
    required this.status,
    this.isAccepted = false
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'],
      requestSender: json['requestSender'] ?? '',
      requestReciver: json['requestReciver'] ?? '',
      teacherName: json['teacherName'] ?? '',
      subject: json['subject'] ?? '',
      teacherImg: json['teacherImg'] ?? '',
      studentImg: json['studentImg'] ?? '',
      studentName: json['studentName'] ?? '',
      address: json['address'] ?? '',
      grade: json['grade'] ?? '',
      status: json['status'] ?? '',
      isAccepted: json['isAccepted'] ?? false
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requestSender': requestSender,
      'requestReciver': requestReciver,
      'teacherName': teacherName,
      'subject': subject,
      'teacherImg': teacherImg,
      'studentImg': studentImg,
      'studentName': studentName,
      'address': address,
      'grade': grade,
      'status': status,
      'isAccepted': isAccepted
    };
  }
}
