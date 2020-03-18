import 'package:Tempo/models/auth_user.dart';
import 'package:Tempo/services/api/api.dart';
import 'package:Tempo/ui/misc/fetch_user_builder.dart';
import 'package:Tempo/ui/pages/login.dart';
import 'package:Tempo/ui/pages/main_content.dart';
import 'package:Tempo/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatelessWidget {
  final AsyncSnapshot<AuthUser> authUserSnapshot;

  AuthenticationScreen({@required this.authUserSnapshot});

  @override
  Widget build(BuildContext context) {
    if (authUserSnapshot.connectionState == ConnectionState.active) {
      if (!authUserSnapshot.hasData) return LoginScreen();

      // Awaiting token from AuthUser
      return FutureBuilder<String>(
        future: authUserSnapshot.data.token,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Scaffold(body: LoadingIndicator());

          ApiService service = Provider.of<ApiService>(context);
          service.token = snapshot.data;

          return FetchUserDataBuilder(
            service: service,
            renderChild: HomeScreen(),
          );
        },
      );
    }

    return Scaffold(
      body: Center(
          child: LoadingIndicator(type: LoadingType.loading, message: 'Loading user...')
      ),
    );
  }
}
