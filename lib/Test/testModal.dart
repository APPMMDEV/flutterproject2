class MyModel {
  String name;
  int age;

  MyModel({required this.name, required this.age});

  // Convert the model object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
    };
  }

  // Create a factory constructor to create a model object from a JSON map
  factory MyModel.fromJson(Map<String, dynamic> json) {
    return MyModel(
      name: json['name'],
      age: json['age'],
    );
  }
}
