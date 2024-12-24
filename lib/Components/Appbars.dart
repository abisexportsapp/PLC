// ignore_for_file: must_be_immutable, file_names, overridden_fields

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:plc_project/Constant/dimensions.dart';
import 'package:plc_project/Constant/textfiledstyle.dart';
import 'package:theme_provider/theme_provider.dart';

abstract class SAPAppBars implements PreferredSizeWidget {
  Widget? leading;
  Widget? search;
  List<Widget>? actions;
  bool? centerTitle;
  String title;
  @override
  Size preferredSize;
  SAPAppBars(
      {this.centerTitle,
      required this.title,
      this.search,
      this.preferredSize = const Size.fromHeight(50.0),
      this.leading,
      this.actions});
}

abstract class SAPAppBarwithTabs extends SAPAppBars {
  @override
  Widget? leading;
  @override
  List<Widget>? actions;
  @override
  bool? centerTitle;
  @override
  String title;
  @override
  Size preferredSize;
  @override
  Widget? search;
  List<Widget> tabs;
  SAPAppBarwithTabs(
      {required this.actions,
      required this.centerTitle,
      required this.leading,
      required this.preferredSize,
      required this.title,
      this.search,
      required this.tabs})
      : super(centerTitle: centerTitle, title: title);
}

class SAPAppBar extends StatefulWidget implements SAPAppBars {
  @override
  Widget? leading;
  @override
  List<Widget>? actions;
  @override
  bool? centerTitle;
  @override
  Size preferredSize;
  @override
  String title;

  SAPAppBar(
      {super.key,
      this.centerTitle,
      required this.title,
      this.leading,
      this.search,
      this.actions})
      : preferredSize = (search != null)
            ? const Size.fromHeight(120.0)
            : const Size.fromHeight(50);

  @override
  State<SAPAppBar> createState() => _SAPAppBarState();

  @override
  Widget? search;
}

class _SAPAppBarState extends State<SAPAppBar> {
  IconData searchIcon = Icons.search;

  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      surfaceTintColor: ThemeProvider.themeOf(context)
          .data
          .extension<SAPTheme>()!
          .appBarBackgroundColor,
      leading: widget.leading,
      centerTitle: widget.centerTitle,
      actions: widget.actions,
      bottom: (widget.search != null)
          ? PreferredSize(
              preferredSize: const Size.fromHeight(250),
              child: Padding(
                padding: SAPDimensions.componentAllPadding,
                child: widget.search!,
              ),
            )
          : null,
      backgroundColor: ThemeProvider.themeOf(context)
          .data
          .extension<SAPTheme>()!
          .appBarBackgroundColor,
      scrolledUnderElevation: 4,
      title: Text(
        widget.title,
        style: GoogleFonts.poppins(
            color: ThemeProvider.themeOf(context)
                .data
                .extension<SAPTheme>()!
                .globalHeaderColor,
            fontSize: 16,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}

class SAPSliverAppBar extends StatefulWidget implements SAPAppBars {
  @override
  String title;
  @override
  Widget? leading;
  @override
  List<Widget>? actions;
  @override
  State<SAPSliverAppBar> createState() => _SAPSliverAppBarState();
  @override
  bool? centerTitle;
  @override
  Size preferredSize;
  SAPSliverAppBar({
    super.key,
    required this.title,
    this.leading,
    this.search,
    this.actions,
    this.centerTitle,
  }) : preferredSize = const Size.fromHeight(50);

  @override
  Widget? search;
}

class _SAPSliverAppBarState extends State<SAPSliverAppBar> {
  double maxHeight = 200;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: ThemeProvider.themeOf(context)
          .data
          .extension<SAPTheme>()!
          .appBarBackgroundColor,
      surfaceTintColor: Colors.transparent,
      snap: false,
      pinned: true,
      floating: false,
      flexibleSpace: LayoutBuilder(builder: (p0, p1) {
        SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {
              maxHeight = p1.maxHeight;
            }));
        return FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(
                left: (p1.maxHeight < 125) ? 60 : 20,
                bottom: (widget.search != null) ? 77 : 17),
            title: Text(
              widget.title,
              style: SAPTextSTyle.appBarTitleTextStyle(context), //TextStyle
            ), //Text
            background: Container(
              height: double.maxFinite,
              color: ThemeProvider.themeOf(context)
                  .data
                  .extension<SAPTheme>()!
                  .appBarBackgroundColor,

              // child: Column(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children:[ ListTile(
              //         leading:const CircleAvatar(
              //           child: Icon(Icons.person),
              //         ),
              //         title: Text(widget.user?.name??'',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600),),
              //         subtitle:Text(widget.user?.role ?? '',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 12),),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(left: 70),
              //         child: Text('Emp Code - ${widget.user?.code}',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 12),),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(left: 70),
              //         child: Text(widget.user?.branch ?? '',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 12),),
              //       ),
              //       const SizedBox(height: 30,)
              //       ]
              //     ),
            ) //Images.networky
            );
      }),
      bottom: (widget.search != null)
          ? PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Padding(
                padding: SAPDimensions.componentAllPadding,
                child: widget.search!,
              ),
            )
          : null, //FlexibleSpaceBar
      expandedHeight: 200,
      leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 8),
          child: widget.leading), //IconButton
      actions: widget.actions, //<Widget>[]
    );
  }
}

class SAPAppBarwithTab extends StatelessWidget implements SAPAppBarwithTabs {
  bool isScrollable;
  SAPAppBarwithTab(
      {super.key,
      required this.tabs,
      this.actions,
      required this.title,
      this.centerTitle,
      this.leading,
      required this.isScrollable})
      : preferredSize = const Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: leading,
      centerTitle: centerTitle,
      actions: actions,
      scrolledUnderElevation: 4,
      backgroundColor: ThemeProvider.themeOf(context)
          .data
          .extension<SAPTheme>()!
          .appBarBackgroundColor,
      title: Text(title, style: SAPTextSTyle.appBarTitleTextStyle(context)),
      bottom: TabBar(
          isScrollable: isScrollable,
          unselectedLabelColor: Colors.black,
          labelColor: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .primaryButtonBackgroundColor,
          tabs: tabs),
    );
  }

  @override
  List<Widget>? actions;

  @override
  bool? centerTitle;

  @override
  Widget? leading;

  @override
  Size preferredSize;

  @override
  List<Widget> tabs;

  @override
  String title;

  @override
  Widget? search;
}

class SAPSliverAppBarwithTab extends StatefulWidget
    implements SAPAppBarwithTabs {
  bool isScrollable;
  SAPSliverAppBarwithTab(
      {super.key,
      required this.tabs,
      this.actions,
      required this.title,
      this.centerTitle,
      this.leading,
      this.search,
      required this.isScrollable})
      : preferredSize = const Size.fromHeight(100.0);

  @override
  State<SAPSliverAppBarwithTab> createState() => _SAPSliverAppBarwithTabState();

  @override
  List<Widget>? actions;

  @override
  bool? centerTitle;

  @override
  Widget? leading;

  @override
  Size preferredSize;

  @override
  List<Widget> tabs;

  @override
  String title;

  @override
  Widget? search;
}

class _SAPSliverAppBarwithTabState extends State<SAPSliverAppBarwithTab> {
  double maxHeight = 200;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      surfaceTintColor: ThemeProvider.themeOf(context)
          .data
          .extension<SAPTheme>()!
          .appBarBackgroundColor,
      backgroundColor: ThemeProvider.themeOf(context)
          .data
          .extension<SAPTheme>()!
          .appBarBackgroundColor,
      snap: false,
      pinned: true,
      floating: false,
      bottom: (widget.search != null)
          ? PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Column(
                children: [
                  TabBar(
                      indicatorColor: ThemeProvider.themeOf(context)
                          .data
                          .extension<SAPTheme>()!
                          .primaryButtonBackgroundColor,
                      isScrollable: widget.isScrollable,
                      unselectedLabelColor: Colors.black,
                      labelColor: ThemeProvider.themeOf(context)
                          .data
                          .extension<SAPTheme>()!
                          .primaryButtonBackgroundColor,
                      tabs: widget.tabs),
                  Padding(
                    padding: SAPDimensions.componentAllPadding,
                    child: widget.search!,
                  ),
                ],
              ),
            )
          : TabBar(
              isScrollable: widget.isScrollable,
              unselectedLabelColor: Colors.black,
              labelColor: ThemeProvider.themeOf(context)
                  .data
                  .extension<SAPTheme>()!
                  .primaryButtonBackgroundColor,
              tabs: widget.tabs),
      flexibleSpace: LayoutBuilder(builder: (p0, p1) {
        SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {
              maxHeight = p1.maxHeight;
            }));
        return FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(
                left: (p1.maxHeight < 165) ? 60 : 20,
                bottom: (widget.search != null) ? 128 : 65),
            title: Text(
              widget.title,
              style: SAPTextSTyle.appBarTitleTextStyle(context), //TextStyle
            ), //Text
            background: Container(
              height: double.maxFinite,
              color: ThemeProvider.themeOf(context)
                  .data
                  .extension<SAPTheme>()!
                  .appBarBackgroundColor,
            ) //Images.network
            );
      }),
      //FlexibleSpaceBar
      expandedHeight: 200,
      leading: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: widget.leading), //IconButton
      actions: widget.actions, //<Widget>[]
    );
  }
}
