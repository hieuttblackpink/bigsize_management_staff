// ignore_for_file: unnecessary_getters_setters

class NotificationModel {
  int? _currentPage;
  int? _totalPages;
  int? _pageSize;
  int? _totalCount;
  bool? _hasPrevious;
  bool? _hasNext;
  List<ContentNotification>? _content;
  Error? _error;
  bool? _isSuccess;
  String? _responseTime;

  NotificationModel(
      {int? currentPage,
      int? totalPages,
      int? pageSize,
      int? totalCount,
      bool? hasPrevious,
      bool? hasNext,
      List<ContentNotification>? content,
      Error? error,
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
  List<ContentNotification>? get content => _content;
  set content(List<ContentNotification>? content) => _content = content;
  Error? get error => _error;
  set error(Error? error) => _error = error;
  bool? get isSuccess => _isSuccess;
  set isSuccess(bool? isSuccess) => _isSuccess = isSuccess;
  String? get responseTime => _responseTime;
  set responseTime(String? responseTime) => _responseTime = responseTime;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    _currentPage = json['current_page'];
    _totalPages = json['total_pages'];
    _pageSize = json['page_size'];
    _totalCount = json['total_count'];
    _hasPrevious = json['has_previous'];
    _hasNext = json['has_next'];
    if (json['content'] != null) {
      _content = <ContentNotification>[];
      json['content'].forEach((v) {
        _content!.add(ContentNotification.fromJson(v));
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

class ContentNotification {
  int? _notificationId;
  String? _title;
  String? _message;
  String? _referenceUrl;
  String? _createDate;

  ContentNotification(
      {int? notificationId,
      String? title,
      String? message,
      String? referenceUrl,
      String? createDate}) {
    if (notificationId != null) {
      _notificationId = notificationId;
    }
    if (title != null) {
      _title = title;
    }
    if (message != null) {
      _message = message;
    }
    if (referenceUrl != null) {
      _referenceUrl = referenceUrl;
    }
    if (createDate != null) {
      _createDate = createDate;
    }
  }

  int? get notificationId => _notificationId;
  set notificationId(int? notificationId) => _notificationId = notificationId;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get message => _message;
  set message(String? message) => _message = message;
  String? get referenceUrl => _referenceUrl;
  set referenceUrl(String? referenceUrl) => _referenceUrl = referenceUrl;
  String? get createDate => _createDate;
  set createDate(String? createDate) => _createDate = createDate;

  ContentNotification.fromJson(Map<String, dynamic> json) {
    _notificationId = json['notification_id'];
    _title = json['title'];
    _message = json['message'];
    _referenceUrl = json['reference_url'];
    _createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notification_id'] = _notificationId;
    data['title'] = _title;
    data['message'] = _message;
    data['reference_url'] = _referenceUrl;
    data['create_date'] = _createDate;
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
