class AddUserRequestModel {
  String? id;
  String? name;
  int? age;
  DateTime? birthday;

  AddUserRequestModel({
    this.id,
    this.name,
    this.age,
    this.birthday,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id?.trim(),
      'name': name?.trim(),
      'age': age,
      'birthday': birthday,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
