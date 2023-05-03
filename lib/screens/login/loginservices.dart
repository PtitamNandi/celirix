import 'package:url_launcher/url_launcher.dart';

class OpenURL {
  //  launchURLApp(url) async {
  //   if (await canLaunchUrl(
  //     uri,
  //   )) {
  //     await launchUrl(
  //       uri,
  //     );
  //   } else {
  //     throw 'Could not launch $uri';
  //   }
  // }
  Future<void> launchURLApp(_url) async {
    var uri = Uri.parse(_url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }
}
