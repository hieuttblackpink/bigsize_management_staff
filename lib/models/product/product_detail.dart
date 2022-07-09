// ignore_for_file: unnecessary_question_mark, prefer_void_to_null, dead_code, unnecessary_getters_setters

class ProductDetail {
  ContentProductDetail? _content;
  Null? _error;
  bool? _isSuccess;
  String? _responseTime;
  int? _quantityInNewOrder;

  ProductDetail(
      {ContentProductDetail? content,
      Null? error,
      bool? isSuccess,
      String? responseTime,
      int? quantityInNewOrder}) {
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
    if (quantityInNewOrder != null) {
      _quantityInNewOrder = quantityInNewOrder;
    }
  }

  ContentProductDetail? get content => _content;
  set content(ContentProductDetail? content) => _content = content;
  Null? get error => _error;
  set error(Null? error) => _error = error;
  bool? get isSuccess => _isSuccess;
  set isSuccess(bool? isSuccess) => _isSuccess = isSuccess;
  String? get responseTime => _responseTime;
  set responseTime(String? responseTime) => _responseTime = responseTime;
  int? get quantityInNewOrder => _quantityInNewOrder;
  set quantityInNewOrder(int? quantityInNewOrder) =>
      _quantityInNewOrder = quantityInNewOrder;

  ProductDetail.fromJson(Map<String, dynamic> json) {
    _content = json['content'] != null
        ? ContentProductDetail.fromJson(json['content'])
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

class ContentProductDetail {
  int? _productId;
  int? _productDetailId;
  String? _productName;
  double? _price;
  double? _promotionPrice;
  String? _promotionValue;
  String? _category;
  List<ProductDetailList>? _productDetailList;
  String? _gender;
  List<Images>? _images;
  String? _brand;
  String? _description;
  bool? _status;

  ContentProductDetail(
      {int? productId,
      int? productDetailId,
      String? productName,
      double? price,
      double? promotionPrice,
      String? promotionValue,
      String? category,
      List<ProductDetailList>? productDetailList,
      String? gender,
      List<Images>? images,
      String? brand,
      String? description,
      bool? status}) {
    if (productId != null) {
      _productId = productId;
    }
    if (productDetailId != null) {
      _productDetailId = productDetailId;
    }
    if (productName != null) {
      _productName = productName;
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
    if (productDetailList != null) {
      _productDetailList = productDetailList;
    }
    if (gender != null) {
      _gender = gender;
    }
    if (images != null) {
      _images = images;
    }
    if (brand != null) {
      _brand = brand;
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
  int? get productDetailId => _productDetailId;
  set productDetailId(int? productDetailId) =>
      _productDetailId = productDetailId;
  String? get productName => _productName;
  set productName(String? productName) => _productName = productName;
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
  List<ProductDetailList>? get productDetailList => _productDetailList;
  set productDetailList(List<ProductDetailList>? productDetailList) =>
      _productDetailList = productDetailList;
  String? get gender => _gender;
  set gender(String? gender) => _gender = gender;
  List<Images>? get images => _images;
  set images(List<Images>? images) => _images = images;
  String? get brand => _brand;
  set brand(String? brand) => _brand = brand;
  String? get description => _description;
  set description(String? description) => _description = description;
  bool? get status => _status;
  set status(bool? status) => _status = status;

  ContentProductDetail.fromJson(Map<String, dynamic> json) {
    _productId = json['product_id'];
    _productDetailId = json['product_detail_id'];
    _productName = json['product_name'];
    _price = json['price'];
    _promotionPrice = json['promotion_price'];
    _promotionValue = json['promotion_value'];
    _category = json['category'];
    if (json['product_detail_list'] != null) {
      _productDetailList = <ProductDetailList>[];
      json['product_detail_list'].forEach((v) {
        _productDetailList!.add(ProductDetailList.fromJson(v));
      });
    }
    _gender = json['gender'];
    if (json['images'] != null) {
      _images = <Images>[];
      json['images'].forEach((v) {
        _images!.add(Images.fromJson(v));
      });
    }
    _brand = json['brand'];
    _description = json['description'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = _productId;
    data['product_detail_id'] = _productDetailId;
    data['product_name'] = _productName;
    data['price'] = _price;
    data['promotion_price'] = _promotionPrice;
    data['promotion_value'] = _promotionValue;
    data['category'] = _category;
    if (_productDetailList != null) {
      data['product_detail_list'] =
          _productDetailList!.map((v) => v.toJson()).toList();
    }
    data['gender'] = _gender;
    if (_images != null) {
      data['images'] = _images!.map((v) => v.toJson()).toList();
    }
    data['brand'] = _brand;
    data['description'] = _description;
    data['status'] = _status;
    return data;
  }
}

class ProductDetailList {
  int? _productDetailId;
  int? _productId;
  Size? _size;
  Colour? _colour;
  bool? _selected;

  ProductDetailList(
      {int? productDetailId,
      int? productId,
      Size? size,
      Colour? colour,
      bool? selected}) {
    if (productDetailId != null) {
      _productDetailId = productDetailId;
    }
    if (productId != null) {
      _productId = productId;
    }
    if (size != null) {
      _size = size;
    }
    if (colour != null) {
      _colour = colour;
    }
    if (selected != null) {
      _selected = selected;
    }
  }

  int? get productDetailId => _productDetailId;
  set productDetailId(int? productDetailId) =>
      _productDetailId = productDetailId;
  int? get productId => _productId;
  set productId(int? productId) => _productId = productId;
  Size? get size => _size;
  set size(Size? size) => _size = size;
  Colour? get colour => _colour;
  set colour(Colour? colour) => _colour = colour;
  bool? get selected => _selected;
  set selected(bool? selected) => _selected = selected;

  ProductDetailList.fromJson(Map<String, dynamic> json) {
    _productDetailId = json['product_detail_id'];
    _productId = json['product_id'];
    _size = json['size'] != null ? Size.fromJson(json['size']) : null;
    _colour = json['colour'] != null ? Colour.fromJson(json['colour']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_detail_id'] = _productDetailId;
    data['product_id'] = _productId;
    if (_size != null) {
      data['size'] = _size!.toJson();
    }
    if (_colour != null) {
      data['colour'] = _colour!.toJson();
    }
    return data;
  }
}

class Size {
  int? _sizeId;
  String? _sizeName;
  bool? _status;

  Size({int? sizeId, String? sizeName, bool? status}) {
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

  Size.fromJson(Map<String, dynamic> json) {
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

class Colour {
  int? _colourId;
  String? _colourName;
  String? _colourCode;
  bool? _status;

  Colour(
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

  Colour.fromJson(Map<String, dynamic> json) {
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
