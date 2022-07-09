// ignore_for_file: unnecessary_getters_setters

class Customer {
  ContentCustomer? _content;
  Error? _error;
  bool? _isSuccess;
  String? _responseTime;

  Customer(
      {ContentCustomer? content,
      Error? error,
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

  ContentCustomer? get content => _content;
  set content(ContentCustomer? content) => _content = content;
  Error? get error => _error;
  set error(Error? error) => _error = error;
  bool? get isSuccess => _isSuccess;
  set isSuccess(bool? isSuccess) => _isSuccess = isSuccess;
  String? get responseTime => _responseTime;
  set responseTime(String? responseTime) => _responseTime = responseTime;

  Customer.fromJson(Map<String, dynamic> json) {
    _content = json['content'] != null
        ? ContentCustomer.fromJson(json['content'])
        : null;
    _error = json['error'] != null ? Error.fromJson(json['error']) : null;
    _isSuccess = json['is_success'];
    _responseTime = json['response_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_content != null) {
      data['content'] = _content!.toJson();
    }
    if (_error != null) {
      data['error'] = _error!.toJson();
    }
    data['is_success'] = _isSuccess;
    data['response_time'] = _responseTime;
    return data;
  }
}

class ContentCustomer {
  int? _uid;
  String? _fullname;
  String? _phoneNumber;
  String? _email;
  String? _birthday;
  String? _gender;
  String? _pinCode;
  int? _weigth;
  int? _heigth;

  ContentCustomer(
      {int? uid,
      String? fullname,
      String? phoneNumber,
      String? email,
      String? birthday,
      String? gender,
      String? pinCode,
      int? weigth,
      int? heigth}) {
    if (uid != null) {
      _uid = uid;
    }
    if (fullname != null) {
      _fullname = fullname;
    }
    if (phoneNumber != null) {
      _phoneNumber = phoneNumber;
    }
    if (email != null) {
      _email = email;
    }
    if (birthday != null) {
      _birthday = birthday;
    }
    if (gender != null) {
      _gender = gender;
    }
    if (pinCode != null) {
      _pinCode = pinCode;
    }
    if (weigth != null) {
      _weigth = weigth;
    }
    if (heigth != null) {
      _heigth = heigth;
    }
  }

  int? get uid => _uid;
  set uid(int? uid) => _uid = uid;
  String? get fullname => _fullname;
  set fullname(String? fullname) => _fullname = fullname;
  String? get phoneNumber => _phoneNumber;
  set phoneNumber(String? phoneNumber) => _phoneNumber = phoneNumber;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get birthday => _birthday;
  set birthday(String? birthday) => _birthday = birthday;
  String? get gender => _gender;
  set gender(String? gender) => _gender = gender;
  String? get pinCode => _pinCode;
  set pinCode(String? pinCode) => _pinCode = pinCode;
  int? get weigth => _weigth;
  set weigth(int? weigth) => _weigth = weigth;
  int? get heigth => _heigth;
  set heigth(int? heigth) => _heigth = heigth;

  ContentCustomer.fromJson(Map<String, dynamic> json) {
    _uid = json['uid'];
    _fullname = json['fullname'];
    _phoneNumber = json['phone_number'];
    _email = json['email'];
    _birthday = json['birthday'];
    _gender = json['gender'];
    _pinCode = json['pin_code'];
    _weigth = json['weigth'];
    _heigth = json['heigth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = _uid;
    data['fullname'] = _fullname;
    data['phone_number'] = _phoneNumber;
    data['email'] = _email;
    data['birthday'] = _birthday;
    data['gender'] = _gender;
    data['pin_code'] = _pinCode;
    data['weigth'] = _weigth;
    data['heigth'] = _heigth;
    return data;
  }
}

class Error {
  int? _code;
  String? _type;
  String? _message;

  Error({int? code, String? type, String? message}) {
    if (code != null) {
      _code = code;
    }
    if (type != null) {
      _type = type;
    }
    if (message != null) {
      _message = message;
    }
  }

  int? get code => _code;
  set code(int? code) => _code = code;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get message => _message;
  set message(String? message) => _message = message;

  Error.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _type = json['type'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = _code;
    data['type'] = _type;
    data['message'] = _message;
    return data;
  }
}
