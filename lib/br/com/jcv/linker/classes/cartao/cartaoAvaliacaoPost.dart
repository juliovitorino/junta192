class CartaoAvaliacaoPost {
  final String tokenid;
  final String hash;
  final String rating;
  final String comentario;
  final String msgcode;
  final String msgcodeString;
 
  CartaoAvaliacaoPost({this.tokenid, this.hash, this.rating, this.comentario, this.msgcode='', this.msgcodeString=''});
 
  factory CartaoAvaliacaoPost.fromJson(Map<String, dynamic> json) {
    return CartaoAvaliacaoPost(
      tokenid: json['tokenid'],
      hash: json['hash'],
      rating: json['rating'],
      comentario: json['comentario'],
      msgcode: json['msgcode'],
      msgcodeString: json['msgcodeString'],
    );
  }
 
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["tokenid"] = tokenid;
    map["hash"] = hash;
    map["rating"] = rating;
    map["comentario"] = comentario;
 
    return map;
  }
}