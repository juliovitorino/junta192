
import 'package:junta192/br/com/jcv/linker/classes/storages/global_startup.dart';

/// 
/// URLs utilizadas no projeto 
/// 
/// Todas constantes de URL utilizadas pelo projeto deverão ser colocada neste arquivo
/// de uso global pela aplicação.
/// 
/// Changelog:
/// 
/// @since 1.0.0
/// @author Julio Cesar Vitorino, 23/09/2019
/// 

//final String urlUploadImagemCampanha = "http://elitefinanceira.com/cfdi/php/classes/upload/uploadImagemCampanha.php";
//final String urlUploadImagemUsuarioPublicidade = "http://elitefinanceira.com/cfdi/php/classes/upload/uploadImagemUsuarioPublicidade.php";
final String urlUploadImagemCampanha = GlobalStartup().getUpload() + "/uploadImagemCampanha.php";
final String urlUploadImagemUsuarioPublicidade = GlobalStartup().getUpload() + "/uploadImagemUsuarioPublicidade.php";
