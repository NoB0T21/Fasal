import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SelectSoilType extends StatefulWidget {
  final Function(Map<String, dynamic>) onChanged;

  const SelectSoilType({super.key, required this.onChanged});

  @override
  State<SelectSoilType> createState() => _SelectSoilTypeState();
}

class _SelectSoilTypeState extends State<SelectSoilType> {
  String? _selectedSoilId;

  final List<Map<String, dynamic>> soilTypes = [
    {
      "id": 'clay',
      "name": 'setup.soilTypes.clay.name',
      "description": 'setup.soilTypes.clay.desc',
      "imageUrl": 'https://images.unsplash.com/photo-1757356881780-2eb078fcb472?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxjbGF5JTIwc29pbCUyMHRleHR1cmUlMjBhZ3JpY3VsdHVyZXxlbnwxfHx8fDE3NzU5NzM0Njl8MA&ixlib=rb-4.1.0&q=80&w=1080',
    },
    {
      "id": 'sandy',
      "name": 'setup.soilTypes.sandy.name',
      "description": 'setup.soilTypes.sandy.desc',
      "imageUrl": 'https://images.unsplash.com/photo-1585744998375-d628929714ca?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzYW5keSUyMHNvaWwlMjB0ZXh0dXJlJTIwZmFybWluZ3xlbnwxfHx8fDE3NzU5NzM0NzB8MA&ixlib=rb-4.1.0&q=80&w=1080',
    },
    {
      "id": 'loamy',
      "name": 'setup.soilTypes.loamy.name',
      "description": 'setup.soilTypes.loamy.desc',
      "imageUrl": 'https://images.unsplash.com/photo-1630574514371-13c5086c7169?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxsb2FteSUyMHNvaWwlMjBhZ3JpY3VsdHVyZXxlbnwxfHx8fDE3NzU5NzM0NzB8MA&ixlib=rb-4.1.0&q=80&w=1080',
    },
    {
      "id": 'silt',
      "name": 'setup.soilTypes.silt.name',
      "description": 'setup.soilTypes.silt.desc',
      "imageUrl": 'https://images.unsplash.com/photo-1570484320708-d2da7cd1e3c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzaWx0JTIwc29pbCUyMHRleHR1cmV8ZW58MXx8fHwxNzc1OTczNDcxfDA&ixlib=rb-4.1.0&q=80&w=1080',
    },
    {
      "id": 'black',
      "name": 'setup.soilTypes.black.name',
      "description": 'setup.soilTypes.black.desc',
      "imageUrl": 'https://images.unsplash.com/photo-1570180274219-7213f4d17633?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxibGFjayUyMGNvdHRvbiUyMHNvaWwlMjBhZ3JpY3VsdHVyZXxlbnwxfHx8fDE3NzU5NzM0NzF8MA&ixlib=rb-4.1.0&q=80&w=1080',
    },
    {
      "id": 'red',
      "name": 'setup.soilTypes.red.name',
      "description": 'setup.soilTypes.red.desc',
      "imageUrl": 'https://images.unsplash.com/photo-1695574335279-b962607311ed?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxyZWQlMjBzb2lsJTIwZmFybWluZyUyMEluZGlhfGVufDF8fHx8MTc3NTk3MzQ3MXww&ixlib=rb-4.1.0&q=80&w=1080',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount;
    double imgwidth;
    double imgheight;
    double childAspectRatio;

    if (width < 600) {
      crossAxisCount = 2;
      childAspectRatio = 0.7;
      imgwidth = 150;
      imgheight = 150; // Taller on small screens
    } else if (width < 1000) {
      crossAxisCount = 3;
      childAspectRatio = 1;
      imgwidth = 250;
      imgheight = 160;
    } else {
      crossAxisCount = 4;
      childAspectRatio = 1;
      imgwidth = 250;
      imgheight = 160;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        mainAxisSpacing: 40,
        crossAxisSpacing: 8,
      ),
      itemCount: soilTypes.length,
      itemBuilder: (context, index) {
        final soil = soilTypes[index];

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedSoilId = soil['id'];
            });
            widget.onChanged(soil);
          },

          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: _selectedSoilId == soil['id'] ? Colors.green : Colors.transparent,
                width: 3,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                // Soil Image
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    soil['imageUrl'],
                    width: imgwidth,
                    height: imgheight,
                    fit: BoxFit.cover,
                  ),
                ),
                // Text Content
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${soil['name']}'.tr(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${soil['description']}'.tr(),
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}