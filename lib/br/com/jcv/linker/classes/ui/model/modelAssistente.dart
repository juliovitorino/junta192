///
/// AssistenteModel - Modelo para assistente de ajuda
/// 
class AssistenteModel {
  bool islocal;
  String urlimg;
  String titulo;
  String descricao;

  AssistenteModel(this.urlimg, this.titulo, this.descricao, {this.islocal=true});

}