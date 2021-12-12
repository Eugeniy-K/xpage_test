import 'dart:ui';

import 'package:flutter/cupertino.dart'
    show
        CupertinoDynamicColor,
        CupertinoTheme,
        CupertinoThemeData,
        showCupertinoDialog,
        showCupertinoModalPopup;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    show Theme, ThemeData, Colors, showDialog, showModalBottomSheet;
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'platform_provider.dart';
// import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

const Color _kModalBarrierColor = CupertinoDynamicColor.withBrightness(
  color: Color(0x33000000),
  darkColor: Color(0x7A000000),
);

/// Extends on [TargetPlatform] to include web
enum PlatformTarget { android, fuchsia, iOS, linux, macOS, windows, web }

PlatformStyle _platformStyle(BuildContext context) {
  final platform = PlatformProvider.of(context)?.platform;

  final platformStyle = PlatformProvider.of(context)?.settings.platformStyle;

  if (platform == null && kIsWeb) {
    return platformStyle?.web ?? PlatformStyle.Material;
  }

  switch (platform ?? Theme.of(context).platform) {
    case TargetPlatform.android:
      return platformStyle?.android ?? PlatformStyle.Material;
    case TargetPlatform.fuchsia:
      return platformStyle?.fuchsia ?? PlatformStyle.Material;
    case TargetPlatform.iOS:
      return platformStyle?.ios ?? PlatformStyle.Cupertino;
    case TargetPlatform.linux:
      return platformStyle?.linux ?? PlatformStyle.Material;
    case TargetPlatform.macOS:
      return platformStyle?.macos ?? PlatformStyle.Cupertino;
    case TargetPlatform.windows:
      return platformStyle?.windows ?? PlatformStyle.Material;
  }
}

bool isMaterial(BuildContext context) {
  return _platformStyle(context) == PlatformStyle.Material;
}

bool isCupertino(BuildContext context) {
  return _platformStyle(context) == PlatformStyle.Cupertino;
}

T platformThemeData<T>(
  BuildContext context, {
  required T Function(ThemeData theme) material,
  required T Function(CupertinoThemeData theme) cupertino,
}) {
  return isMaterial(context)
      ? material(Theme.of(context))
      : cupertino(CupertinoTheme.of(context));
}

PlatformTarget platform(BuildContext context) {
  if (kIsWeb) {
    return PlatformTarget.web;
  }

  switch (Theme.of(context).platform) {
    case TargetPlatform.android:
      return PlatformTarget.android;
    case TargetPlatform.fuchsia:
      return PlatformTarget.fuchsia;
    case TargetPlatform.iOS:
      return PlatformTarget.iOS;
    case TargetPlatform.linux:
      return PlatformTarget.linux;
    case TargetPlatform.macOS:
      return PlatformTarget.macOS;
    case TargetPlatform.windows:
      return PlatformTarget.windows;
  }
}

Future<T?> showPlatformDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool? barrierDismissible,
  RouteSettings? routeSettings,
  bool useRootNavigator = true,
  bool materialUseSafeArea = true,
  Color? materialBarrierColor = Colors.black54,
  String? barrierLabel,
}) {
  if (isMaterial(context)) {
    return showDialog<T>(
      context: context,
      builder: builder,
      barrierDismissible: barrierDismissible ?? true,
      routeSettings: routeSettings,
      useRootNavigator: useRootNavigator,
      useSafeArea: materialUseSafeArea,
      //child: , deprecated
      barrierColor: materialBarrierColor,
      barrierLabel: barrierLabel,
    );
  } else {
    return showCupertinoDialog<T>(
      context: context,
      builder: builder,
      routeSettings: routeSettings,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible ?? false,
      barrierLabel: barrierLabel,
    );
  }
}

class MaterialModalSheetData {
  final Color? backgroundColor;
  final double? elevation;
  final ShapeBorder? shape;
  final bool isScrollControlled;
  final bool useRootNavigator;
  final Clip? clipBehavior;
  final Color? barrierColor;
  final bool enableDrag;
  final bool isDismissible;
  final RouteSettings? routeSettings;
  AnimationController? transitionAnimationController;

  MaterialModalSheetData({
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.isScrollControlled = false,
    this.useRootNavigator = false,
    this.clipBehavior,
    this.barrierColor,
    this.enableDrag = false,
    this.isDismissible = false,
    this.routeSettings,
    this.transitionAnimationController,
  });
}

class CupertinoModalSheetData {
  // final ImageFilter? imageFilter;
  // final bool? semanticsDismissible;
  final bool useRootNavigator;
  final Color barrierColor;
  final bool barrierDismissible;
  final RouteSettings? routeSettings;
  final Color? backgroundColor;
  final double? elevation;
  final double? closeProgressThreshold;
  final ShapeBorder? shape;
  final Clip? clipBehavior;
  final bool expand;
  final AnimationController? secondAnimation;
  final Curve? animationCurve;
  final Curve? previousRouteAnimationCurve;
  final bool bounce;
  final bool? isDismissible;
  final bool enableDrag;
  final Radius? topRadius;
  final Duration? duration;
  final RouteSettings? settings;
  final Color? transitionBackgroundColor;
  final BoxShadow? shadow;

  CupertinoModalSheetData(
      {
      // this.imageFilter,
      // this.semanticsDismissible,
      this.useRootNavigator = true,
      this.barrierColor = _kModalBarrierColor,
      this.barrierDismissible = true,
      this.routeSettings,
      this.backgroundColor,
      this.elevation,
      this.closeProgressThreshold,
      this.shape,
      this.clipBehavior,
      this.expand = false,
      this.secondAnimation,
      this.animationCurve,
      this.previousRouteAnimationCurve,
      this.bounce = true,
      this.isDismissible,
      this.enableDrag = true,
      this.topRadius,
      this.duration,
      this.settings,
      this.transitionBackgroundColor,
      this.shadow});
}

/// Displays either the showModalBottomSheet for material
/// or showCupertinoModalPopup for cupertino
Future<T?> showPlatformModalSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  MaterialModalSheetData? material,
  CupertinoModalSheetData? cupertino,
}) {
  if (isMaterial(context)) {
    return showModalBottomSheet<T>(
      context: context,
      builder: builder,
      backgroundColor: material?.backgroundColor,
      elevation: material?.elevation,
      shape: material?.shape,
      isScrollControlled: material?.isScrollControlled ?? false,
      useRootNavigator: material?.useRootNavigator ?? false,
      clipBehavior: material?.clipBehavior,
      barrierColor: material?.barrierColor,
      enableDrag: material?.enableDrag ?? true,
      isDismissible: material?.isDismissible ?? true,
      routeSettings: material?.routeSettings,
      transitionAnimationController: material?.transitionAnimationController,
    );
  } else {
    return showCupertinoModalBottomSheet(
      context: context,
      builder: builder,
      backgroundColor: cupertino?.backgroundColor,
      elevation: cupertino?.elevation,
      closeProgressThreshold: cupertino?.closeProgressThreshold,
      shape: cupertino?.shape,
      clipBehavior: cupertino?.clipBehavior,
      barrierColor: cupertino?.barrierColor,
      expand: cupertino?.expand ?? false,
      secondAnimation: cupertino?.secondAnimation,
      animationCurve: cupertino?.animationCurve,
      previousRouteAnimationCurve: cupertino?.previousRouteAnimationCurve,
      useRootNavigator: cupertino?.useRootNavigator ?? true,
      bounce: cupertino?.bounce ?? true,
      isDismissible: cupertino?.isDismissible,
      enableDrag: cupertino?.enableDrag ?? true,
      topRadius: cupertino?.topRadius ?? Radius.circular(10),
      duration: cupertino?.duration,
      settings: cupertino?.settings,
      transitionBackgroundColor: cupertino?.transitionBackgroundColor,
      shadow: cupertino?.shadow,
    );
  }
}

Widget showDraggableScrollableSheet(
  BuildContext context, {
  Widget? child,
  Key? key,
  double initialChildSize = 0.5,
  double minChildSize = 0.25,
  maxChildSize = 1.0,
  bool expand = true,
  // Color backgroundColor = kWhiteColor,
}) {
  return SizedBox.expand(
    child: DraggableScrollableSheet(
      key: key,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            // color: backgroundColor,
          ),
          child: child,
        );
      },
    ),
  );
}
