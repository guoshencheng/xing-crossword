//
//  CreateGameScene+PostionHandler.m
//  XingCrossword
//
//  Created by apple on 14-11-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CreateGameScene+PostionHandler.h"

@implementation CreateGameScene (PostionHandler)

- (BOOL)isInGridWithPostion:(CGPoint)mytouch {
  return  (mytouch.x >= 0 && mytouch.y >= 0 && mytouch.x < self.wordArrayXMaxNumber && mytouch.y < self.wordArrayYMaxNumber);
  
}

- (BOOL)haveHorTextField:(CGPoint)point {
  return [self haveLeftTextFieldCellWithPostion:point] || [self haveRightTextFieldCellWithPostion:point];
}

- (BOOL)haveVerTextField:(CGPoint)point {
  return [self isHaveDownTextFieldCellWithPostion:point] || [self isHaveUpTextFieldCellWithPostion:point];
}

- (BOOL)haveLeftTextFieldCellWithPostion:(CGPoint)point {
  BOOL haveTextField = false;
  if (point.x > 0){
    NSString *currentLeftString= [[self.wordArray objectAtIndex:point.y] objectAtIndex:(point.x-1)];
    if ([currentLeftString isEqualToString:@"1"]) {
      haveTextField = true;
    }
  }
  return haveTextField;
}

- (BOOL)haveRightTextFieldCellWithPostion:(CGPoint)point {
  BOOL haveTextField = false;
  if (point.x < self.wordArrayXMaxNumber - 1) {
    NSString *currentLeftString= [[self.wordArray objectAtIndex:point.y] objectAtIndex:(point.x+1)];
    if ([currentLeftString isEqualToString:@"1"]) {
      haveTextField = true;
    }
  }
  return haveTextField;
}

- (BOOL)isHaveDownTextFieldCellWithPostion:(CGPoint)point {
  BOOL haveTextField = false;
  if (point.y < self.wordArrayYMaxNumber - 1) {
    NSString *currentLeftString= [[self.wordArray objectAtIndex:(point.y+1)] objectAtIndex:point.x];
    if ([currentLeftString isEqualToString:@"1"]) {
      haveTextField = true;
    }
  }
  return haveTextField;
}

- (BOOL)isHaveUpTextFieldCellWithPostion:(CGPoint)point {
  BOOL haveTextField = false;
  if (point.y > 0) {
    NSString *currentLeftString= [[self.wordArray objectAtIndex:(point.y-1)] objectAtIndex:point.x];
    if ([currentLeftString isEqualToString:@"1"]) {
      haveTextField = true;
    }
  }
  return haveTextField;
}

- (SKSpriteNode*)getNodeWithPoint:(CGPoint)point {
  return (SKSpriteNode*)[self.puzzleGame.puzzleNode childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
}

- (NSString*)getStringFromVerCrossWordWithPoint:(CGPoint)point andStringBefore:(NSString*)string {
  if ([self isHaveDownTextFieldCellWithPostion:point]) {
    SKSpriteNode *currentNode = [self getNodeWithPoint:point];
    SKLabelNode *currentlabel = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
    return [self getStringFromVerCrossWordWithPoint:CGPointMake(point.x, point.y+1) andStringBefore:[NSString stringWithFormat:@"%@%@",string,currentlabel.text]];
  } else {
    SKSpriteNode *currentNode = [self getNodeWithPoint:point];
    SKLabelNode *currentlabel = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
    return [NSString stringWithFormat:@"%@%@",string,currentlabel.text];
  }
}

- (NSString*)getStringFromHorCrossWordWithPoint:(CGPoint)point andStringBefore:(NSString*)string {
  if ([self haveRightTextFieldCellWithPostion:point]) {
    SKSpriteNode *currentNode = [self getNodeWithPoint:point];
    SKLabelNode *currentlabel = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
    return [self getStringFromHorCrossWordWithPoint:CGPointMake(point.x+1, point.y) andStringBefore:[NSString stringWithFormat:@"%@%@",string,currentlabel.text]];
  } else {
    SKSpriteNode *currentNode = [self getNodeWithPoint:point];
    SKLabelNode *currentlabel = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
    return [NSString stringWithFormat:@"%@%@",string,currentlabel.text];
  }
}

- (BOOL)isTextFieldCellWithPostion:(CGPoint)point {
  BOOL isTextField = false;
  NSArray *firstArray = [self.wordArray objectAtIndex:0];
  if (point.y < self.wordArray.count && point.x < firstArray.count) {
    NSString *currentLeftString= [[self.wordArray objectAtIndex:point.y] objectAtIndex:point.x];
    if ([currentLeftString isEqualToString:@"1"]) {
      isTextField = true;
    }
  }
  return isTextField;
}

- (void)changeDirectionByTouch:(CGPoint)myTouch {
  if ([self isTextFieldCellWithPostion:myTouch] && [self haveHorTextField:myTouch] && ![self haveVerTextField:myTouch] ) {
    self.hor = YES;
  }
  if ([self isTextFieldCellWithPostion:myTouch] && ![self haveHorTextField:myTouch] && [self  haveVerTextField:myTouch]) {
    self.hor = NO;
  }
  if ([self isTextFieldCellWithPostion:myTouch] && [self haveHorTextField:myTouch] && [self haveVerTextField:myTouch]) {
    self.hor = !self.hor;
  }
}


@end
