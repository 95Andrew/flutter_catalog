class PostReviewProductBody {
  int rate;
  String text;

  PostReviewProductBody({this.rate, this.text});

  PostReviewProductBody.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['text'] = this.text;
    return data;
  }
}


class BodyPostReview {
  int id;
  int product;
  int rate;
  String text;
  CreatedBy createdBy;
  String createdAt;

  BodyPostReview(
      {this.id,
      this.product,
      this.rate,
      this.text,
      this.createdBy,
      this.createdAt});

  BodyPostReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
    rate = json['rate'];
    text = json['text'];
    createdBy = json['created_by'] != null
        ? new CreatedBy.fromJson(json['created_by'])
        : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product'] = this.product;
    data['rate'] = this.rate;
    data['text'] = this.text;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class CreatedBy {
  int id;
  String username;
  String firstName;
  String lastName;
  String email;

  CreatedBy(
      {this.id, this.username, this.firstName, this.lastName, this.email});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    return data;
  }
}
