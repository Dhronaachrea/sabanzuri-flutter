import "package:flutter/material.dart";
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/url.dart';

import 'drawer_tile.dart';
import 'drawer_title.dart';

class MoreLinks extends StatelessWidget {
  const MoreLinks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawerTitle(title: context.l10n.moreLinks.toUpperCase()),
        DrawerTile(
          heading: context.l10n.faq.toUpperCase(),
          onTap: () => Navigator.pushNamed(
            context,
            Screen.common_web_view_screen,
            arguments: Url.FAQ_URL,
          ),
        ),
        DrawerTile(
          heading: context.l10n.responsibleGaming,
          onTap: () => Navigator.pushNamed(
            context,
            Screen.common_web_view_screen,
            arguments: Url.RESPONSIBLE_GAMING_URL,
          ),
        ),
        DrawerTile(
          heading: context.l10n.termsAndConditions,
          onTap: () => Navigator.pushNamed(
            context,
            Screen.common_web_view_screen,
            arguments: Url.TNC_URL,
          ),
        ),
        DrawerTile(
          heading: context.l10n.privacyPolicy,
          onTap: () => Navigator.pushNamed(
            context,
            Screen.common_web_view_screen,
            arguments: Url.PRIVACY_POLICY_URL,
          ),
        ),
        DrawerTile(
          heading: context.l10n.contactUs,
          onTap: () => Navigator.pushNamed(
            context,
            Screen.common_web_view_screen,
            arguments: Url.CONTACT_US_URL,
          ),
        ),
      ],
    );
  }
}
