import 'package:flutter/material.dart';

final iconData = [
  {
    "type":"Irrigation",
    "icon": Icons.water_drop_outlined
  },
  {
    "type":"Soil Management",
    "icon": Icons.grass_rounded
  },
  {
    "type":"What crop should plant",
    "icon": Icons.eco_outlined
  },
  {
    "type":"Fertilization",
    "icon": Icons.energy_savings_leaf_outlined
  },
  {
    "type":"Pest Control",
    "icon": Icons.pest_control_outlined
  }
];
class AdvisoriesCard extends StatelessWidget {
  final List<dynamic>? advisoriesData;
  const AdvisoriesCard({
    super.key,
    this.advisoriesData
  });
  @override
  Widget build(BuildContext context) {
  print(advisoriesData);
    return Card(
      child: ListView.builder(
        itemCount: advisoriesData?.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, idx){
          final advice = advisoriesData?[idx];
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.all(Radius.circular(100))
                    ),
                    child: Icon(iconData.firstWhere(
                        (icons) => icons['type'] == advice['type'],
                        orElse: () => {"icon": Icons.agriculture_outlined},
                      )['icon'] as IconData,
                    ),
                  ),
                  const SizedBox(width: 7,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          advice['type'],
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 7,),
                        Text(
                          '*${advice['message']}*-${advice['subtext']}',
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}