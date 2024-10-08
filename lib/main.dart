
import 'package:ecommerce_mobile_app/Provider/add_to_cart_provider.dart';
import 'package:ecommerce_mobile_app/Provider/favorite_provider.dart';
import 'package:ecommerce_mobile_app/view_model/category_view_model.dart';
import 'package:ecommerce_mobile_app/view_model/home_view_model.dart';
// import 'package:ecommerce_mobile_app/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/nav_bar_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Your authentication token
    const String token =  'eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImFkZHJlc3MiOiJQaG5vbSBQZW5oLCBDYW1ib2RpYSIsInJvbGVJZCI6MSwiaXNzIjoiQ1NUQUQtU1RPUkUiLCJiaW8iOiJzdHVkZW50IiwiYXZhdGFyIjoiaHR0cHM6Ly9zYjcucGVuZ3VpbS5vcmcvZmlsZS9kYjNlMTBlZi04OGYwLTRkMDQtOGEwNy0zZGQ3YmYyMWM4ZDQuanBnIiwicGhvbmUiOiIwOTk3NzE2MTYiLCJzY29wZSI6InJvbGU6cGF0Y2ggcHJvZHVjdDp1cGRhdGUgdXNlcjpkZWxldGUgcm9sZTp1cGRhdGUgcHJvZHVjdDp3cml0ZSB1c2VyOnBhdGNoIHJvbGU6cmVhZCB1c2VyOnByb2ZpbGUgdXNlcjp1cGRhdGUgcHJvZHVjdDpkZWxldGUgcm9sZTp3cml0ZSBwcm9kdWN0OnJlYWQgdXNlcjpyZWFkIHVzZXI6d3JpdGUgcHJvZHVjdDpwYXRjaCByb2xlOmRlbGV0ZSIsIm5hbWUiOiJQaXNldGggU2F0dHlhIiwicm9sZU5hbWUiOiJBRE1JTiIsImlkIjoxLCJleHAiOjE3Mjg4NTg3ODEsImlhdCI6MTcyODI1Mzk4MSwianRpIjoiMSIsImVtYWlsIjoicGlzZXRoc2F0dHlhMzNAZ21haWwuY29tIiwidXNlcm5hbWUiOiJhZG1pbiIsInN0YXR1cyI6dHJ1ZX0.F1QpvBWOD-AbS6dUDydW2Z2pUp8mHqsR27oF5GUb_CxrXhwJQ5g4EdJIg96ugA3N0LUuX0-RSR81gG8NoXsNkYazG_LRSfcYKYlEaOnEsHooV6_rnAaGx__pLrD8bpWqU_e07UHJw1evjgkVuyGf903sBkuBbWej0UDWbV2iy5joRQ5CfBADfysJ6OsGA6zRITGEVOT1DTIvUNmsyF1yoFw894zGumMuyFpY1g5adtXzlP03RIhMsEUHOgmS31X5HLa1aHOIqY0654yCy5clThHVkITkhBjngXgkCUlMeBDKBAy2LT_8tl2WJm3KLIDLvPaLJLCrouvioc4KWwXUvQ';
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(
          create: (_) => CategoryViewModel(token: token),
        ),
        ChangeNotifierProvider(create: (_) => ProductViewModel(token: token)..fetchProducts())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.mulishTextTheme(),
        ),
        home: const BottomNavBar(token: token),
      ),
    );
  }
}

