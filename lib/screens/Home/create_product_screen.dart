import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:user_data_app/core/utils.dart';
import 'package:user_data_app/providers/user_data_provider.dart';
import 'package:user_data_app/widgets/custom_text_form_field.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  Color selectedColor = Colors.blue;
  String selectedType = 'user';
  bool isObscure = true;
  bool light = true;
  File? selectedImage;
  final _formKey = GlobalKey<FormState>();

  List<String> valueList = [
    'admin',
    'user',
  ];

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  Widget passwordVisibility() {
    return IconButton(
      onPressed: () {
        setState(() {
          isObscure = !isObscure;
        });
      },
      icon: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Icon(
          isObscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Create Product.",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                selectedImage != null
                    ? const SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: ClipRRect(),
                )
                    : DottedBorder(
                        borderType: BorderType.RRect,
                        strokeCap: StrokeCap.round,
                        dashPattern: const [
                          10,
                          5,
                        ],
                        radius: const Radius.circular(16),
                        child: const SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.folder_open_rounded),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Add the products image",
                              ),
                            ],
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: nameController,
                  hintText: "Full name",
                  regExp: RegExp(r"\b([A-ZÀ-ÿ][-,a-z. ']+ *)+"),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: emailController,
                  hintText: "E-mail",
                  regExp: RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your Phone No.";
                          } else {
                            return RegExp(
                                        r'^(\+\d{1,2}\s?)?1?-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$')
                                    .hasMatch(value)
                                ? null
                                : "Enter a valid Phone No.";
                          }
                        },
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                          hintText: "Phone No",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: colorController,
                        maxLength: 6,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Select a color";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Favourite color",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        readOnly: true,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Pick a color"),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: selectedColor,
                                  onColorChanged: (color) {
                                    setState(() {
                                      selectedColor = color;
                                      colorController.text =
                                          myColorToHex(color).toString();
                                    });
                                  },
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Select"),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: dobController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Select you Date of birth";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "DOB",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                            initialDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              selectedDate = pickedDate;
                              dobController.text =
                                  "${pickedDate.toLocal()}".split(' ')[0];
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: DropdownButtonFormField<String>(
                          hint: const Text("Select"),
                          items: valueList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            }
                            return null;
                          },
                          onChanged: (String? value) {
                            setState(() {
                              selectedType = value!;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: "Password",
                  regExp: RegExp(r''),
                  isObscureText: isObscure,
                  suffixIcon: passwordVisibility(),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      //   Provider.of<UserDataProvider>(context, listen: false)
                      //       .registerUser(
                      //     nameController.text.trim(),
                      //     emailController.text.trim(),
                      //     phoneController.text.trim(),
                      //     dobController.text,
                      //     colorController.text,
                      //     passwordController.text.trim(),
                      //     selectedType.toString().trim(),
                      //   );
                      //   _formKey.currentState!.reset();
                      // }
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
