import "package:flutter/material.dart";
import "package:frame/screens/general_error.dart";
import "package:frame/screens/no_internet.dart";
import "package:frame/search/search_provider.dart";

class ErrorPage extends StatelessWidget {
  final ErrorType errorType;

  const ErrorPage({super.key, required this.errorType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: errorType ==  ErrorType.noInternetError
          ? NoInternetScreen()
          : GeneralErrorScreen(),
    );
  }
}
