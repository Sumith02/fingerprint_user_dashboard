class HttpRoutes {
  static const String url = "https://biometric.http.vsensetech.in";
  static const String login = "$url/user/login";
  static const String fetchDevices = "$url/user/get/biometric_device";
  static const String fetchStudents = "$url/user/get/student";
  static const String fetchStudentLogs = "$url/user/student/logs";
  static const String registerStudent = "$url/users/newstudent";

  static const String updateStudent = "$url/user/update/student";
  static const String deleteStudent = "$url/user/delete/student";
  static const String changePassword = "$url/user/update/password";
  static const String getUnitID = "$url/user/unit_ids";
  static const String getStudentUnitID = "$url/user/get/student_unit_ids";
  static const String createStudent = "$url/user/create/student";
  static const String forgotPassword = "$url/user/forgotpassword";
  static const String verifyOtp = "$url/user/validate/otp";
  static const String changeLabel = "$url/user/update/biometric_device/label";
  static const String setTime = "$url/user/update/time";
  static const String pdfDownload = "$url/user/student/download/pdf";
  static const String excelDownload = "$url/user/student/download/excel";
}
