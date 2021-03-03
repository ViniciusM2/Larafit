class GoalModel {
  int idGoal;
  String startDate;
  String finalDate;
  int state;
  int idHabito;
  String url;

  GoalModel(
      {this.idGoal,
      this.startDate,
      this.finalDate,
      this.idHabito,
      this.state,
      this.url});

  GoalModel.fromJson(Map<String, dynamic> json) {
    idGoal = json['IdGoal'];
    startDate = json['StartDate'];
    finalDate = json['FinalDate'];
    idHabito = json['idHabito'];
    state = json['State'];
    url = json['Url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdGoal'] = this.idGoal;
    data['StartDate'] = this.startDate;
    data['FinalDate'] = this.finalDate;
    data['idHabito'] = this.idHabito;
    data['state']  = this.state;  
    data['Url'] = this.url;
    return data;
  }
}
