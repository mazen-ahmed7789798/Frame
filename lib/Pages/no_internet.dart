import 'package:flutter/material.dart';
import 'package:frame/widgets/loading_dots.dart';

class NoInternetScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 104,
              height: 104,
              child: Image.asset(r"images/Rectangle 4.png"),
            ),
            SizedBox(height: 24),
            Text(
              "No Internet Connection",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
            ),
            SizedBox(height: 8),
            Text(
              "we’re trying to reconnect..",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            LoadingDots(),
            SizedBox(height: 20),

            ElevatedButton(onPressed: () {}, child: Text("Retry")),
          ],
        ),
      ),
    );
  }
}
