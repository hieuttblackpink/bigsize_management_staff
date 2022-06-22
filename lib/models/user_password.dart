// ignore_for_file: unnecessary_getters_setters

class UserPassword {
  bool? _content;
  Error? _error;
  Errors? _errors;
  bool? _isSuccess;
  String? _responseTime;

  UserPassword(
      {bool? content,
      Error? error,
      Errors? errors,
      bool? isSuccess,
      String? responseTime}) {
    if (content != null) {
      _content = content;
    }
    if (error != null) {
      _error = error;
    }
    if (errors != null) {
      _errors = errors;
    }
    if (isSuccess != null) {
      _isSuccess = isSuccess;
    }
    if (responseTime != null) {
      _responseTime = responseTime;
    }
  }

  bool? get content => _content;
  set content(bool? content) => _content = content;
  Error? get error => _error;
  set error(Error? error) => _error = error;
  Errors? get errors => _errors;
  set errors(Errors? errors) => _errors = errors;
  bool? get isSuccess => _isSuccess;
  set isSuccess(bool? isSuccess) => _isSuccess = isSuccess;
  String? get responseTime => _responseTime;
  set responseTime(String? responseTime) => _responseTime = responseTime;

  UserPassword.fromJson(Map<String, dynamic> json) {
    _content = json['content'];
    _error = json['error'] != null ? Error.fromJson(json['error']) : null;
    _errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    _isSuccess = json['is_success'];
    _responseTime = json['response_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = _content;
    if (_error != null) {
      data['error'] = _error!.toJson();
    }
    if (_errors != null) {
      data['errors'] = _errors!.toJson();
    }
    data['is_success'] = _isSuccess;
    data['response_time'] = _responseTime;
    return data;
  }
}

class Error {
  List<String>? _confirmNewPassword;
  int? _code;
  String? _type;
  String? _message;

  Error(
      {List<String>? confirmNewPassword,
      int? code,
      String? type,
      String? message}) {
    if (confirmNewPassword != null) {
      _confirmNewPassword = confirmNewPassword;
    }
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

  List<String>? get confirmNewPassword => _confirmNewPassword;
  set confirmNewPassword(List<String>? confirmNewPassword) =>
      _confirmNewPassword = confirmNewPassword;
  int? get code => _code;
  set code(int? code) => _code = code;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get message => _message;
  set message(String? message) => _message = message;

  Error.fromJson(Map<String, dynamic> json) {
    _confirmNewPassword = json['ConfirmNewPassword']?.cast<String>();
    _code = json['code'];
    _type = json['type'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ConfirmNewPassword'] = _confirmNewPassword;
    data['code'] = _code;
    data['type'] = _type;
    data['message'] = _message;
    return data;
  }
}

class Errors {
  List<String>? _confirmNewPassword;

  Errors({List<String>? confirmNewPassword}) {
    if (confirmNewPassword != null) {
      _confirmNewPassword = confirmNewPassword;
    }
  }

  List<String>? get confirmNewPassword => _confirmNewPassword;
  set confirmNewPassword(List<String>? confirmNewPassword) =>
      _confirmNewPassword = confirmNewPassword;

  Errors.fromJson(Map<String, dynamic> json) {
    _confirmNewPassword = json['ConfirmNewPassword'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ConfirmNewPassword'] = _confirmNewPassword;
    return data;
  }
}
