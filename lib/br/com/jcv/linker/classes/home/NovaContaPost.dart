class NovaContaPost {
  final String email;
  final String username;
  final String passwd;
  final String passwd2;
  final String cupom;
  final String msgcode;
  final String msgcodeString;

  NovaContaPost({this.email,this.username,this.passwd,this.passwd2,this.cupom, this.msgcode='', this.msgcodeString=''});

  factory NovaContaPost.fromJson(Map<String, dynamic> json) {
    return NovaContaPost(
      email: json['email'],
      username: json['apelido'],
      msgcode: json['msgcode'],
      msgcodeString: json['msgcodeString'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["email"] = email;
    map["username"] = username;
    map["passwd"] = passwd;
    map["passwd2"] = passwd2;
    map["id-cupom"] = cupom;
    return map;
  }

  @override
  String  toString(){
    return "{" +
        "email:" + email +
        ", username:" + username +
        ", passwd:" + passwd +
        ", passwd2:" + passwd2 +
        ", id-cupom:" + cupom +
    "}";
  }
}