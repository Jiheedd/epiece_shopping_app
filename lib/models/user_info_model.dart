class UserInfoModel {
  int? id;
  String fName;
  String email;
   String image;
  String phone;
  String? password;
   int orderCount;
  int? memberSinceDays;
  String? ville;

  UserInfoModel(
      { this.id,
        required this.fName,
        required this.email,
        this.image="",
        required this.phone,
         this.password,
        this.orderCount=0,
         this.memberSinceDays,
        this.ville});

 factory UserInfoModel.fromJson(Map<String, dynamic> json) {
      return UserInfoModel(
          id : json['id'],
          fName : json['f_name'],
          email : json['email'],
          image : json['image']??"img/logo part 1.png",
          phone : json['phone'],
          password : json['password']??"",
          orderCount : json['order_count'],
          memberSinceDays : json['member_since_days'],
          ville: "Tunis"
      );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['id'] = this.id;
    data['f_name'] = this.fName;
    data['email'] = this.email;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['order_count'] = this.orderCount;
    data['member_since_days'] = this.memberSinceDays;
    data['ville'] = this.ville;
    return data;
  }
}
