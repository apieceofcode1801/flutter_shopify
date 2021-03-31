import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopify/base/config.dart';
import 'package:flutter_shopify/base/router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      baseURL,
    );

    final AuthLink authLink = AuthLink(
        getToken: () => accessToken,
        headerKey: "X-Shopify-Storefront-Access-Token");

    final Link link = authLink.concat(httpLink);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );

    final app = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APieceOfCode',
      theme: ThemeData(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                primary: Colors.white, backgroundColor: Colors.blue),
          ),
          accentColor: Colors.amberAccent,
          primaryColor: Colors.blue),
      onGenerateRoute: AppRouter.generateRoute,
    );
    return GraphQLProvider(
      client: client,
      child: app,
    );
  }
}
