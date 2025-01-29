class IceCreamData {
  IceCreamData({this.icecreams});

  IceCreamData.fromJson(Map<String, dynamic> json) {
    if (json['icecreams'] != null) {
      icecreams = <Icecreams>[];
      for (final v in json['icecreams'] as List<dynamic>) {
        icecreams!.add(Icecreams.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  List<Icecreams>? icecreams;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (icecreams != null) {
      data['icecreams'] = icecreams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Icecreams {
  Icecreams({
    required this.id,
    required this.flavour,
    required this.category,
    required this.isFeatured,
    required this.description,
    required this.price,
    required this.image,
    required this.inStock,
    required this.ingredients,
    required this.topping,
  });

  Icecreams.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        flavour = json['flavour'] as String,
        category = json['category'] as String,
        isFeatured = json['isFeatured'] as bool,
        description = json['description'] as String,
        price = json['price'] as double,
        image = json['image'] as String,
        inStock = json['inStock'] as bool,
        ingredients = (json['ingredients'] as List<dynamic>?)
            ?.map((e) => Ingredients.fromJson(e as Map<String, dynamic>))
            .toList(),
        topping = (json['topping'] as List<dynamic>?)?.cast<String>();

  final int id;
  final String flavour;
  final String category;
  final bool isFeatured;
  final String description;
  final double price;
  final String image;
  final bool inStock;
  final List<Ingredients>? ingredients;
  final List<String>? topping;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'flavour': flavour,
      'category': category,
      'isFeatured': isFeatured,
      'description': description,
      'price': price,
      'image': image,
      'inStock': inStock,
      'ingredients': ingredients?.map((e) => e.toJson()).toList(),
      'topping': topping,
    };
  }

  @override
  String toString() {
    return 'Name = $flavour, Price = $price';
  }
}

class Ingredients {
  Ingredients({required this.name, required this.quantity});

  Ingredients.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        quantity = json['quantity'] as String;

  final String name;
  final String quantity;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }
}
