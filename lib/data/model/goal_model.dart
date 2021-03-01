class GoalModel {
  int idGoal;
  String activeTimeGoal;
  double distanceGoal;
  String startDate;
  String finalDate;
  int idHabito;

  GoalModel(
      {this.idGoal,
      this.activeTimeGoal,
      this.distanceGoal,
      this.startDate,
      this.finalDate,
      this.idHabito});

  GoalModel.fromJson(Map<String, dynamic> json) {
    idGoal = json['IdGoal'];
    activeTimeGoal = json['ActiveTimeGoal'];
    distanceGoal = json['DistanceGoal'];
    startDate = json['StartDate'];
    finalDate = json['FinalDate'];
    idHabito = json['idHabito'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdGoal'] = this.idGoal;
    data['ActiveTimeGoal'] = this.activeTimeGoal;
    data['DistanceGoal'] = this.distanceGoal;
    data['StartDate'] = this.startDate;
    data['FinalDate'] = this.finalDate;
    data['idHabito'] = this.idHabito;
    return data;
  }
}
