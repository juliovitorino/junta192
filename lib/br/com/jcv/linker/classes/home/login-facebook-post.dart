class LoginFacebookPost {
  final String tokenid;
  final String nome;
  final String email;
  final String fotourl;
  final String versao;
  final Map<String, dynamic> sessaodto;
  final String msgcode;
  final String msgcodeString;

  LoginFacebookPost(this.tokenid,
    this.nome,
    this.email,
    this.fotourl,
    this.versao,{this.sessaodto,this.msgcode='',this.msgcodeString=''});

  factory LoginFacebookPost.fromJson(Map<String, dynamic> json) {
    return LoginFacebookPost(json['fcbkid'],
      json['nome'],
      json['email'],
      json['fotourl'],
      "-",
      sessaodto: json,
      msgcode: json['msgcode'],
      msgcodeString: json['msgcodeString'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["fcbkid"] = tokenid;
    map["nome"] = nome;
    map["email"] = email;
    map["fotourl"] = fotourl;
    map["versao"] = versao;
    return map;
  }
}