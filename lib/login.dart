import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Color(0xFF0648b3),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (await controller.canGoBack()) {
            controller.goBack();
            return false;
          }
          return true;
        },
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'https://logykinfotech.com/login.php',
          onWebViewCreated: (controller) {
            this.controller = controller;
          },
          onPageFinished: (String url) {
            controller
                .evaluateJavascript("javascript:(function() { " +
                    "var head = document.getElementsByTagName('header')[0];" +
                    "head.parentNode.removeChild(head);" +
                    "var footer = document.getElementsByTagName('footer')[0];" +
                    "footer.parentNode.removeChild(footer);" +
                    "})()")
                .then((value) => debugPrint('Page finished loading Javascript'))
                .catchError((onError) => debugPrint('$onError'));
          },
        ),
      ),
    );
  }
}
