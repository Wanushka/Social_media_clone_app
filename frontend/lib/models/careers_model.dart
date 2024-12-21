class CareerModel {
  final String id;
  final String title;
  final String description;

  CareerModel({required this.id, required this.title, required this.description});

  factory CareerModel.fromJson(Map<String, dynamic> json) {
    return CareerModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
