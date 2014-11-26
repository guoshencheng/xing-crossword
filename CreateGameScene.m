//
//  CreateGameScene.m
//  XingCrossword
//
//  Created by apple on 14-9-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CreateGameScene.h"
#import "PuzzleGame.h"

@implementation CreateGameScene

- (id)initWithSize:(CGSize)size {
  self.puzzleId = @"myPuzzle";
  self.isCreateMap = YES;
  if (self = [super initWithSize:size]) {
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
  }
}

- (BOOL)isACorrectMap {
  return YES;
}
#pragma mark - PostionHandler
- (BOOL)isInGridWithPostion:(CGPoint)mytouch {
  return  (mytouch.x >= 0 && mytouch.y >= 0 && mytouch.x < self.wordArrayXMaxNumber && mytouch.y < self.wordArrayYMaxNumber);
  
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

#pragma mark - Other

- (CGPoint) getCellPostionWithNodeName:(NSString*)nodeName {
  NSArray *strings = [nodeName componentsSeparatedByString:@","];
  float xValue = [[strings objectAtIndex:0]floatValue];
  float yValue = [[strings objectAtIndex:1]floatValue];
  return CGPointMake(xValue, yValue);
}

#pragma mark - colorsFilling

- (void)resetColor {
  for (int i = 0; i < self.wordArray.count; i++) {
    NSArray *currentArray = [self.wordArray objectAtIndex:i];
    for (int j = 0; j < currentArray.count; j++) {
      NSString *currentValue = [currentArray objectAtIndex:j];
      if ([currentValue isEqualToString:@"1"]) {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzle childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)j,(int)i]];
        currentnode.texture = [SKTexture textureWithImageNamed:@"empty.png"];
      } else {
        SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzle childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)j,(int)i]];
        currentnode.texture = [SKTexture textureWithImageNamed:@"block.png"];
      }
    }
  }
}

- (void)fillDown:(CGPoint)point {
  if ([self isHaveDownTextFieldCellWithPostion:point]) {
    SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzle childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
    currentnode.texture = [SKTexture textureWithImageNamed:@"fill.png"];
    
    [self fillDown:CGPointMake(point.x, point.y + 1)];
  } else {
    SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzle childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
    currentnode.texture = [SKTexture textureWithImageNamed:@"fill.png"];
  }
}

- (void)fillUp:(CGPoint)point {
  if ([self isHaveUpTextFieldCellWithPostion:point]) {
    SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzle childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
    currentnode.texture = [SKTexture textureWithImageNamed:@"fill.png"];
    
    [self fillUp:CGPointMake(point.x, point.y - 1)];
  } else {
    SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzle childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
    currentnode.texture = [SKTexture textureWithImageNamed:@"fill.png"];
  }
}

- (void)fillingLeft:(CGPoint)point {
  if ([self haveLeftTextFieldCellWithPostion:point]) {
    SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzle childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
    currentnode.texture = [SKTexture textureWithImageNamed:@"fill.png"];
    [self fillingLeft:CGPointMake(point.x - 1, point.y)];
  } else {
    SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzle childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
    currentnode.texture = [SKTexture textureWithImageNamed:@"fill.png"];
  }
}

- (void)fillingRight:(CGPoint)point {
  if ([self haveRightTextFieldCellWithPostion:point]) {
    SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzle childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
    currentnode.texture = [SKTexture textureWithImageNamed:@"fill.png"];
    
    [self fillingRight:CGPointMake(point.x + 1, point.y)];
  } else {
    SKSpriteNode * currentnode = (SKSpriteNode*)[self.puzzle childNodeWithName:[NSString stringWithFormat:@"%d,%d",(int)point.x,(int)point.y]];
    currentnode.texture = [SKTexture textureWithImageNamed:@"fill.png"];
  }
}

#pragma mark - problemArray 

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

@end
