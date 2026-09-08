import 'package:flutter/material.dart';

class FamilyTreeMember {
  const FamilyTreeMember({
    required this.name,
    required this.relation,
    required this.initial,
    required this.color,
    required this.x,
    required this.y,
    required this.radius,
  });

  final String name;
  final String relation;
  final String initial;
  final Color color;
  final double x;
  final double y;
  final double radius;
}

class FamilyTreeGap {
  const FamilyTreeGap({
    required this.name,
    required this.missingDetail,
    required this.askPrompt,
    required this.x,
    required this.y,
    required this.radius,
  });

  final String name;
  final String missingDetail;
  final String askPrompt;
  final double x;
  final double y;
  final double radius;
}

class FamilyTreeData {
  const FamilyTreeData({
    required this.canvasWidth,
    required this.canvasHeight,
    required this.generationCount,
    required this.members,
    required this.gap,
  });

  final double canvasWidth;
  final double canvasHeight;
  final int generationCount;
  final List<FamilyTreeMember> members;
  final FamilyTreeGap gap;

  int get peopleCount => members.length + 1;
}

const fakeFamilyTree = FamilyTreeData(
  canvasWidth: 340,
  canvasHeight: 420,
  generationCount: 3,
  members: [
    FamilyTreeMember(
      name: 'Jeddo Rashid',
      relation: 'Grandfather',
      initial: 'R',
      color: Color(0xFF2F6F8F),
      x: 110,
      y: 62,
      radius: 21,
    ),
    FamilyTreeMember(
      name: 'Umm Rashid',
      relation: 'Grandmother',
      initial: 'U',
      color: Color(0xFF8A5A7A),
      x: 230,
      y: 62,
      radius: 21,
    ),
    FamilyTreeMember(
      name: 'Khalid',
      relation: 'Son',
      initial: 'K',
      color: Color(0xFFB07C4A),
      x: 60,
      y: 172,
      radius: 19,
    ),
    FamilyTreeMember(
      name: 'Maryam',
      relation: 'Daughter',
      initial: 'M',
      color: Color(0xFF4A806C),
      x: 170,
      y: 172,
      radius: 19,
    ),
    FamilyTreeMember(
      name: 'Noura',
      relation: 'Daughter',
      initial: 'N',
      color: Color(0xFF8A5A7A),
      x: 280,
      y: 172,
      radius: 19,
    ),
    FamilyTreeMember(
      name: 'Sara',
      relation: "Maryam's daughter",
      initial: 'S',
      color: Color(0xFF6B7A3A),
      x: 105,
      y: 282,
      radius: 18,
    ),
    FamilyTreeMember(
      name: 'Ahmed',
      relation: "Noura's son",
      initial: 'A',
      color: Color(0xFFA6603E),
      x: 235,
      y: 282,
      radius: 18,
    ),
  ],
  gap: FamilyTreeGap(
    name: 'Saif',
    missingDetail: 'Saif is missing a birth year',
    askPrompt: 'Ask Jeddo Rashid about him',
    x: 110,
    y: 8,
    radius: 12,
  ),
);
