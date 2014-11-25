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
  
}

- (void)handleTouchForCreateProblemWithTouch:(UITouch *)touch {
  
}

@end
