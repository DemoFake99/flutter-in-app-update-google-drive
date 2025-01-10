import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:user_data_app/core/utils.dart';
import 'package:user_data_app/screens/Home/create_product_screen.dart';
import 'package:user_data_app/screens/Home/create_user_screen.dart';

import 'package:user_data_app/screens/Home/product_table_screen.dart';
import 'package:user_data_app/screens/Home/user_table_screen.dart';

import 'Home/home_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    // const HomeScreen(),
    const UserTableScreen(),
    const ProductTableScreen(),
  ];

  final List<String> _appBar = [
    // "Home",
    "Users List",
    "Products List",
  ];
  @override
  void initState() {
    super.initState();
    CommonUtils().checkForUpdates(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(_appBar[_currentIndex]),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.home_filled,
          //   ),
          //   label: "Home",
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.playlist_add,
            ),
            label: "User List",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_rounded,
            ),
            label: "Product List",
          ),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        onOpen: () {
          debugPrint('onOpen');
        },
        afterOpen: () {
          debugPrint('afterOpen');
        },
        onClose: () {
          debugPrint('onClose');
        },
        afterClose: () {
          debugPrint('afterClose');
        },
        children: [
          FloatingActionButton(
            heroTag: 'Create User',
            child: const Icon(
              Icons.person_add_alt_rounded,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateUserScreen(),
                ),
              );
            },
          ),
          FloatingActionButton(
            heroTag: 'Create Product',
            child: const Icon(
              Icons.add_shopping_cart_rounded,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateProductScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
