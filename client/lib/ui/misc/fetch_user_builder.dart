import 'package:Tempo/models/user.dart';
import 'package:Tempo/services/api/api.dart';
import 'package:Tempo/ui/pages/main_content.dart';
import 'package:Tempo/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FetchUserDataBuilder extends StatefulWidget {
  final ApiService service;
  final Widget renderChild;

  FetchUserDataBuilder({@required this.service, @required this.renderChild});

  @override
  _FetchUserDataBuilderState createState() => _FetchUserDataBuilderState();
}

class _FetchUserDataBuilderState extends State<FetchUserDataBuilder> {
  Future<Map<String, dynamic>> loadUserData;

  @override
  void initState() {
    loadUserData = widget.service.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: loadUserData,
      builder: (context, snapshot) {
        LoadingIndicator child = LoadingIndicator(type: LoadingType.loading, message: 'Loading user data...');

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            Provider.of<User>(context, listen: false).loadFromJSON(snapshot.data);
            return HomeScreen();
          } else if (snapshot.hasError || snapshot.data == null) {
            child = LoadingIndicator(
              type: LoadingType.error,
              message: 'Failed to fetch user data.',
              onRetry: () => setState(() {
                loadUserData = Provider.of<ApiService>(context, listen: false).fetchData();
              }),
            );
          }
        }

        return Scaffold(
          body: Center(child: child),
        );
      },
    );
  }
}
