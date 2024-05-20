import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/ui/root_page/root_cubit.dart';
import 'package:salicta_mobile/ui/root_page/root_state.dart';
import 'package:salicta_mobile/util/widgets/tabbed/bottom_navbar.dart';
import 'package:salicta_mobile/util/widgets/tiles/notification_tile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final rootBloc=BlocProvider.of<RootCubit>(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (_) => kOnExitConfirmation(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "NOTIFICATION",
            style: kMerriweatherBold16,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<RootCubit, RootState>(
            buildWhen: (previous, current) =>
                previous.notifications != current.notifications,
            builder: (context, state) {

              if(state.notifications.isEmpty){
                return const Center(
                  child: Text(
                    'Empty',
                    style: TextStyle(fontSize: 18,color:kOffBlack ),
                  ),
                );
              }

              return ListView.separated(
                itemCount: state.notifications.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final notification = state.notifications[index];

                  return GestureDetector(
                    onTap: () async {
                      await rootBloc.readNotification(notification);
                    },
                    child: NotificationTile(
                      name: notification.title,
                      description: notification.description ?? '--',
                      isNew: !notification.isRead ? true : false,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return  Divider(
                    height: 0,
                    thickness: 0.3,
                    color: Colors.black54.withOpacity(0.2),
                    indent: 1,
                    endIndent: 1,
                  );
                },
              );
            }),
      ),
    );
  }
}
