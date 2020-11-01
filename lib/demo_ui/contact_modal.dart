class UserContact {
  int id;
  String name;
  String imageUrl;

  UserContact({this.id, this.name, this.imageUrl});

 static createArrayUser() {
    List<UserContact> list = List<UserContact>();
    for (int i = 0; i < 5; i++) {
      list.add(UserContact(id: i, name: "Dat 0$i", imageUrl: "assets/images/send.png"));
    }
    return list;
  }
}
