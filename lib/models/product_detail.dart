// ignore_for_file: unnecessary_question_mark, prefer_void_to_null, dead_code, unnecessary_getters_setters

class ProductDetail {
  Content? _content;
  Null? _error;
  bool? _isSuccess;
  String? _responseTime;

  ProductDetail(
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

  ProductDetail.fromJson(Map<String, dynamic> json) {
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
  int? _productId;
  String? _productName;
  int? _quantity;
  double? _price;
  double? _promotionPrice;
  String? _promotionValue;
  String? _category;
  String? _size;
  String? _colour;
  String? _gender;
  List<Images>? _images;
  String? _supplierName;
  String? _description;
  bool? _status;

  Content(
      {int? productId,
      String? productName,
      int? quantity,
      double? price,
      double? promotionPrice,
      String? promotionValue,
      String? category,
      String? size,
      String? colour,
      String? gender,
      List<Images>? images,
      String? supplierName,
      String? description,
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
    if (category != null) {
      _category = category;
    }
    if (size != null) {
      _size = size;
    }
    if (colour != null) {
      _colour = colour;
    }
    if (gender != null) {
      _gender = gender;
    }
    if (images != null) {
      _images = images;
    }
    if (supplierName != null) {
      _supplierName = supplierName;
    }
    if (description != null) {
      _description = description;
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
  String? get category => _category;
  set category(String? category) => _category = category;
  String? get size => _size;
  set size(String? size) => _size = size;
  String? get colour => _colour;
  set colour(String? colour) => _colour = colour;
  String? get gender => _gender;
  set gender(String? gender) => _gender = gender;
  List<Images>? get images => _images;
  set images(List<Images>? images) => _images = images;
  String? get supplierName => _supplierName;
  set supplierName(String? supplierName) => _supplierName = supplierName;
  String? get description => _description;
  set description(String? description) => _description = description;
  bool? get status => _status;
  set status(bool? status) => _status = status;

  Content.fromJson(Map<String, dynamic> json) {
    _productId = json['product_id'];
    _productName = json['product_name'];
    _quantity = json['quantity'];
    _price = json['price'];
    _promotionPrice = json['promotion_price'];
    _promotionValue = json['promotion_value'];
    _category = json['category'];
    _size = json['size'];
    _colour = json['colour'];
    _gender = json['gender'];
    if (json['images'] != null) {
      _images = <Images>[];
      json['images'].forEach((v) {
        _images!.add(Images.fromJson(v));
      });
    }
    _supplierName = json['supplier_name'];
    _description = json['description'];
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
    data['category'] = _category;
    data['size'] = _size;
    data['colour'] = _colour;
    data['gender'] = _gender;
    if (_images != null) {
      data['images'] = _images!.map((v) => v.toJson()).toList();
    }
    data['supplier_name'] = _supplierName;
    data['description'] = _description;
    data['status'] = _status;
    return data;
  }
}

class Images {
  int? _productImageId;
  int? _productId;
  String? _imageUrl;
  bool? _isMainImage;

  Images(
      {int? productImageId,
      int? productId,
      String? imageUrl,
      bool? isMainImage}) {
    if (productImageId != null) {
      _productImageId = productImageId;
    }
    if (productId != null) {
      _productId = productId;
    }
    if (imageUrl != null) {
      _imageUrl = imageUrl;
    }
    if (isMainImage != null) {
      _isMainImage = isMainImage;
    }
  }

  int? get productImageId => _productImageId;
  set productImageId(int? productImageId) => _productImageId = productImageId;
  int? get productId => _productId;
  set productId(int? productId) => _productId = productId;
  String? get imageUrl => _imageUrl;
  set imageUrl(String? imageUrl) => _imageUrl = imageUrl;
  bool? get isMainImage => _isMainImage;
  set isMainImage(bool? isMainImage) => _isMainImage = isMainImage;

  Images.fromJson(Map<String, dynamic> json) {
    _productImageId = json['product_image_id'];
    _productId = json['product_id'];
    _imageUrl = json['image_url'];
    _isMainImage = json['is_main_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_image_id'] = _productImageId;
    data['product_id'] = _productId;
    data['image_url'] = _imageUrl;
    data['is_main_image'] = _isMainImage;
    return data;
  }
}
