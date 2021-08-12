class HomeModel {
  late bool status;
  late HomeDataModel data;
  HomeModel.fromJason(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJason(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJason(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJason(element));
    });
    json['products'].forEach((element) {
      products.add(ProductModel.fromJason(element));
    });
  }
}

class BannerModel {
  late int id;
  late String image;
  BannerModel.fromJason(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  late String name;
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late bool inFavorites;
  late bool inCart;
  ProductModel.fromJason(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
