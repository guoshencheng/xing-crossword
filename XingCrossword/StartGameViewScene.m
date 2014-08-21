//
//  StartGameViewScene.m
//  ;;
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "StartGameViewScene.h"
#import "Puzzle+DataManager.h"
@implementation StartGameViewScene

- (void)didMoveToView:(SKView *)view {
}

-(id)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {
    self.puzzleArray = [Puzzle findAllPuzzle];
    for (int i = 0;i < self.puzzleArray.count;i ++) {
      SKSpriteNode *currentSpriteNode = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(320, 40)];
      Puzzle *currentPuzzle = [self.puzzleArray objectAtIndex:i];
      [currentSpriteNode setName:currentPuzzle.title];
      currentSpriteNode.position = CGPointMake(160, 390 - i * 50);
      SKLabelNode *currentLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
      currentLabelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
      currentLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
      currentLabelNode.fontSize = 12;
      currentLabelNode.fontColor = [UIColor blackColor];
      [currentLabelNode setName:@"text"];
      [currentLabelNode setText:currentPuzzle.title];
      [currentLabelNode setUserInteractionEnabled:NO];
      [currentSpriteNode addChild:currentLabelNode];
      [self addChild:currentSpriteNode];
    }
  }
  return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  
}

-(void)update:(CFTimeInterval)currentTime {
  /* Called before each frame is rendered */
}

@end

