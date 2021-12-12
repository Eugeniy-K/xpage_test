// To parse this JSON data, do
//
//     final prodDetailModel = prodDetailModelFromJson(jsonString);

import 'dart:convert';

ProdDetailModel prodDetailModelFromJson(String str) =>
    ProdDetailModel.fromJson(json.decode(str));

String prodDetailModelToJson(ProdDetailModel data) =>
    json.encode(data.toJson());

class ProdDetailModel {
  ProdDetailModel({
    required this.calorie,
    required this.categories,
    required this.description,
    required this.id,
    required this.sectionId,
    required this.imagesList,
    required this.ingredientsForAdd,
    required this.ingredientsForDelete,
    required this.isOffer,
    required this.measure,
    required this.offers,
    required this.price,
    required this.relatedProducts,
    required this.title,
    required this.weight,
    required this.inCart,
    required this.inFavorites,
    required this.quantityInCart,
    required this.idInCart,
    required this.link,
  });

  int calorie;
  List<String> categories;
  String description;
  int id;
  int sectionId;
  List<ImagesList> imagesList;
  List<IngredientsForAdd> ingredientsForAdd;
  List<String> ingredientsForDelete;
  bool isOffer;
  String measure;
  List<Offer> offers;
  int price;
  List<RelatedProduct> relatedProducts;
  String title;
  int weight;
  bool inCart;
  bool inFavorites;
  int quantityInCart;
  dynamic idInCart;
  String link;

  ProdDetailModel copyWith({
    int? calorie,
    List<String>? categories,
    String? description,
    int? id,
    int? sectionId,
    List<ImagesList>? imagesList,
    List<IngredientsForAdd>? ingredientsForAdd,
    List<String>? ingredientsForDelete,
    bool? isOffer,
    String? measure,
    List<Offer>? offers,
    int? price,
    List<RelatedProduct>? relatedProducts,
    String? title,
    int? weight,
    bool? inCart,
    bool? inFavorites,
    int? quantityInCart,
    dynamic idInCart,
    String? link,
  }) =>
      ProdDetailModel(
        calorie: calorie ?? this.calorie,
        categories: categories ?? this.categories,
        description: description ?? this.description,
        id: id ?? this.id,
        sectionId: sectionId ?? this.sectionId,
        imagesList: imagesList ?? this.imagesList,
        ingredientsForAdd: ingredientsForAdd ?? this.ingredientsForAdd,
        ingredientsForDelete: ingredientsForDelete ?? this.ingredientsForDelete,
        isOffer: isOffer ?? this.isOffer,
        measure: measure ?? this.measure,
        offers: offers ?? this.offers,
        price: price ?? this.price,
        relatedProducts: relatedProducts ?? this.relatedProducts,
        title: title ?? this.title,
        weight: weight ?? this.weight,
        inCart: inCart ?? this.inCart,
        inFavorites: inFavorites ?? this.inFavorites,
        quantityInCart: quantityInCart ?? this.quantityInCart,
        idInCart: idInCart ?? this.idInCart,
        link: link ?? this.link,
      );

  factory ProdDetailModel.fromJson(Map<String, dynamic> json) =>
      ProdDetailModel(
        calorie: json["calorie"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        description: json["description"],
        id: json["id"],
        sectionId: json["section_id"],
        imagesList: List<ImagesList>.from(
            json["imagesList"].map((x) => ImagesList.fromJson(x))),
        ingredientsForAdd: List<IngredientsForAdd>.from(
            json["ingredientsForAdd"]
                .map((x) => IngredientsForAdd.fromJson(x))),
        ingredientsForDelete:
            List<String>.from(json["ingredientsForDelete"].map((x) => x)),
        isOffer: json["isOffer"],
        measure: json["measure"],
        offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
        price: json["price"],
        relatedProducts: List<RelatedProduct>.from(
            json["relatedProducts"].map((x) => RelatedProduct.fromJson(x))),
        title: json["title"],
        weight: json["weight"],
        inCart: json["inCart"],
        inFavorites: json["inFavorites"],
        quantityInCart: json["quantityInCart"],
        idInCart: json["idInCart"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "calorie": calorie,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "description": description,
        "id": id,
        "section_id": sectionId,
        "imagesList": List<dynamic>.from(imagesList.map((x) => x.toJson())),
        "ingredientsForAdd":
            List<dynamic>.from(ingredientsForAdd.map((x) => x.toJson())),
        "ingredientsForDelete":
            List<dynamic>.from(ingredientsForDelete.map((x) => x)),
        "isOffer": isOffer,
        "measure": measure,
        "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
        "price": price,
        "relatedProducts":
            List<dynamic>.from(relatedProducts.map((x) => x.toJson())),
        "title": title,
        "weight": weight,
        "inCart": inCart,
        "inFavorites": inFavorites,
        "quantityInCart": quantityInCart,
        "idInCart": idInCart,
        "link": link,
      };
}

class ImagesList {
  ImagesList({
    required this.big,
    required this.small,
  });

  String big;
  String small;

  ImagesList copyWith({
    String? big,
    String? small,
  }) =>
      ImagesList(
        big: big ?? this.big,
        small: small ?? this.small,
      );

  factory ImagesList.fromJson(Map<String, dynamic> json) => ImagesList(
        big: json["big"],
        small: json["small"],
      );

  Map<String, dynamic> toJson() => {
        "big": big,
        "small": small,
      };
}

class IngredientsForAdd {
  IngredientsForAdd({
    required this.id,
    required this.sectionId,
    required this.title,
    required this.categories,
    required this.measure,
    required this.price,
    required this.isOffer,
    required this.hasVariants,
    required this.inCart,
    required this.inFavorites,
    required this.quantityInCart,
    required this.idInCart,
    required this.picture,
    required this.calorie,
    required this.weight,
  });

  int id;
  int sectionId;
  String title;
  List<dynamic> categories;
  String measure;
  int price;
  bool isOffer;
  bool hasVariants;
  bool inCart;
  bool inFavorites;
  int quantityInCart;
  dynamic idInCart;
  String picture;
  int calorie;
  int weight;

  factory IngredientsForAdd.fromJson(Map<String, dynamic> json) =>
      IngredientsForAdd(
        id: json["id"],
        sectionId: json["section_id"],
        title: json["title"],
        categories: List<dynamic>.from(json["categories"].map((x) => x)),
        measure: json["measure"],
        price: json["price"],
        isOffer: json["isOffer"],
        hasVariants: json["hasVariants"],
        inCart: json["inCart"],
        inFavorites: json["inFavorites"],
        quantityInCart: json["quantityInCart"],
        idInCart: json["idInCart"],
        picture: json["picture"] ?? '',
        calorie: json["calorie"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "section_id": sectionId,
        "title": title,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "measure": measure,
        "price": price,
        "isOffer": isOffer,
        "hasVariants": hasVariants,
        "inCart": inCart,
        "inFavorites": inFavorites,
        "quantityInCart": quantityInCart,
        "idInCart": idInCart,
        "picture": picture == null ? null : picture,
        "calorie": calorie,
        "weight": weight,
      };
}

class Offer {
  Offer({
    required this.id,
    required this.name,
    required this.weight,
    required this.calorie,
    required this.price,
  });

  int id;
  String name;
  int weight;
  int calorie;
  int price;

  Offer copyWith({
    int? id,
    String? name,
    int? weight,
    int? calorie,
    int? price,
  }) =>
      Offer(
        id: id ?? this.id,
        name: name ?? this.name,
        weight: weight ?? this.weight,
        calorie: calorie ?? this.calorie,
        price: price ?? this.price,
      );

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        name: json["name"],
        weight: json["weight"],
        calorie: json["calorie"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "weight": weight,
        "calorie": calorie,
        "price": price,
      };
}

class RelatedProduct {
  RelatedProduct({
    required this.id,
    required this.sectionId,
    required this.title,
    required this.categories,
    required this.measure,
    required this.price,
    required this.isOffer,
    required this.hasVariants,
    required this.inCart,
    required this.inFavorites,
    required this.quantityInCart,
    required this.idInCart,
    required this.picture,
    required this.calorie,
    required this.weight,
  });

  int id;
  int sectionId;
  String title;
  List<dynamic> categories;
  String measure;
  int price;
  bool isOffer;
  bool hasVariants;
  bool inCart;
  bool inFavorites;
  int quantityInCart;
  dynamic idInCart;
  ImagesList picture;
  int calorie;
  int weight;

  RelatedProduct copyWith({
    int? id,
    int? sectionId,
    String? title,
    List<dynamic>? categories,
    String? measure,
    int? price,
    bool? isOffer,
    bool? hasVariants,
    bool? inCart,
    bool? inFavorites,
    int? quantityInCart,
    dynamic idInCart,
    ImagesList? picture,
    int? calorie,
    int? weight,
  }) =>
      RelatedProduct(
        id: id ?? this.id,
        sectionId: sectionId ?? this.sectionId,
        title: title ?? this.title,
        categories: categories ?? this.categories,
        measure: measure ?? this.measure,
        price: price ?? this.price,
        isOffer: isOffer ?? this.isOffer,
        hasVariants: hasVariants ?? this.hasVariants,
        inCart: inCart ?? this.inCart,
        inFavorites: inFavorites ?? this.inFavorites,
        quantityInCart: quantityInCart ?? this.quantityInCart,
        idInCart: idInCart ?? this.idInCart,
        picture: picture ?? this.picture,
        calorie: calorie ?? this.calorie,
        weight: weight ?? this.weight,
      );

  factory RelatedProduct.fromJson(Map<String, dynamic> json) => RelatedProduct(
        id: json["id"],
        sectionId: json["section_id"],
        title: json["title"],
        categories: List<dynamic>.from(json["categories"].map((x) => x)),
        measure: json["measure"],
        price: json["price"],
        isOffer: json["isOffer"],
        hasVariants: json["hasVariants"],
        inCart: json["inCart"],
        inFavorites: json["inFavorites"],
        quantityInCart: json["quantityInCart"],
        idInCart: json["idInCart"],
        picture: ImagesList.fromJson(json["picture"]),
        calorie: json["calorie"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "section_id": sectionId,
        "title": title,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "measure": measure,
        "price": price,
        "isOffer": isOffer,
        "hasVariants": hasVariants,
        "inCart": inCart,
        "inFavorites": inFavorites,
        "quantityInCart": quantityInCart,
        "idInCart": idInCart,
        "picture": picture.toJson(),
        "calorie": calorie,
        "weight": weight,
      };
}
