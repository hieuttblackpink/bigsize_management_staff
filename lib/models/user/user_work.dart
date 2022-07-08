// ignore_for_file: prefer_void_to_null, unnecessary_question_mark, dead_code, unnecessary_getters_setters

class StaffWorking {
  List<ContentStaffWorking>? _content;
  Error? _error;
  bool? _isSuccess;
  String? _responseTime;

  StaffWorking(
      {List<ContentStaffWorking>? content,
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

  List<ContentStaffWorking>? get content => _content;
  set content(List<ContentStaffWorking>? content) => _content = content;
  Error? get error => _error;
  set error(Error? error) => _error = error;
  bool? get isSuccess => _isSuccess;
  set isSuccess(bool? isSuccess) => _isSuccess = isSuccess;
  String? get responseTime => _responseTime;
  set responseTime(String? responseTime) => _responseTime = responseTime;

  StaffWorking.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      _content = <ContentStaffWorking>[];
      json['content'].forEach((v) {
        _content!.add(ContentStaffWorking.fromJson(v));
      });
    }
    _error = json['error'] != null ? Error.fromJson(json['error']) : null;
    _isSuccess = json['is_success'];
    _responseTime = json['response_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_content != null) {
      data['content'] = _content!.map((v) => v.toJson()).toList();
    }
    if (_error != null) {
      data['error'] = _error!.toJson();
    }
    data['is_success'] = _isSuccess;
    data['response_time'] = _responseTime;
    return data;
  }
}

class ContentStaffWorking {
  String? _date;
  double? _value;

  ContentStaffWorking({String? date, double? value}) {
    if (date != null) {
      _date = date;
    }
    if (value != null) {
      _value = value;
    }
  }

  String? get date => _date;
  set date(String? date) => _date = date;
  double? get value => _value;
  set value(double? value) => _value = value;

  ContentStaffWorking.fromJson(Map<String, dynamic> json) {
    _date = json['date'];
    _value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = _date;
    data['value'] = _value;
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
