// ignore_for_file: unnecessary_question_mark, prefer_void_to_null, dead_code, unnecessary_getters_setters

class ProductSize {
  List<ProductSizeContent>? _content;
  Null? _error;
  bool? _isSuccess;
  String? _responseTime;

  ProductSize(
      {List<ProductSizeContent>? content,
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

  List<ProductSizeContent>? get content => _content;
  set content(List<ProductSizeContent>? content) => _content = content;
  Null? get error => _error;
  set error(Null? error) => _error = error;
  bool? get isSuccess => _isSuccess;
  set isSuccess(bool? isSuccess) => _isSuccess = isSuccess;
  String? get responseTime => _responseTime;
  set responseTime(String? responseTime) => _responseTime = responseTime;

  ProductSize.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      _content = <ProductSizeContent>[];
      json['content'].forEach((v) {
        _content!.add(ProductSizeContent.fromJson(v));
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

class ProductSizeContent {
  int? _sizeId;
  String? _sizeName;
  bool? _status;

  ProductSizeContent({int? sizeId, String? sizeName, bool? status}) {
    if (sizeId != null) {
      _sizeId = sizeId;
    }
    if (sizeName != null) {
      _sizeName = sizeName;
    }
    if (status != null) {
      _status = status;
    }
  }

  int? get sizeId => _sizeId;
  set sizeId(int? sizeId) => _sizeId = sizeId;
  String? get sizeName => _sizeName;
  set sizeName(String? sizeName) => _sizeName = sizeName;
  bool? get status => _status;
  set status(bool? status) => _status = status;

  ProductSizeContent.fromJson(Map<String, dynamic> json) {
    _sizeId = json['size_id'];
    _sizeName = json['size_name'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['size_id'] = _sizeId;
    data['size_name'] = _sizeName;
    data['status'] = _status;
    return data;
  }
}
