import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// 
/// Upload Genérico de Arquivos
/// 
/// Changelog:
/// 
/// @since 1.0.0
/// @author Julio Cesar Vitorino, 23/09/2019
/// 
class UploadImage {

  String id;
  String token;
  String urlUploadEndPoint;
  File file;
  String status = '';
  String base64Image;
  String fileName;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  String err403Msg = 'Permissão negada pelo servidor. Não foi possível executar esta operação.';

  UploadImage(this.id, this.file, this.token, this.urlUploadEndPoint){
    this.base64Image = base64Encode(this.file.readAsBytesSync());
    this.tmpFile = this.file;
    startUpload();
  }

  startUpload() {
    if (tmpFile == null) {
      return;
    }
    fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  setStatus(String msg){
    status = msg;
  }

  String getFileName() {
    return fileName;
  }

  String getStatus(){
    return status;
  }

  upload(String fileName) {
    http.post(Uri.parse(urlUploadEndPoint), body: {
      "tokenid": token,
      "image": base64Image,
      "name": fileName,
      "id": id
    }).then((result) {
      switch (result.statusCode) {
        case 200:
          setStatus(result.body);
          break;

        case 403:
          setStatus(err403Msg);
          break;
          
        default:
          setStatus(errMessage);
      }
    }).catchError((error) {
      setStatus(error);
    });
  }


}