import 'package:hive/hive.dart';
part 'fakedatamodel.g.dart';

@HiveType(typeId: 0)
class FakeModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  double? price;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? category;
  @HiveField(5)
  String? image;
  @HiveField(6)
  Rating? rating;

  FakeModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory FakeModel.fromJson(Map<String, dynamic> json) {
    return FakeModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['category'] = category;
    data['image'] = image;
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 1)
class Rating extends HiveObject {
  @HiveField(0)
  double? rate;
  @HiveField(1)
  int? count;

  Rating({this.rate, this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate'] = rate;
    data['count'] = count;
    return data;
  }
}

@HiveType(typeId: 2)
class CartItem extends HiveObject {
  @HiveField(0)
  FakeModel fakeModel;
  @HiveField(1)
  int quantity;

  CartItem(this.fakeModel, this.quantity);
}
