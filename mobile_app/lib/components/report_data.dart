import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_app/backend_notifier/report_notifier.dart';
import 'package:mobile_app/utils/utils.dart';
import 'package:mobile_app/widget/custom_button.dart';

class ReportScreen extends ConsumerWidget {
  final File profileImage;
  final ValueChanged<int> onChanged;

  const ReportScreen({
    required this.profileImage,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final dataState = ref.watch(reportNotifierProvider(profileImage));

    ref.listen(reportNotifierProvider(profileImage), (previous, next) {
      if (next.hasError) {
        onChanged(0);
      }
    });
    return dataState.when(
      loading: () => Scaffold(
        body: Center(child: Lottie.asset('assets/animations/Loading1.json', width: 150, height: 150, repeat: true, reverse: true)),
      ),
      error: (error, stack) => (
        Scaffold(
          body: Center(child: Column(
            children: [
              Text(error.toString()),
              CustomButton(onTap: () {onChanged(0);}, text: 'text'),
            ],
          )),
        )
      ), 
      data: (data) => Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.red,
                      ),
                      SizedBox(width: 8,),
                      Text('Pest Detected'),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Container(
                    width: size.width,
                    height: size.width * 0.8,
                    clipBehavior: Clip.antiAlias, // Keeps image inside rounded corners
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.file(profileImage!, fit: BoxFit.cover),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 19,
                        backgroundColor: Colors.red.shade300,
                        child: Icon(Icons.bug_report_outlined, color: Theme.of(context).colorScheme.onSurface, size: 30),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                          child: Text(
                            data?.pestName ?? '',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text('Confidence: ${data?.confidence.toString()}%'),
                  SizedBox(height: size.height*0.04,),
                  Text('Affected Ared: ${data?.affectedArea}'),
                  Text('Spread Risk: ${data?.spreadRisk}'),
                  Text('Severity Level: ${data?.severity}'),
                  SizedBox(height: 5),
                  LinearProgressIndicator(
                    value: getSeverityData(data?.severity ?? '')?.heatLevel,
                    minHeight: 10,
                    backgroundColor: Colors.grey.shade300,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      getSeverityData(data?.severity ?? '')?.color ?? Colors.grey,
                    ),
                  ),
                  SizedBox(height: size.height*0.04,),
                  Text('Recommended Treatment:', style: Theme.of(context).textTheme.bodyLarge,),
                  SizedBox(height: 8),
                  ListView.builder(
                    itemCount: data?.treatments.length ?? 0,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, idx) {
                      String tret = data?.treatments[idx];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('🐛'),
                            SizedBox(width: 8,),
                            Expanded(
                              child: Text(
                                tret,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                  SizedBox(height: 8,),
                  
                  Text(
                    'Best Treatment Time: ${data?.bestTreatmentTime}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}