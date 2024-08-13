import 'package:flutter/material.dart';
import 'package:instituto_o_caminho/core/extensions/context_extension.dart';
import 'package:instituto_o_caminho/core/routes/app_routes_list.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';
import 'package:instituto_o_caminho/features/activities/domain/entities/activity.dart';

class ActivityWidget extends StatelessWidget {
  const ActivityWidget({super.key, required this.activity});

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        context.push(AppRoutesList.activityDetails.fullPath(
          id: activity.id,
        ));
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: modalBackground,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              spreadRadius: 0.1,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        //padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.network(
                activity.images.first,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      activity.title,
                      style: const TextStyle(
                        color: constLight,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(
                      'Ver detalhes',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // const Text(
            //   'Clique para ver detalhes',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     color: Colors.grey,
            //     fontSize: 14,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
