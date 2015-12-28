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
  PuzzleGame *puzzleGame = [[PuzzleGame alloc] initBlankPuzzleWithsize:self.size andTheme:[ColorThemeFactory defaultThemeTexture]];
  self.puzzleGame = puzzleGame;
  self.wordArray = puzzleGame.mapGrid;
  NSArray *firstArray = [self.wordArray objectAtIndex:0];
  self.wordArrayXMaxNumber = firstArray.count;
  self.wordArrayYMaxNumber = self.wordArray.count;
}

- (void)initNodeArray {
  [self addChild:self.puzzleGame.puzzleNode];
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
  SKSpriteNode *node = (SKSpriteNode *)[self nodeAtPoint:location];
  NSLog(@"%@",node.name);
  if ([node.name isEqual:@"text"]) {
      node = (SKSpriteNode *)[node parent];
  }
    
  CGPoint mytouch = [self getCellPostionWithNodeName:node.name];
  if ([self isInGridWithPostion:mytouch]) {
      NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.wordArray];
      NSMutableArray *subArray = [[NSMutableArray alloc] initWithArray:[array objectAtIndex:mytouch.y]];
    if ([self isTextFieldCellWithPostion:mytouch]) {
        [subArray replaceObjectAtIndex:mytouch.x withObject:@"0"];
      node.texture = [self.puzzleGame.theme blockCellTexture];
    } else {
        [subArray replaceObjectAtIndex:mytouch.x withObject:@"1"];
        node.texture = [self.puzzleGame.theme fillCellTexture];
    }
      [array replaceObjectAtIndex:mytouch.y withObject:subArray];
      self.wordArray = array;
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

- (void)handleIfMapIsCorrect {
  [self initHorProblemNumber];
  [self initVerProblemNumber];
  if ([self.delegate respondsToSelector:@selector(createGameSceneGridHasFinishCreateWithNumberArrayOfHorAnswerWords:andVerAnswerWords:)]) {
    [self. delegate createGameSceneGridHasFinishCreateWithNumberArrayOfHorAnswerWords:[self createHorProblemAndQuestionArray] andVerAnswerWords:[self createVerProblemAndQuestionArray]];
  }
}

- (NSArray *)createHorProblemAndQuestionArray {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.horProblemNumberArray.count; i ++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@"" forKey:@"question"];
        [dic setValue:@"" forKey:@"answer"];
        [dic setValue:[self.horProblemNumberArray objectAtIndex:i] forKey:@"count"];
        [array addObject:dic];
    }
    return array;
}

- (NSArray *)createVerProblemAndQuestionArray {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.verProblemNumberArray.count; i ++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@"" forKey:@"question"];
        [dic setValue:@"" forKey:@"answer"];
        [dic setValue:[self.verProblemNumberArray objectAtIndex:i] forKey:@"count"];
        [array addObject:dic];
    }
    return array;
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
        if (self.currentProblemNumber > 0) {
            if (self.hor) {
                CGPoint mytouch = [[self.horProblemArray objectAtIndex:self.currentProblemNumber - 1] CGPointValue];
                [self unFillingLeft:mytouch];
                [self unFillingRight:mytouch];
            } else {
                CGPoint mytouch = [[self.verProblemArray objectAtIndex:self.currentProblemNumber - 1] CGPointValue];
                [self unFillDown:mytouch];
                [self unFillUp:mytouch];
            }
        }
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

@end
