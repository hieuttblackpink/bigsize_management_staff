// ignore_for_file: unnecessary_question_mark, prefer_void_to_null, dead_code, unnecessary_getters_setters

class OrderList {
  int? _currentPage;
  int? _totalPages;
  int? _pageSize;
  int? _totalCount;
  bool? _hasPrevious;
  bool? _hasNext;
  List<Content>? _content;
  Null? _error;
  bool? _isSuccess;
  String? _responseTime;

  OrderList(
      {int? currentPage,
      int? totalPages,
      int? pageSize,
      int? totalCount,
      bool? hasPrevious,
      bool? hasNext,
      List<Content>? content,
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
  List<Content>? get content => _content;
  set content(List<Content>? content) => _content = content;
  Null? get error => _error;
  set error(Null? error) => _error = error;
  bool? get isSuccess => _isSuccess;
  set isSuccess(bool? isSuccess) => _isSuccess = isSuccess;
  String? get responseTime => _responseTime;
  set responseTime(String? responseTime) => _responseTime = responseTime;

  OrderList.fromJson(Map<String, dynamic> json) {
    _currentPage = json['current_page'];
    _totalPages = json['total_pages'];
    _pageSize = json['page_size'];
    _totalCount = json['total_count'];
    _hasPrevious = json['has_previous'];
    _hasNext = json['has_next'];
    if (json['content'] != null) {
      _content = <Content>[];
      json['content'].forEach((v) {
        _content!.add(Content.fromJson(v));
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

class Content {
  int? _orderId;
  double? _totalPrice;
  double? _totalPriceAfterDiscount;
  String? _orderType;
  String? _status;

  Content(
      {int? orderId,
      double? totalPrice,
      double? totalPriceAfterDiscount,
      String? orderType,
      String? status}) {
    if (orderId != null) {
      _orderId = orderId;
    }
    if (totalPrice != null) {
      _totalPrice = totalPrice;
    }
    if (totalPriceAfterDiscount != null) {
      _totalPriceAfterDiscount = totalPriceAfterDiscount;
    }
    if (orderType != null) {
      _orderType = orderType;
    }
    if (status != null) {
      _status = status;
    }
  }

  int? get orderId => _orderId;
  set orderId(int? orderId) => _orderId = orderId;
  double? get totalPrice => _totalPrice;
  set totalPrice(double? totalPrice) => _totalPrice = totalPrice;
  double? get totalPriceAfterDiscount => _totalPriceAfterDiscount;
  set totalPriceAfterDiscount(double? totalPriceAfterDiscount) =>
      _totalPriceAfterDiscount = totalPriceAfterDiscount;
  String? get orderType => _orderType;
  set orderType(String? orderType) => _orderType = orderType;
  String? get status => _status;
  set status(String? status) => _status = status;

  Content.fromJson(Map<String, dynamic> json) {
    _orderId = json['order_id'];
    _totalPrice = json['total_price'];
    _totalPriceAfterDiscount = json['total_price_after_discount'];
    _orderType = json['order_type'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = _orderId;
    data['total_price'] = _totalPrice;
    data['total_price_after_discount'] = _totalPriceAfterDiscount;
    data['order_type'] = _orderType;
    data['status'] = _status;
    return data;
  }
}