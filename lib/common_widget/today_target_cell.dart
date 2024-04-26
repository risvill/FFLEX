import 'package:fflex/common/colo_extension.dart';
import 'package:flutter/material.dart';

class TodayTargetCell extends StatelessWidget {
  final String icon;
  final Map<String, String> data;
  final String title;
  const TodayTargetCell(
      {super.key,
      required this.icon,
      required this.data,      
      required this.title});

  @override
  Widget build(BuildContext context) {
    final waterIntake = data['waterIntake'];
    final dropdownValue = data['dropdownValue'];
    return Container(
      height: 70,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: TColor.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          colors: TColor.primaryG,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height));
                      },
                      child: Text(
                        waterIntake ?? '',
                        style: TextStyle(
                          color: TColor.white.withOpacity(0.7),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(left: 2.5),
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            colors: TColor.primaryG,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height));
                        },
                        child: Text(
                          dropdownValue ?? '',
                          style: TextStyle(
                            color: TColor.white.withOpacity(0.7),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // DropdownButton<String>(
                    //   value: dropdownValue,
                    //   icon: const Icon(Icons.arrow_drop_down),
                    //   iconSize: 24,
                    //   elevation: 16,
                    //   style: const TextStyle(color: Color.fromARGB(255, 116, 161, 215)),
                    //   onChanged: (String? newValue) {
                    //     // Обновляем значение dropdownValue в data
                    //     data['unit'] = newValue!;
                    //   },
                    //   items: <String>['мл', 'л'].map<DropdownMenuItem<String>>((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    // ),
                  ],
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
