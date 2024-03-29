// ignore_for_file: prefer_void_to_null, unnecessary_question_mark, dead_code, unnecessary_getters_setters

class ProductList {
  int? _currentPage;
  int? _totalPages;
  int? _pageSize;
  int? _totalCount;
  bool? _hasPrevious;
  bool? _hasNext;
  List<ContentProductList>? _content;
  Null? _error;
  bool? _isSuccess;
  String? _responseTime;

  ProductList(
      {int? currentPage,
      int? totalPages,
      int? pageSize,
      int? totalCount,
      bool? hasPrevious,
      bool? hasNext,
      List<ContentProductList>? content,
      Null? error,
      bool? isSuccess,
      String? responseTime}) {
    if (currentPage != null) {
      _currentPage = currentPage;
    }
    if (totalPages != null) {
      _totalPages = totalPages;
    }
    if (pageSize != null) {
      _pageSize = pageSize;
    }
    if (totalCount != null) {
      _totalCount = totalCount;
    }
    if (hasPrevious != null) {
      _hasPrevious = hasPrevious;
    }
    if (hasNext != null) {
      _hasNext = hasNext;
    }
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

  int? get currentPage => _currentPage;
  set currentPage(int? currentPage) => _currentPage = currentPage;
  int? get totalPages => _totalPages;
  set totalPages(int? totalPages) => _totalPages = totalPages;
  int? get pageSize => _pageSize;
  set pageSize(int? pageSize) => _pageSize = pageSize;
  int? get totalCount => _totalCount;
  set totalCount(int? totalCount) => _totalCount = totalCount;
  bool? get hasPrevious => _hasPrevious;
  set hasPrevious(bool? hasPrevious) => _hasPrevious = hasPrevious;
  bool? get hasNext => _hasNext;
  set hasNext(bool? hasNext) => _hasNext = hasNext;
  List<ContentProductList>? get content => _content;
  set content(List<ContentProductList>? content) => _content = content;
  Null? get error => _error;
  set error(Null? error) => _error = error;
  bool? get isSuccess => _isSuccess;
  set isSuccess(bool? isSuccess) => _isSuccess = isSuccess;
  String? get responseTime => _responseTime;
  set responseTime(String? responseTime) => _responseTime = responseTime;

  ProductList.fromJson(Map<String, dynamic> json) {
    _currentPage = json['current_page'];
    _totalPages = json['total_pages'];
    _pageSize = json['page_size'];
    _totalCount = json['total_count'];
    _hasPrevious = json['has_previous'];
    _hasNext = json['has_next'];
    if (json['content'] != null) {
      _content = <ContentProductList>[];
      json['content'].forEach((v) {
        _content!.add(ContentProductList.fromJson(v));
      });
    }
    _error = json['error'];
    _isSuccess = json['is_success'];
    _responseTime = json['response_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = _currentPage;
    data['total_pages'] = _totalPages;
    data['page_size'] = _pageSize;
    data['total_count'] = _totalCount;
    data['has_previous'] = _hasPrevious;
    data['has_next'] = _hasNext;
    if (_content != null) {
      data['content'] = _content!.map((v) => v.toJson()).toList();
    }
    data['error'] = _error;
    data['is_success'] = _isSuccess;
    data['response_time'] = _responseTime;
    return data;
  }
}

class ContentProductList {
  int? _productId;
  String? _productName;
  int? _quantity;
  double? _price;
  double? _promotionPrice;
  String? _promotionValue;
  String? _imageUrl;
  bool? _status;

  ContentProductList(
      {int? productId,
      String? productName,
      int? quantity,
      double? price,
      double? promotionPrice,
      String? promotionValue,
      String? imageUrl,
      bool? status}) {
    if (productId != null) {
      _productId = productId;
    }
    if (productName != null) {
      _productName = productName;
    }
    if (quantity != null) {
      _quantity = quantity;
    }
    if (price != null) {
      _price = price;
    }
    if (promotionPrice != null) {
      _promotionPrice = promotionPrice;
    }
    if (promotionValue != null) {
      _promotionValue = promotionValue;
    }
    if (imageUrl != null) {
      _imageUrl = imageUrl;
    }
    if (status != null) {
      _status = status;
    }
  }

  int? get productId => _productId;
  set productId(int? productId) => _productId = productId;
  String? get productName => _productName;
  set productName(String? productName) => _productName = productName;
  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;
  double? get price => _price;
  set price(double? price) => _price = price;
  double? get promotionPrice => _promotionPrice;
  set promotionPrice(double? promotionPrice) =>
      _promotionPrice = promotionPrice;
  String? get promotionValue => _promotionValue;
  set promotionValue(String? promotionValue) =>
      _promotionValue = promotionValue;
  String? get imageUrl => _imageUrl;
  set imageUrl(String? imageUrl) => _imageUrl = imageUrl;
  bool? get status => _status;
  set status(bool? status) => _status = status;

  ContentProductList.fromJson(Map<String, dynamic> json) {
    _productId = json['product_id'];
    _productName = json['product_name'];
    _quantity = json['quantity'];
    _price = json['price'];
    _promotionPrice = json['promotion_price'];
    _promotionValue = json['promotion_value'];
    _imageUrl = json['image_url'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = _productId;
    data['product_name'] = _productName;
    data['quantity'] = _quantity;
    data['price'] = _price;
    data['promotion_price'] = _promotionPrice;
    data['promotion_value'] = _promotionValue;
    data['image_url'] = _imageUrl;
    data['status'] = _status;
    return data;
  }
}
