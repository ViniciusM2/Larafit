class UserModel {
  int idUser;
  String nameUser;
  String bornDate;
  String sex;
  double weight;
  double height;

  UserModel(
      {this.idUser,
      this.nameUser,
      this.bornDate,
      this.sex,
      this.weight,
      this.height});

  UserModel.fromJson(Map<String, dynamic> json) {
    idUser = json['IdUser'];
    nameUser = json['NameUser'];
    bornDate = json['BornDate'];
    sex = json['Sex'];
    weight = json['Weight'];
    height = json['Height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdUser'] = this.idUser;
    data['NameUser'] = this.nameUser;
    data['BornDate'] = this.bornDate;
    data['Sex'] = this.sex;
    data['Weight'] = this.weight;
    data['Height'] = this.height;
    return data;
  }
}
