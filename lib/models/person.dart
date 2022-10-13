class Person {
  String? uid;
  String? name;
  String? email;
  String? username;
  String? profilePhoto;

  Person({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.profilePhoto,
  });

  Map toMap(Person person) {
    var data = <String, dynamic>{};
    data['uid'] = person.uid;
    data['name'] = person.name;
    data['email'] = person.email;
    data['username'] = person.username;
    data["profilePhoto"] = person.profilePhoto;
    return data;
  }

  Person.fromMap(Map<String, dynamic> mapData) {
    uid = mapData['uid'];
    name = mapData['name'];
    email = mapData['email'];
    username = mapData['username'];
    profilePhoto = mapData['profilePhoto'];
  }
}
