import 'package:flutter/material.dart';

import '../../../components/zoom_drawer/zoom_drawer_open_button.dart';
import '../../../configs/themes/app_colors.dart';
import '../../../widgets/content_area.dart';
import './sortby_drop_button.dart';
import './overall_result.dart';
import './heading.dart';

class Body extends StatelessWidget {
  const Body({super.key, this.toggleDrawer});
    final Function()? toggleDrawer;
  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(gradient: mainGradient()),
      child: SafeArea(
        child: Column(
          children: [
             ZoomDrawerOpenButton(onTap: toggleDrawer,title: 'Overall Points'),
            // Heading
            const Heading(),
    
            // Sort by
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text('Sort by : '),
                  SizedBox(
                    width: 2,
                  ),
                  SortByDropButton(),
                ],
              ),
            ),
    
            // Results Tile
            const Expanded(
              child: ContentArea(
                addPadding: false,
                child: OverallResults(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
