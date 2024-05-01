import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AppError {
  static init() {
    FlutterError.onError = (FlutterErrorDetails details) {
      print('Global Error Caught: ${details.exception}');
      print('Stack Trace:\n${details.stack}');
      if (details.exception is DioException) {
        runApp(NetworkErrorApp());
      } else {
        runApp(const ErrorApp());
      }
    };
  }
}

class NetworkErrorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Network Error'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Network connection error!'),
              ElevatedButton(
                onPressed: () {},
                child: Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('An unexpected error occurred.'),
        ),
      ),
    );
  }
}
