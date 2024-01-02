void main(List<String> arguments) {
  var json1 = {"name": "ahmed", "age": 33, "isAccepted": true};
  var user1 = User(
      name: json1['name'] as String,
      age: json1['age'] as int,
      isAccepted: json1['isAccepted'] as bool);
  var json2 = {"name": "mahmoud", "age": 25, "isAccepted": false};
  var user2 = User.fromJson(json2);
}
class User {
  String? name;
  int? age;
  bool? isAccepted;
  User({this.name, this.age, this.isAccepted});
  User.fromJson(Map<String, dynamic> data) {
    name = data['name'];
    age = data['age'];
    isAccepted = data['isAccepted'];
  }
  Map<String, dynamic> toJson() {
    return {"name": name, "age": age, "isAccepted": isAccepted};
  }
}