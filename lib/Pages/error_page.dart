import "package:flutter/material.dart";
import "package:frame/Pages/general_error.dart";
import "package:frame/Pages/no_internet.dart";
import "package:frame/search/search_provider.dart";

class ErrorPage extends StatelessWidget {
  final ErrorType errorType;
  final String? error;
  const ErrorPage({super.key, required this.errorType, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: errorType == ErrorType.noInternetError
          ? NoInternetScreen()
          : GeneralErrorScreen(errorMesage: error ?? "Error"),
    );
  }
}
