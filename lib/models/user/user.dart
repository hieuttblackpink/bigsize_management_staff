// ignore_for_file: prefer_void_to_null, unnecessary_question_mark, dead_code, unnecessary_getters_setters

class StaffLogin {
  ContentStaffLogin? _content;
  Error? _error;
  bool? _isSuccess;
  String? _responseTime;

  StaffLogin(
      {ContentStaffLogin? content,
      Error? error,
      bool? isSuccess,
      String? responseTime}) {
    if (content != null) {
      _content = content;
    }
    if (error != null) {
      _error = error;
    }
    if (isSuccess != null) {
      _isSuccess = isSuccess;
    }
    if (responseTime != null) {
      _responseTime = responseTime;
    }
  }

  ContentStaffLogin? get content => _content;
  set content(ContentStaffLogin? content) => _content = content;
  Error? get error => _error;
  set error(Error? error) => _error = error;
  bool? get isSuccess => _isSuccess;
  set isSuccess(bool? isSuccess) => _isSuccess = isSuccess;
  String? get responseTime => _responseTime;
  set responseTime(String? responseTime) => _responseTime = responseTime;

  StaffLogin.fromJson(Map<String, dynamic> json) {
    _content = json['content'] != null
        ? ContentStaffLogin.fromJson(json['content'])
        : null;
    _error = json['error'] != null ? Error.fromJson(json['error']) : null;
    _isSuccess = json['is_success'];
    _responseTime = json['response_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_content != null) {
      data['content'] = _content!.toJson();
    }
    if (_error != null) {
      data['error'] = _error!.toJson();
    }
    data['is_success'] = _isSuccess;
    data['response_time'] = _responseTime;
    return data;
  }
}

class ContentStaffLogin {
  late String _token;
  late String _role;

  ContentStaffLogin({String? token, String? role}) {
    if (token != null) {
      _token = token;
    }
    if (role != null) {
      _role = role;
    }
  }

  String get token => _token;
  set token(String token) => _token = token;
  String get role => _role;
  set role(String role) => _role = role;

  ContentStaffLogin.fromJson(Map<String, dynamic> json) {
    _token = json['token'];
    _role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = _token;
    data['role'] = _role;
    return data;
  }
}

class Error {
  int? _code;
  String? _type;
  String? _message;

  Error({int? code, String? type, String? message}) {
    if (code != null) {
      _code = code;
    }
    if (type != null) {
      _type = type;
    }
    if (message != null) {
      _message = message;
    }
  }

  int? get code => _code;
  set code(int? code) => _code = code;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get message => _message;
  set message(String? message) => _message = message;

  Error.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _type = json['type'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = _code;
    data['type'] = _type;
    data['message'] = _message;
    return data;
  }
}
