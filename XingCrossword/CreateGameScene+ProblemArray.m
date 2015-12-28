//
//  CreateGameScene+ProblemArray.m
//  XingCrossword
//
//  Created by apple on 14-11-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CreateGameScene+ProblemArray.h"
#import "CreateGameScene+PostionHandler.h"

@implementation CreateGameScene (ProblemArray)

//init all Hor Problem and Add Them To the Array With Its First Node Postion
- (void)initHorProblem {
  for (int i = 0; i < self.wordArrayYMaxNumber; i++) {
    NSArray *currentArray = [self.wordArray objectAtIndex:i];
    for (int j = 0; j < currentArray.count; j++) {
      if ([self isTextFieldCellWithPostion:CGPointMake(j, i)] && [self haveRightTextFieldCellWithPostion:CGPointMake(j, i)] && ![self haveLeftTextFieldCellWithPostion:CGPointMake(j, i)]) {
        [self.horProblemArray addObject:[NSValue valueWithCGPoint:CGPointMake(j, i)]];
      }
    }
  }
}

//init all Ver Problem and Add Them To the Array With Its First Node Postion
- (void)initVerProblem {
  for (int j = 0; j < self.wordArrayYMaxNumber; j++) {
    for (int i = 0; i < self.wordArray.count; i ++) {
      if ([self isTextFieldCellWithPostion:CGPointMake(j, i)] && ![self isHaveUpTextFieldCellWithPostion:CGPointMake(j, i)] && [self isHaveDownTextFieldCellWithPostion:CGPointMake(j, i)]) {
        [self.verProblemArray addObject:[NSValue valueWithCGPoint:CGPointMake(j, i)]];
      }
    }
  }
}

- (void)initHorProblemNumber {
  for (int i = 0; i < self.wordArray.count; i++) {
    for (int  j= 0; j < self.wordArrayYMaxNumber; j ++) {
      if ([self isTextFieldCellWithPostion:CGPointMake(j, i)] && [self haveRightTextFieldCellWithPostion:CGPointMake(j, i)] && ![self haveLeftTextFieldCellWithPostion:CGPointMake(j, i)]) {
        [self.horProblemNumberArray addObject:@([self checkLengthOfHorProblemWithPostion:CGPointMake(j, i) andCurrnetLength:1])];
      }
    }
  }
}

- (void)initVerProblemNumber {
  for (int j = 0; j < self.wordArrayYMaxNumber; j++) {
    for (int i = 0; i < self.wordArray.count; i ++) {
      if ([self isTextFieldCellWithPostion:CGPointMake(j, i)] && ![self isHaveUpTextFieldCellWithPostion:CGPointMake(j, i)] && [self isHaveDownTextFieldCellWithPostion:CGPointMake(j, i)]) {
        [self.verProblemNumberArray addObject:@([self checkLengthOfVerProblemWithPostion:CGPointMake(j, i) andCurrnetLength:1])];
        
      }
    }
  }
}

- (NSInteger)checkLengthOfHorProblemWithPostion:(CGPoint)postion andCurrnetLength:(NSInteger)length{
  if ([self haveRightTextFieldCellWithPostion:postion]) {
    return [self checkLengthOfHorProblemWithPostion:CGPointMake(postion.x+1, postion.y) andCurrnetLength:length+1];
  } else {
    return length;
  }
}

- (NSInteger)checkLengthOfVerProblemWithPostion:(CGPoint)postion andCurrnetLength:(NSInteger)length{
  if ([self isHaveDownTextFieldCellWithPostion:postion]) {
    return [self checkLengthOfVerProblemWithPostion:CGPointMake(postion.x, postion.y+1) andCurrnetLength:length+1];
  } else {
    return length;
  }
}

// find the First Node's Postion Hor a ver Problem
- (int)findProblemInHorProblemWithCGPoint:(CGPoint)point {
  int numberOfProblem = 0;
  for (int i = 0; i < self.horProblemArray.count; i ++) {
    CGPoint currentPoint = [[self.horProblemArray objectAtIndex:i] CGPointValue];
    float x = currentPoint.x;
    float y = currentPoint.y;
    if (x <= point.x && y == point.y) {
      numberOfProblem = i + 1;
    }
  }
  return numberOfProblem;
}


// find the First Node's Postion for a ver Problem
- (int)findProblemInVerProblemWithCGPoint:(CGPoint)point {
  int numberOfProble = 0;
  for (int i = 0; i < self.verProblemArray.count; i ++) {
    CGPoint currentPoint = [[self.verProblemArray objectAtIndex:i] CGPointValue];
    float x = currentPoint.x;
    float y = currentPoint.y;
    if (x == point.x && y <= point.y) {
      numberOfProble = i + 1;
    }
  }
  return  numberOfProble;
}

//get String From WordCross
- (NSString*)getStringFromCrossWordWithStringBefore:(NSString*)string {
  if (self.hor) {
    CGPoint currentPoint = [[self.horProblemArray objectAtIndex:(self.currentProblemNumber - 1)] CGPointValue];
    return [self getStringFromHorCrossWordWithPoint:currentPoint andStringBefore:string];
  } else {
    CGPoint currentPoint = [[self.verProblemArray objectAtIndex:(self.currentProblemNumber - 1)] CGPointValue];
    return  [self getStringFromVerCrossWordWithPoint:currentPoint andStringBefore:string];
  }
}


@end
