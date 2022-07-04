// ignore_for_file: unnecessary_getters_setters

class NewOrder {
  String? _customerPhoneNumber;
  String? _paymentMethod;
  List<ProductInNewOrder>? _listProduct;

  NewOrder(
      {String? customerPhoneNumber,
      String? paymentMethod,
      List<ProductInNewOrder>? listProduct}) {
    if (customerPhoneNumber != null) {
      _customerPhoneNumber = customerPhoneNumber;
    }
    if (paymentMethod != null) {
      _paymentMethod = paymentMethod;
    }
    if (listProduct != null) {
      _listProduct = listProduct;
    }
  }

  String? get customerPhoneNumber => _customerPhoneNumber;
  set customerPhoneNumber(String? customerPhoneNumber) =>
      _customerPhoneNumber = customerPhoneNumber;
  String? get paymentMethod => _paymentMethod;
  set paymentMethod(String? paymentMethod) => _paymentMethod = paymentMethod;
  List<ProductInNewOrder>? get listProduct => _listProduct;
  set listProduct(List<ProductInNewOrder>? listProduct) =>
      _listProduct = listProduct;

  NewOrder.fromJson(Map<String, dynamic> json) {
    _customerPhoneNumber = json['customer_phone_number'];
    _paymentMethod = json['payment_method'];
    if (json['list_product'] != null) {
      _listProduct = <ProductInNewOrder>[];
      json['list_product'].forEach((v) {
        _listProduct!.add(ProductInNewOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_phone_number'] = _customerPhoneNumber;
    data['payment_method'] = _paymentMethod;
    if (_listProduct != null) {
      data['list_product'] = _listProduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductInNewOrder {
  int? _productDetailId;
  int? _quantity;

  ProductInNewOrder({int? productDetailId, int? quantity}) {
    if (productDetailId != null) {
      _productDetailId = productDetailId;
    }
    if (quantity != null) {
      _quantity = quantity;
    }
  }

  int? get productDetailId => _productDetailId;
  set productDetailId(int? productDetailId) =>
      _productDetailId = productDetailId;
  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;

  ProductInNewOrder.fromJson(Map<String, dynamic> json) {
    _productDetailId = json['product_detail_id'];
    _quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_detail_id'] = _productDetailId;
    data['quantity'] = _quantity;
    return data;
  }
}
