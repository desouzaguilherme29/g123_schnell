import 'package:url_launcher/url_launcher.dart';


fazerLigacao(String telefone) async {
  var url = "tel:" + telefone;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}