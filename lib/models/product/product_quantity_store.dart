// ignore_for_file: prefer_void_to_null, unnecessary_question_mark, dead_code, unnecessary_getters_setters

class ProductQuantityStore {
  ProductQuantityStoreContent? _content;
  Null? _error;
  bool? _isSuccess;
  String? _responseTime;

  ProductQuantityStore(
      {ProductQuantityStoreContent? content,
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

  ProductQuantityStoreContent? get content => _content;
  set content(ProductQuantityStoreContent? content) => _content = content;
  Null? get error => _error;
  set error(Null? error) => _error = error;
  bool? get isSuccess => _isSuccess;
  set isSuccess(bool? isSuccess) => _isSuccess = isSuccess;
  String? get responseTime => _responseTime;
  set responseTime(String? responseTime) => _responseTime = responseTime;

  ProductQuantityStore.fromJson(Map<String, dynamic> json) {
    _content = json['content'] != null
        ? ProductQuantityStoreContent.fromJson(json['content'])
        : null;
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

class ProductQuantityStoreContent {
  int? _storeId;
  int? _productDetailId;
  int? _quantity;

  ProductQuantityStoreContent(
      {int? storeId, int? productDetailId, int? quantity}) {
    if (storeId != null) {
      _storeId = storeId;
    }
    if (productDetailId != null) {
      _productDetailId = productDetailId;
    }
    if (quantity != null) {
      _quantity = quantity;
    }
  }

  int? get storeId => _storeId;
  set storeId(int? storeId) => _storeId = storeId;
  int? get productDetailId => _productDetailId;
  set productDetailId(int? productDetailId) =>
      _productDetailId = productDetailId;
  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;

  ProductQuantityStoreContent.fromJson(Map<String, dynamic> json) {
    _storeId = json['store_id'];
    _productDetailId = json['product_detail_id'];
    _quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_id'] = _storeId;
    data['product_detail_id'] = _productDetailId;
    data['quantity'] = _quantity;
    return data;
  }
}
