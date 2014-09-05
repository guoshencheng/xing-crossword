//
//  MyScene+fill.m
//  XingCrossword
//
//  Created by apple on 14-9-5.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "MyScene+fill.h"
#import "MyScene+PostionHandler.h"

@implementation MyScene (fill)

- (void)fillDown:(CGPoint)point {
  if ([self isHaveDownTextFieldCellWithPostion:point]) {
    [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]] setColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0]];
    
    [self fillDown:CGPointMake(point.x, point.y + 1)];
  } else {
    [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]] setColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0]];
  }
}

- (void)fillUp:(CGPoint)point {
  if ([self isHaveUpTextFieldCellWithPostion:point]) {
    [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]] setColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0]];
    
    [self fillUp:CGPointMake(point.x, point.y - 1)];
  } else {
    [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]] setColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0]];
  }
}

- (void)fillingLeft:(CGPoint)point {
  if ([self haveLeftTextFieldCellWithPostion:point]) {
    [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]] setColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0]];
    [self fillingLeft:CGPointMake(point.x - 1, point.y)];
  } else {
    [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]] setColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0]];
  }
}

- (void)fillingRight:(CGPoint)point {
  if ([self haveRightTextFieldCellWithPostion:point]) {
    [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]] setColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0]];
    
    [self fillingRight:CGPointMake(point.x + 1, point.y)];
  } else {
    [(SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]] setColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0]];
  }
}

- (void)fillingDownWithEmpty:(CGPoint)point {
  if ([self isHaveDownTextFieldCellWithPostion:point]) {
    SKSpriteNode *currentNode = (SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
    SKLabelNode *currenttext = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
    [currenttext setText:@""];
    [self fillingDownWithEmpty:CGPointMake(point.x , point.y + 1)];
  } else {
    SKSpriteNode *currentNode = (SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
    SKLabelNode *currenttext = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
    [currenttext setText:@""];
  }
}

- (void)fillingRightWithEmpty:(CGPoint)point {
  if ([self haveRightTextFieldCellWithPostion:point]) {
    SKSpriteNode *currentNode = (SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
    SKLabelNode *currenttext = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
    [currenttext setText:@""];
    [self fillingRightWithEmpty:CGPointMake(point.x + 1, point.y)];
  } else {
    SKSpriteNode *currentNode = (SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
    SKLabelNode *currenttext = (SKLabelNode*)[currentNode childNodeWithName:@"text"];
    [currenttext setText:@""];
  }
}

@end
