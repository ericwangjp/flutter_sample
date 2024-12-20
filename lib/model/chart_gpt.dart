/// status : {"code":200,"msg":"success"}
/// key : "c55cf460e72d178f90dea0da5f731a9707d5fd25636fcf51feeb39923b80127f"

class ChartGpt {
  ChartGpt({
    Status? status,
    String? key,
  }) {
    _status = status;
    _key = key;
  }

  ChartGpt.fromJson(dynamic json) {
    _status = json['status'] != null ? Status.fromJson(json['status']) : null;
    _key = json['key'].toString();
  }

  Status? _status;
  String? _key;

  ChartGpt copyWith({
    Status? status,
    String? key,
  }) =>
      ChartGpt(
        status: status ?? _status,
        key: key ?? _key,
      );

  Status? get status => _status;

  String? get key => _key;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_status != null) {
      map['status'] = _status?.toJson();
    }
    map['key'] = _key;
    return map;
  }
}

/// code : 200
/// msg : "success"

class Status {
  Status({
    int? code,
    String? msg,
  }) {
    _code = code;
    _msg = msg;
  }

  Status.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
  }

  int? _code;
  String? _msg;

  Status copyWith({
    int? code,
    String? msg,
  }) =>
      Status(
        code: code ?? _code,
        msg: msg ?? _msg,
      );

  int? get code => _code;

  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    return map;
  }
}
