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
      AuthUser authUser;
      if (!authUserSnapshot.hasData)
        return LoginScreen();
      else if ((authUser = authUserSnapshot.data).token != null) /* "Awaits" token fetching */ {
        ApiService service = Provider.of<ApiService>(context);
        service.token = authUser.token;

        return FetchUserDataBuilder(
          service: service,
          renderChild: HomeScreen(),
        );
      }
    }

    return Scaffold(
      body: Center(
          child: LoadingIndicator(type: LoadingType.loading, message: 'Loading user...')
      ),
    );
  }
}
