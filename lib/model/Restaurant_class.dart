class Restaurants {
  String restaurantImage;
  String restaurantName;
  String locationUrl;
  String ownerId;
  String status;

  Restaurants(
      {this.restaurantImage,
        this.restaurantName,
        this.locationUrl,
        this.ownerId,
        this.status,});

  Restaurants.fromJson(Map<String, dynamic> json) {
    restaurantImage = json['restaurantImage'];
    locationUrl = json['locationUrl'];
    restaurantName = json['restaurantName'];
    ownerId = json['ownerId'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurantImage'] = this.restaurantImage;
    data['locationUrl'] = this.locationUrl;
    data['restaurantName'] = this.restaurantName;
    data['ownerId'] = this.ownerId;
    data['Status'] = this.status;
    return data;
  }
}