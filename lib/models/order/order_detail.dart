// ignore_for_file: unnecessary_question_mark, prefer_void_to_null, dead_code, unnecessary_getters_setters

class OrderDetailBloc {
  Content? _content;
  Null? _error;
  bool? _isSuccess;
  String? _responseTime;

  OrderDetailBloc(
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

  OrderDetailBloc.fromJson(Map<String, dynamic> json) {
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
  int? _orderId;
  int? _customerId;
  String? _customerName;
  Null? _deliveryAddress;
  Store? _store;
  int? _staffId;
  String? _staffName;
  String? _createDate;
  List<ProductList>? _productList;
  double? _totalPrice;
  double? _totalPriceAfterDiscount;
  String? _paymentMethod;
  String? _orderType;
  String? _approvalDate;
  String? _packagedDate;
  String? _deliveryDate;
  String? _receivedDate;
  Null? _rejectedDate;
  String? _status;

  Content(
      {int? orderId,
      int? customerId,
      String? customerName,
      Null? deliveryAddress,
      Store? store,
      int? staffId,
      String? staffName,
      String? createDate,
      List<ProductList>? productList,
      double? totalPrice,
      double? totalPriceAfterDiscount,
      String? paymentMethod,
      String? orderType,
      String? approvalDate,
      String? packagedDate,
      String? deliveryDate,
      String? receivedDate,
      Null? rejectedDate,
      String? status}) {
    if (orderId != null) {
      _orderId = orderId;
    }
    if (customerId != null) {
      _customerId = customerId;
    }
    if (customerName != null) {
      _customerName = customerName;
    }
    if (deliveryAddress != null) {
      _deliveryAddress = deliveryAddress;
    }
    if (store != null) {
      _store = store;
    }
    if (staffId != null) {
      _staffId = staffId;
    }
    if (staffName != null) {
      _staffName = staffName;
    }
    if (createDate != null) {
      _createDate = createDate;
    }
    if (productList != null) {
      _productList = productList;
    }
    if (totalPrice != null) {
      _totalPrice = totalPrice;
    }
    if (totalPriceAfterDiscount != null) {
      _totalPriceAfterDiscount = totalPriceAfterDiscount;
    }
    if (paymentMethod != null) {
      _paymentMethod = paymentMethod;
    }
    if (orderType != null) {
      _orderType = orderType;
    }
    if (approvalDate != null) {
      _approvalDate = approvalDate;
    }
    if (packagedDate != null) {
      _packagedDate = packagedDate;
    }
    if (deliveryDate != null) {
      _deliveryDate = deliveryDate;
    }
    if (receivedDate != null) {
      _receivedDate = receivedDate;
    }
    if (rejectedDate != null) {
      _rejectedDate = rejectedDate;
    }
    if (status != null) {
      _status = status;
    }
  }

  int? get orderId => _orderId;
  set orderId(int? orderId) => _orderId = orderId;
  int? get customerId => _customerId;
  set customerId(int? customerId) => _customerId = customerId;
  String? get customerName => _customerName;
  set customerName(String? customerName) => _customerName = customerName;
  Null? get deliveryAddress => _deliveryAddress;
  set deliveryAddress(Null? deliveryAddress) =>
      _deliveryAddress = deliveryAddress;
  Store? get store => _store;
  set store(Store? store) => _store = store;
  int? get staffId => _staffId;
  set staffId(int? staffId) => _staffId = staffId;
  String? get staffName => _staffName;
  set staffName(String? staffName) => _staffName = staffName;
  String? get createDate => _createDate;
  set createDate(String? createDate) => _createDate = createDate;
  List<ProductList>? get productList => _productList;
  set productList(List<ProductList>? productList) => _productList = productList;
  double? get totalPrice => _totalPrice;
  set totalPrice(double? totalPrice) => _totalPrice = totalPrice;
  double? get totalPriceAfterDiscount => _totalPriceAfterDiscount;
  set totalPriceAfterDiscount(double? totalPriceAfterDiscount) =>
      _totalPriceAfterDiscount = totalPriceAfterDiscount;
  String? get paymentMethod => _paymentMethod;
  set paymentMethod(String? paymentMethod) => _paymentMethod = paymentMethod;
  String? get orderType => _orderType;
  set orderType(String? orderType) => _orderType = orderType;
  String? get approvalDate => _approvalDate;
  set approvalDate(String? approvalDate) => _approvalDate = approvalDate;
  String? get packagedDate => _packagedDate;
  set packagedDate(String? packagedDate) => _packagedDate = packagedDate;
  String? get deliveryDate => _deliveryDate;
  set deliveryDate(String? deliveryDate) => _deliveryDate = deliveryDate;
  String? get receivedDate => _receivedDate;
  set receivedDate(String? receivedDate) => _receivedDate = receivedDate;
  Null? get rejectedDate => _rejectedDate;
  set rejectedDate(Null? rejectedDate) => _rejectedDate = rejectedDate;
  String? get status => _status;
  set status(String? status) => _status = status;

  Content.fromJson(Map<String, dynamic> json) {
    _orderId = json['order_id'];
    _customerId = json['customer_id'];
    _customerName = json['customer_name'];
    _deliveryAddress = json['delivery_address'];
    _store = json['store'] != null ? Store.fromJson(json['store']) : null;
    _staffId = json['staff_id'];
    _staffName = json['staff_name'];
    _createDate = json['create_date'];
    if (json['product_list'] != null) {
      _productList = <ProductList>[];
      json['product_list'].forEach((v) {
        _productList!.add(ProductList.fromJson(v));
      });
    }
    _totalPrice = json['total_price'];
    _totalPriceAfterDiscount = json['total_price_after_discount'];
    _paymentMethod = json['payment_method'];
    _orderType = json['order_type'];
    _approvalDate = json['approval_date'];
    _packagedDate = json['packaged_date'];
    _deliveryDate = json['delivery_date'];
    _receivedDate = json['received_date'];
    _rejectedDate = json['rejected_date'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = _orderId;
    data['customer_id'] = _customerId;
    data['customer_name'] = _customerName;
    data['delivery_address'] = _deliveryAddress;
    if (_store != null) {
      data['store'] = _store!.toJson();
    }
    data['staff_id'] = _staffId;
    data['staff_name'] = _staffName;
    data['create_date'] = _createDate;
    if (_productList != null) {
      data['product_list'] = _productList!.map((v) => v.toJson()).toList();
    }
    data['total_price'] = _totalPrice;
    data['total_price_after_discount'] = _totalPriceAfterDiscount;
    data['payment_method'] = _paymentMethod;
    data['order_type'] = _orderType;
    data['approval_date'] = _approvalDate;
    data['packaged_date'] = _packagedDate;
    data['delivery_date'] = _deliveryDate;
    data['received_date'] = _receivedDate;
    data['rejected_date'] = _rejectedDate;
    data['status'] = _status;
    return data;
  }
}

class Store {
  int? _storeId;
  String? _storeAddress;
  String? _storePhone;
  bool? _status;

  Store(
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

  Store.fromJson(Map<String, dynamic> json) {
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

class ProductList {
  int? _productDetailId;
  String? _productName;
  String? _category;
  String? _colour;
  String? _size;
  String? _productImageUrl;
  double? _pricePerOne;
  double? _price;
  Null? _discountPricePerOne;
  Null? _discountPrice;
  int? _quantity;

  ProductList(
      {int? productDetailId,
      String? productName,
      String? category,
      String? colour,
      String? size,
      String? productImageUrl,
      double? pricePerOne,
      double? price,
      Null? discountPricePerOne,
      Null? discountPrice,
      int? quantity}) {
    if (productDetailId != null) {
      _productDetailId = productDetailId;
    }
    if (productName != null) {
      _productName = productName;
    }
    if (category != null) {
      _category = category;
    }
    if (colour != null) {
      _colour = colour;
    }
    if (size != null) {
      _size = size;
    }
    if (productImageUrl != null) {
      _productImageUrl = productImageUrl;
    }
    if (pricePerOne != null) {
      _pricePerOne = pricePerOne;
    }
    if (price != null) {
      _price = price;
    }
    if (discountPricePerOne != null) {
      _discountPricePerOne = discountPricePerOne;
    }
    if (discountPrice != null) {
      _discountPrice = discountPrice;
    }
    if (quantity != null) {
      _quantity = quantity;
    }
  }

  int? get productDetailId => _productDetailId;
  set productDetailId(int? productDetailId) =>
      _productDetailId = productDetailId;
  String? get productName => _productName;
  set productName(String? productName) => _productName = productName;
  String? get category => _category;
  set category(String? category) => _category = category;
  String? get colour => _colour;
  set colour(String? colour) => _colour = colour;
  String? get size => _size;
  set size(String? size) => _size = size;
  String? get productImageUrl => _productImageUrl;
  set productImageUrl(String? productImageUrl) =>
      _productImageUrl = productImageUrl;
  double? get pricePerOne => _pricePerOne;
  set pricePerOne(double? pricePerOne) => _pricePerOne = pricePerOne;
  double? get price => _price;
  set price(double? price) => _price = price;
  Null? get discountPricePerOne => _discountPricePerOne;
  set discountPricePerOne(Null? discountPricePerOne) =>
      _discountPricePerOne = discountPricePerOne;
  Null? get discountPrice => _discountPrice;
  set discountPrice(Null? discountPrice) => _discountPrice = discountPrice;
  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;

  ProductList.fromJson(Map<String, dynamic> json) {
    _productDetailId = json['product_detail_id'];
    _productName = json['product_name'];
    _category = json['category'];
    _colour = json['colour'];
    _size = json['size'];
    _productImageUrl = json['product_image_url'];
    _pricePerOne = json['price_per_one'];
    _price = json['price'];
    _discountPricePerOne = json['discount_price_per_one'];
    _discountPrice = json['discount_price'];
    _quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_detail_id'] = _productDetailId;
    data['product_name'] = _productName;
    data['category'] = _category;
    data['colour'] = _colour;
    data['size'] = _size;
    data['product_image_url'] = _productImageUrl;
    data['price_per_one'] = _pricePerOne;
    data['price'] = _price;
    data['discount_price_per_one'] = _discountPricePerOne;
    data['discount_price'] = _discountPrice;
    data['quantity'] = _quantity;
    return data;
  }
}
