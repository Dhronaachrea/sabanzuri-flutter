import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/widgets/drawer/drawer_widgets/app_version/sabanzuri_version_cubit.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:sabanzuri/utils/gradient_line.dart';

import 'package:sabanzuri/utils/loading_indicator.dart';

class SabanzuriVersion extends StatefulWidget {
  const SabanzuriVersion({Key? key}) : super(key: key);

  @override
  State<SabanzuriVersion> createState() => _SabanzuriVersionState();
}

class _SabanzuriVersionState extends State<SabanzuriVersion> {
  @override
  void initState() {
    BlocProvider.of<SabanzuriVersionCubit>(context).getVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const GradientLine(),
        BlocBuilder<SabanzuriVersionCubit, SabanzuriVersionState>(
          builder: (context, state) {
            if (state is SabanzuriVersionLoaded) {
              return SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    context.l10n.version + ": ${state.appVersion}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              );
            } else {
              return const LoadingIndicator().py8();
            }
          },
        ),
      ],
    );
  }
}
