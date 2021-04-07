class Product {
  int id;
  String title;
  String img;
  String text;

  Product({this.id, this.title, this.img, this.text});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    img = json['img'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['img'] = this.img;
    data['text'] = this.text;
    return data;
  }
}