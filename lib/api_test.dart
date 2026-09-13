import 'package:flutter/material.dart';

import 'core/network/api_client.dart';
import 'news/data/datasources/news_remote_data_source.dart';

class ApiTestScreen extends StatefulWidget {
  const ApiTestScreen({super.key});

  @override
  State<ApiTestScreen> createState() =>
      _ApiTestScreenState();
}

class _ApiTestScreenState
    extends State<ApiTestScreen> {
  String result = 'Testing...';

  @override
  void initState() {
    super.initState();
    testApi();
  }

  Future<void> testApi() async {
    try {
      final apiClient = ApiClient();

      final dataSource =
      NewsRemoteDataSource(apiClient);

      final articles =
      await dataSource.getArticles(
        page: 1,
        pageSize: 10,
      );

      setState(() {
        result =
        'Success!\nArticles: ${articles.length}\n\n'
            '${articles.isNotEmpty ? articles.first.title : 'No articles'}';
      });
    } catch (e) {
      setState(() {
        result = 'ERROR:\n$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Test'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(result),
        ),
      ),
    );
  }
}