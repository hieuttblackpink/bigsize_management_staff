// ignore_for_file: prefer_void_to_null, unnecessary_question_mark, dead_code, unnecessary_getters_setters

class Store {
  Content? _content;
  Null? _error;
  bool? _isSuccess;
  String? _responseTime;

  Store(
      {Content? content, Null? error, bool? isSuccess, String? responseTime}) {
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

  Content? get content => _content;
  set content(Content? content) => _content = content;
  Null? get error => _error;
  set error(Null? error) => _error = error;
  bool? get isSuccess => _isSuccess;
  set isSuccess(bool? isSuccess) => _isSuccess = isSuccess;
  String? get responseTime => _responseTime;
  set responseTime(String? responseTime) => _responseTime = responseTime;

  Store.fromJson(Map<String, dynamic> json) {
    _content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
    _error = json['error'];
    _isSuccess = json['is_success'];
    _responseTime = json['response_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_content != null) {
      data['content'] = _content!.toJson();
    }
    data['error'] = _error;
    data['is_success'] = _isSuccess;
    data['response_time'] = _responseTime;
    return data;
  }
}

class Content {
  int? _storeId;
  String? _storeAddress;
  String? _storePhone;
  bool? _status;

  Content(
      {int? storeId, String? storeAddress, String? storePhone, bool? status}) {
    if (storeId != null) {
      _storeId = storeId;
    }
    if (storeAddress != null) {
      _storeAddress = storeAddress;
    }
    if (storePhone != null) {
      _storePhone = storePhone;
    }
    if (status != null) {
      _status = status;
    }
  }

  int? get storeId => _storeId;
  set storeId(int? storeId) => _storeId = storeId;
  String? get storeAddress => _storeAddress;
  set storeAddress(String? storeAddress) => _storeAddress = storeAddress;
  String? get storePhone => _storePhone;
  set storePhone(String? storePhone) => _storePhone = storePhone;
  bool? get status => _status;
  set status(bool? status) => _status = status;

  Content.fromJson(Map<String, dynamic> json) {
    _storeId = json['store_id'];
    _storeAddress = json['store_address'];
    _storePhone = json['store_phone'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_id'] = _storeId;
    data['store_address'] = _storeAddress;
    data['store_phone'] = _storePhone;
    data['status'] = _status;
    return data;
  }
}
