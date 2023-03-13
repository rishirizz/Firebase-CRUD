class AddUserRequestModel {
  String? id;
  String? name;
  int? age;
  String? city;

  AddUserRequestModel({
    this.id,
    this.name,
    this.age,
    this.city,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id?.trim(),
      'name': name?.trim(),
      'age': age,
      'city': city?.trim(),
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
