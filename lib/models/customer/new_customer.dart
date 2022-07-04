// ignore_for_file: unnecessary_getters_setters

class NewCustomer {
  String? _phoneNumber;
  String? _fullname;
  String? _email;
  bool? _gender;

  NewCustomer(
      {String? phoneNumber, String? fullname, String? email, bool? gender}) {
    if (phoneNumber != null) {
      _phoneNumber = phoneNumber;
    }
    if (fullname != null) {
      _fullname = fullname;
    }
    if (email != null) {
      _email = email;
    }
    if (gender != null) {
      _gender = gender;
    }
  }

  String? get phoneNumber => _phoneNumber;
  set phoneNumber(String? phoneNumber) => _phoneNumber = phoneNumber;
  String? get fullname => _fullname;
  set fullname(String? fullname) => _fullname = fullname;
  String? get email => _email;
  set email(String? email) => _email = email;
  bool? get gender => _gender;
  set gender(bool? gender) => _gender = gender;

  NewCustomer.fromJson(Map<String, dynamic> json) {
    _phoneNumber = json['phone_number'];
    _fullname = json['fullname'];
    _email = json['email'];
    _gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone_number'] = _phoneNumber;
    data['fullname'] = _fullname;
    data['email'] = _email;
    data['gender'] = _gender;
    return data;
  }
}
