//
//  CreateGameScene.m
//  XingCrossword
//
//  Created by apple on 14-9-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CreateGameScene.h"
#import "PuzzleGame.h"
#import "CreateGameScene+PostionHandler.h"
#import "CreateGameScene+ProblemArray.h"
#import "CreateGameScene+fill.h"

@implementation CreateGameScene

- (id)initWithSize:(CGSize)size {
  self.puzzleId = @"myPuzzle";
  self.isCreateMap = YES;
  if (self = [super initWithSize:size]) {
    self.horProblemArray = [[NSMutableArray alloc] init];
    self.verProblemArray = [[NSMutableArray alloc] init];
    self.horProblemNumberArray = [[NSMutableArray alloc] init];
    self.verProblemNumberArray = [[NSMutableArray alloc] init];
    SKSpriteNode *backGround = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
    backGround.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    backGround.name = @"BACKGROUND";
    [self addChild:backGround];
    [self createWordArray];
    [self initNodeArray];
  }
  return self;
}

- (void)createWordArray {
  PuzzleGame *puzzleGame = [[PuzzleGame alloc] initBlankPuzzleWithsize:self.size];
  self.puzzle = puzzleGame.puzzleNode;
  self.wordArray = puzzleGame.mapGrid;
  NSArray *firstArray = [self.wordArray objectAtIndex:0];
  self.wordArrayXMaxNumber = self.wordArray.count;
  self.wordArrayYMaxNumber = firstArray.count;
}

- (void)initNodeArray {
  [self addChild:self.puzzle];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  for (UITouch *touch in touches) {
    if (self.isCreateMap) {
      [self handleTouchForCreateMapWithTouch:touch];
    } else {
      [self handleTouchForCreateProblemWithTouch:touch];
    }
  }
}


- (void)handleTouchForCreateMapWithTouch:(UITouch *)touch {
  CGPoint location = [touch locationInNode:self];
  SKNode *node = [self nodeAtPoint:location];
  NSLog(@"%@",node.name);
  if ([node.name isEqual:@"text"]) {
    node = [node parent];
  }
  CGPoint mytouch = [self getCellPostionWithNodeName:node.name];
  if ([self isInGridWithPostion:mytouch]) {
    if ([self isTextFieldCellWithPostion:mytouch]) {
      self.wordArray[(int)mytouch.y][(int)mytouch.x] = @"0";
    } else {
      self.wordArray[(int)mytouch.y][(int)mytouch.x] = @"1";
    }
    [self resetColor];
  }
}

- (void)handleTouchForCreateProblemWithTouch:(UITouch *)touch {
  CGPoint location = [touch locationInNode:self];
  SKNode *node = [self nodeAtPoint:location];
  NSLog(@"%@",node.name);
  if ([node.name isEqual:@"text"]) {
    node = [node parent];
  }
  if (![node.name isEqual:@"BACKGROUND"] && ![node.name isEqual:@"puzzle"]) {
    CGPoint mytouch = [self getCellPostionWithNodeName:node.name];
    if ([self isInGridWithPostion:mytouch]) {
      if ([self isTextFieldCellWithPostion:mytouch]) {
        if (self.hor) {
          [self resetColor];
          [self fillingLeft:mytouch];
          [self fillingRight:mytouch];
          self.currentProblemNumber = [self findProblemInHorProblemWithCGPoint:mytouch];
        }else {
          [self resetColor];
          [self fillUp:mytouch];
          [self fillDown:mytouch];
          self.currentProblemNumber = [self findProblemInVerProblemWithCGPoint:mytouch];
        }
      }
      self.hor = !self.hor;
    }
  }
}

- (BOOL)isACorrectMap {
  BOOL isACorrectMap = YES;
  BOOL shouldBreak = NO;
  for (int i = 0; i < self.wordArrayYMaxNumber; i ++ ) {
    if (shouldBreak) {
      break;
    }
    for (int j = 0; j < self.wordArrayXMaxNumber; j++) {
      if (shouldBreak) {
        break;
      }
      CGPoint postion = CGPointMake(i, j);
      CGPoint postionDown = CGPointMake(i, j + 1);
      if ([self isInGridWithPostion:postion]&[self isTextFieldCellWithPostion:postion]&&[self haveRightTextFieldCellWithPostion:postion]&&[self isHaveDownTextFieldCellWithPostion:postion]&&[self haveRightTextFieldCellWithPostion:postionDown]) {
        isACorrectMap = NO;
        shouldBreak = YES;
      }
    }
  }
  return isACorrectMap;
}

- (void)handleIfMapIsCorrect {
  [self initHorProblemNumber];
  [self initVerProblemNumber];
  if ([self.delegate respondsToSelector:@selector(createGameSceneGridHasFinishCreateWithNumberArrayOfHorAnswerWords:andVerAnswerWords:)]) {
    [self. delegate createGameSceneGridHasFinishCreateWithNumberArrayOfHorAnswerWords:self.horProblemNumberArray andVerAnswerWords:self.verProblemNumberArray];
  }
}

- (CGPoint) getCellPostionWithNodeName:(NSString*)nodeName {
  NSArray *strings = [nodeName componentsSeparatedByString:@","];
  float xValue = [[strings objectAtIndex:0]floatValue];
  float yValue = [[strings objectAtIndex:1]floatValue];
  return CGPointMake(xValue, yValue);
}


//reset all Node's Color
- (void)resetColor {
  for (int i = 0; i < self.wordArray.count; i++) {
    NSArray *currentArray = [self.wordArray objectAtIndex:i];
    for (int j = 0; j < currentArray.count; j++) {
      NSString *currentValue = [currentArray objectAtIndex:j];
      if ([currentValue isEqualToString:@"1"]) {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzle childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)j,(int)i]];
//        currentnode.texture = [SKTexture textureWithImageNamed:@"empty.png"];
      } else {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzle childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)j,(int)i]];
//        currentnode.texture = [SKTexture textureWithImageNamed:@"block.png"];
      }
    }
  }
}

@end
