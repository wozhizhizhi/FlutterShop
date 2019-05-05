class CartInfo {
  String goodsId;
  String goodsName;
  int count;
  double price;
  String images;
  bool isCheck;

  CartInfo(
      {String goodsId, String goodsName, int count, double price, String images,this.isCheck}) {
    this.goodsId = goodsId;
    this.goodsName = goodsName;
    this.count = count;
    this.price = price;
    this.images = images;
    this.isCheck = isCheck;
  }

  CartInfo.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    count = json['count'];
    price = json['price'];
    images = json['images'];
    isCheck = json['isCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['count'] = this.count;
    data['price'] = this.price;
    data['images'] = this.images;
    data['isCheck'] = this.isCheck;
    return data;
  }
}