class Birthday {
  DateTime birthday;
  DateTime currentDate;
  Birthday();

  Map<String, Object> toJson() {
    return {
      'birthday': birthday,
      'currentDate': currentDate,
    };
  }

  Birthday.fromJson(Map<String, dynamic> json) {
    this.birthday = json['birthday'].toDate();
    this.currentDate = json['currentDate'].toDate();
  }
}
