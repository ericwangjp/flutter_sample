/// name : "一月"
/// value : "2.5"

class DBDataNodeModel {
  DBDataNodeModel({
    String? name,
    String? value,
  }) {
    _name = name;
    _value = value;
  }

  DBDataNodeModel.fromJson(dynamic json) {
    _name = json['name'];
    _value = json['value'];
  }

  String? _name;
  String? _value;

  DBDataNodeModel copyWith({
    String? name,
    String? value,
  }) =>
      DBDataNodeModel(
        name: name ?? _name,
        value: value ?? _value,
      );

  String? get name => _name;

  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['value'] = _value;
    return map;
  }
}
