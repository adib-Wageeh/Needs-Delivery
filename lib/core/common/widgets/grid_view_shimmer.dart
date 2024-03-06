import 'package:flutter/material.dart';
import 'package:needs_delivery/core/extensions/context_extension.dart';
import 'package:shimmer/shimmer.dart';

class GridViewShimmer extends StatelessWidget {
  const GridViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: context.width ~/ 180,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,),
      shrinkWrap: true,
      itemCount: (context.width ~/ 180)*10,
      itemBuilder: (context,index){
        return const GridViewContainerShimmer();
      },
    );
  }
}

class GridViewContainerShimmer extends StatelessWidget {
  const GridViewContainerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(6).copyWith(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(20),
        ),

      ),
    );
  }
}
