class GoalModel {
  int idGoal;
  String description;
  String startDate;
  String finalDate;
  int state;
  String url;

  GoalModel(
      {this.idGoal,
      this.startDate,
      this.finalDate,
      this.state,
      this.url,
      this.description});

  GoalModel.fromJson(Map<String, dynamic> json) {
    idGoal = json['idMeta'];
    startDate = json['startDate'];
    finalDate = json['finalDate'];
    state = json['state'];
    url = json['url'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdGoal'] = this.idGoal;
    data['StartDate'] = this.startDate;
    data['FinalDate'] = this.finalDate;
    data['state']  = this.state;  
    data['Url'] = this.url;
    return data;
  }
}
