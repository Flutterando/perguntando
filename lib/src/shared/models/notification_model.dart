class NotificationModel {
  String id;
  String title;
  String subtitle;
  DateTime datetime;

  NotificationModel({this.title, this.subtitle, this.datetime,this.id});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    datetime = DateTime.parse(json['datetime']);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['datetime'] = this.datetime.toString();
    data['id'] = this.id;
    return data;
  }
  
bool operator ==(o) => o is NotificationModel && o.id == id;
int get hashCode => id.hashCode;
}



