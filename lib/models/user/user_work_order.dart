// ignore_for_file: unnecessary_question_mark, prefer_void_to_null, dead_code, unnecessary_getters_setters

class StaffWorkingOrder {
  List<Content>? _content;
  Error? _error;
  bool? _isSuccess;
  String? _responseTime;

  StaffWorkingOrder(
      {List<Content>? content,
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

  List<Content>? get content => _content;
  set content(List<Content>? content) => _content = content;
  Error? get error => _error;
  set error(Error? error) => _error = error;
  bool? get isSuccess => _isSuccess;
  set isSuccess(bool? isSuccess) => _isSuccess = isSuccess;
  String? get responseTime => _responseTime;
  set responseTime(String? responseTime) => _responseTime = responseTime;

  StaffWorkingOrder.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      _content = <Content>[];
      json['content'].forEach((v) {
        _content!.add(Content.fromJson(v));
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

class Content {
  String? _date;
  int? _quantityOfOrders;

  Content({String? date, int? quantityOfOrders}) {
    if (date != null) {
      _date = date;
    }
    if (quantityOfOrders != null) {
      _quantityOfOrders = quantityOfOrders;
    }
  }

  String? get date => _date;
  set date(String? date) => _date = date;
  int? get quantityOfOrders => _quantityOfOrders;
  set quantityOfOrders(int? quantityOfOrders) =>
      _quantityOfOrders = quantityOfOrders;

  Content.fromJson(Map<String, dynamic> json) {
    _date = json['date'];
    _quantityOfOrders = json['quantity_of_orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = _date;
    data['quantity_of_orders'] = _quantityOfOrders;
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
