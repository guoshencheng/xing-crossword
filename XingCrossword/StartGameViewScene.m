//
//  StartGameViewScene.m
//  ;;
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "WebService.h"
#import "StartGameViewScene.h"
#import "Puzzle+DataManager.h"
@implementation StartGameViewScene

- (void)didMoveToView:(SKView *)view {
}

-(id)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {
    self.webService = [[WebService alloc] init];
    self.webService.delegate = self;
    [self.webService getAllPuzzleResponse];
  }
  return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   for (UITouch *touch in touches) {
     CGPoint location = [touch locationInNode:self];
     SKNode *node = [self nodeAtPoint:location];
     if ([self.delegate respondsToSelector:@selector(startGameViewSceneShouldPushMainGameController:withPuzzletitle:)]) {
       [self.delegate startGameViewSceneShouldPushMainGameController:self withPuzzletitle:node.name];
     }
   }
}

-(void)update:(CFTimeInterval)currentTime {
  /* Called before each frame is rendered */
}

#pragma mark - Private Method

- (void)initPuzzleTableList {
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

#pragma mark - Private Method

- (void)webServiceDidGetAllPuzzleResponse:(WebService *)webService {
  [self.webService savaAllPuzzleResponseWithCompletion:^(BOOL success, NSError *error) {
    if ([Puzzle findAllPuzzle]) {
      [self initPuzzleTableList];
    } else {
      
    }
  }];
}

@end

