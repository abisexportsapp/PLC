// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plc_project/Components/Appbars.dart';
import 'package:plc_project/Components/Switches.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:theme_provider/theme_provider.dart';

class AppPermissions extends StatefulWidget {
  const AppPermissions({super.key});

  @override
  State<AppPermissions> createState() => _AppPermissionsState();
}

class _AppPermissionsState extends State<AppPermissions> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarColor: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .appBarBackgroundColor),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .appBarBackgroundColor,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SAPSliverAppBar(title: "App Permissions"),
              ];
            },
            body: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PermissionStatusWidget(
                    title: 'Location',
                    subtitle: 'Status of Location permission',
                    typeOfPermission: Permission.location,
                  ),
                  PermissionStatusWidget(
                    title: 'Camera',
                    subtitle: 'Status of Camera permission',
                    typeOfPermission: Permission.camera,
                  ),
                  PermissionStatusWidget(
                    title: 'Microphone',
                    subtitle: 'Status of Microphone permission',
                    typeOfPermission: Permission.microphone,
                  ),
                  PermissionStatusWidget(
                    title: 'Bluetooth',
                    subtitle: 'Status of Bluetooth permission',
                    typeOfPermission: Permission.bluetooth,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PermissionStatusWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final Permission typeOfPermission;

  const PermissionStatusWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.typeOfPermission,
  });

  @override
  _PermissionStatusWidgetState createState() => _PermissionStatusWidgetState();
}

class _PermissionStatusWidgetState extends State<PermissionStatusWidget> {
  bool isBluetoothPermissionGranted = false;
  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkBluetoothPermissionStatus();
    _checkPermissionStatus();
  }

  Future<void> _checkPermissionStatus() async {
    PermissionStatus status = await widget.typeOfPermission.status;
    setState(() {
      isEnabled = status.isGranted;
    });
  }

  Future<void> _checkBluetoothPermissionStatus() async {
    PermissionStatus bluetoothStatus = await Permission.bluetooth.status;
    PermissionStatus bluetoothScanStatus =
        await Permission.bluetoothScan.status;
    PermissionStatus bluetoothConnectStatus =
        await Permission.bluetoothConnect.status;
    PermissionStatus bluetoothAdvertiseStatus =
        await Permission.bluetoothAdvertise.status;
    setState(() {
      isBluetoothPermissionGranted = bluetoothStatus.isGranted &&
          bluetoothScanStatus.isGranted &&
          bluetoothConnectStatus.isGranted &&
          bluetoothAdvertiseStatus.isGranted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SAPSwitch(
      onChanged: (bool? value) {
        if (widget.typeOfPermission == Permission.bluetooth) {
          _requestBluetoothPermissions();
        } else {
          _requestPermission();
        }
      },
      value: widget.typeOfPermission == Permission.bluetooth
          ? isBluetoothPermissionGranted
          : isEnabled,
      title: widget.title,
      subtitle: widget.subtitle,
    );
  }

  Future<void> _requestPermission() async {
    PermissionStatus currentStatus = await widget.typeOfPermission.status;

    if (!currentStatus.isGranted) {
      PermissionStatus status = await widget.typeOfPermission.request();

      setState(() {
        isEnabled = status.isGranted;
      });
    }
  }

  Future<void> _requestBluetoothPermissions() async {
    Map<Permission, PermissionStatus> currentStatuses = {
      Permission.bluetooth: await Permission.bluetooth.status,
      Permission.bluetoothScan: await Permission.bluetoothScan.status,
      Permission.bluetoothConnect: await Permission.bluetoothConnect.status,
      Permission.bluetoothAdvertise: await Permission.bluetoothAdvertise.status,
    };

    bool shouldRequestPermission = currentStatuses.values.any(
      (status) => status != PermissionStatus.granted,
    );

    if (shouldRequestPermission) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetooth,
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.bluetoothAdvertise,
      ].request();

      bool allPermissionsGranted = statuses.values.every(
        (status) => status == PermissionStatus.granted,
      );

      setState(() {
        isBluetoothPermissionGranted = allPermissionsGranted;
      });
    }
  }
}
