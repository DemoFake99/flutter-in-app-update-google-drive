import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

String myColorToHex(Color color) {
  return '${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
}

Color myHexToColor(String hex) {
  return Color(
    int.parse(hex, radix: 16) + 0xFF000000,
  );
}

Future<File?> pickImage() async {
  try {
    final filePickerRes = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (filePickerRes != null) {
      return File(filePickerRes.files.first.xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}

class CommonUtils {
  Future<void> checkForUpdates(BuildContext context) async {
    final response = await http.get(
      Uri.parse(
        'https://drive.google.com/uc?id=1Kdzkk5IOfFwsGOQ8bty-BZT-MUF0CNVt&export=download',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final String latestVersion = data['version'];
      final downloadUrl = data['url'];

      // Compare with current version
      const currentVersion = "1.0.2";
      // if (latestVersion != currentVersion) {
      //   _promptUpdate(context, downloadUrl);
      // }
      if (latestVersion.contains(currentVersion)) {
        if (context.mounted) {
          _promptUpToDate(context);
        }
      } else {
        if (context.mounted) {
          _promptUpdate(context, downloadUrl);
        }
      }
    }
  }

  void _promptUpdate(BuildContext context, String downloadUrl) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Update Available"),
        content: const Text("A new version of the app is available."),
        actions: [
          TextButton(
            onPressed: () {
              _downloadUpdate(downloadUrl);
            },
            child: const Text("Update Now"),
          ),
        ],
      ),
    );
  }

  void _promptUpToDate(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("No Updates"),
        content: const Text("Your app is up to date."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void _downloadUpdate(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print("Could not launch $url");
    }
  }
}
