import 'package:data_volley_match/core/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveScreen extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;
  final Widget tablet;
  const ResponsiveScreen({
    super.key,
    required this.mobile,
    required this.desktop,
    required this.tablet,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        switch (sizingInformation.deviceScreenType) {
          case DeviceScreenType.mobile:
            return mobile;
          case DeviceScreenType.desktop:
            return mobile;
          case DeviceScreenType.tablet:
            return mobile;
          default:
            return Scaffold(
              body: Center(
                child: Text(
                  MainStrings.undefinedSize,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            );
        }
      },
    );
  }
}
