class MyFeedback {
  String? id;
  String? title;
  String? text;
  String? user;
  String? createdAt;
  double? starNumber;
  String? product;
  // List<Null>? feedbackImage;

  MyFeedback(
      {this.id,
        this.title = ' ',
        this.text = ' ',
        this.user,
        this.createdAt,
        this.starNumber = 5,
        this.product,
        // this.feedbackImage
      });

  MyFeedback.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    text = json['text'];
    user = json['user'];
    createdAt = json['created_at'];
    starNumber = json['star_number'];
    product = json['product'];
    // if (json['feedback_image'] != null) {
    //   feedbackImage = <Null>[];
    //   json['feedback_image'].forEach((v) {
    //     feedbackImage!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['text'] = this.text;
    data['user'] = this.user;
    data['created_at'] = this.createdAt;
    data['star_number'] = this.starNumber;
    data['product'] = this.product;
    // if (this.feedbackImage != null) {
    //   data['feedback_image'] =
    //       this.feedbackImage!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
