// ignore_for_file: unnecessary_question_mark, prefer_void_to_null, dead_code, unnecessary_getters_setters

class ProductColour {
  List<ProductColourContent>? _content;
  Null? _error;
  bool? _isSuccess;
  String? _responseTime;

  ProductColour(
      {List<ProductColourContent>? content,
      Null? error,
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

  List<ProductColourContent>? get content => _content;
  set content(List<ProductColourContent>? content) => _content = content;
  Null? get error => _error;
  set error(Null? error) => _error = error;
  bool? get isSuccess => _isSuccess;
  set isSuccess(bool? isSuccess) => _isSuccess = isSuccess;
  String? get responseTime => _responseTime;
  set responseTime(String? responseTime) => _responseTime = responseTime;

  ProductColour.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      _content = <ProductColourContent>[];
      json['content'].forEach((v) {
        _content!.add(ProductColourContent.fromJson(v));
      });
    }
    _error = json['error'];
    _isSuccess = json['is_success'];
    _responseTime = json['response_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_content != null) {
      data['content'] = _content!.map((v) => v.toJson()).toList();
    }
    data['error'] = _error;
    data['is_success'] = _isSuccess;
    data['response_time'] = _responseTime;
    return data;
  }
}

class ProductColourContent {
  int? _colourId;
  String? _colourName;
  String? _colourCode;
  bool? _status;

  ProductColourContent(
      {int? colourId, String? colourName, String? colourCode, bool? status}) {
    if (colourId != null) {
      _colourId = colourId;
    }
    if (colourName != null) {
      _colourName = colourName;
    }
    if (colourCode != null) {
      _colourCode = colourCode;
    }
    if (status != null) {
      _status = status;
    }
  }

  int? get colourId => _colourId;
  set colourId(int? colourId) => _colourId = colourId;
  String? get colourName => _colourName;
  set colourName(String? colourName) => _colourName = colourName;
  String? get colourCode => _colourCode;
  set colourCode(String? colourCode) => _colourCode = colourCode;
  bool? get status => _status;
  set status(bool? status) => _status = status;

  ProductColourContent.fromJson(Map<String, dynamic> json) {
    _colourId = json['colour_id'];
    _colourName = json['colour_name'];
    _colourCode = json['colour_code'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['colour_id'] = _colourId;
    data['colour_name'] = _colourName;
    data['colour_code'] = _colourCode;
    data['status'] = _status;
    return data;
  }
}
