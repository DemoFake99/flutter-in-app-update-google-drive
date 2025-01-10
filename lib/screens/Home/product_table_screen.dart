import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_data_app/models/user_data_model.dart';
import 'package:user_data_app/providers/user_data_provider.dart';
import 'package:user_data_app/widgets/custom_text_form_field.dart';

class ProductTableScreen extends StatefulWidget {
  const ProductTableScreen({super.key});

  @override
  State<ProductTableScreen> createState() => _ProductTableScreenState();
}

class _ProductTableScreenState extends State<ProductTableScreen> {
  @override
  Widget build(BuildContext context) {
    final userDataList = Provider.of<UserDataProvider>(context).users;

    return userDataList.isEmpty
        ? const Center(
            child: Text(
              "There is no Todo",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          )
        : Consumer<UserDataProvider>(
            builder: (context, provider, child) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text("ID"),
                      ),
                      DataColumn(
                        label: Text("Name"),
                      ),
                      DataColumn(
                        label: Text("Email"),
                      ),
                      DataColumn(
                        label: Text("Type"),
                      ),
                    ],
                    rows: provider.users
                        .map(
                          (user) => DataRow(
                            cells: [
                              DataCell(
                                Text(user.id),
                              ),
                              DataCell(
                                Text(user.fullName),
                              ),
                              DataCell(
                                Text(user.email),
                              ),
                              DataCell(
                                Text(user.userType),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
            },
          );
  }
}
