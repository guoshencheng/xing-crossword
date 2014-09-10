//
//  StartGameViewScene.m
//  ;;
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "WebService.h"
#import "Item+DataManager.h"
#import "CoreData+MagicalRecord.h"
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
     if ([node.name  isEqual: @"text"]) {
       node = node.parent;
     }
     NSDictionary *dictionary = [self getTitleAndId:node.name];
     if ([self.delegate respondsToSelector:@selector(startGameViewSceneShouldPushMainGameController:withPuzzletitle:andPuzzleId:)]) {
       [self.delegate startGameViewSceneShouldPushMainGameController:self withPuzzletitle:[dictionary objectForKey:@"title"] andPuzzleId:[dictionary objectForKey:@"id"]];
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
    [currentSpriteNode setName:[NSString stringWithFormat:@"%@--%@",currentPuzzle.puzzleId,currentPuzzle.title]];
    currentSpriteNode.position = CGPointMake(160, 390 - i * 50);
    SKLabelNode *currentLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    currentLabelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    currentLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    currentLabelNode.fontSize = 12;
    currentLabelNode.fontColor = [UIColor blackColor];
    [currentLabelNode setName:@"text"];
    [currentLabelNode setText:[NSString stringWithFormat:@"%@-%@",currentPuzzle.puzzleId,currentPuzzle.title]];
    [currentLabelNode setUserInteractionEnabled:NO];
    [currentSpriteNode addChild:currentLabelNode];
    [self addChild:currentSpriteNode];
  }
}

- (void)webServiceDidGetAllPuzzleResponse:(WebService *)webService {
  [self.webService savaAllPuzzleResponseWithCompletion:^(BOOL success, NSError *error) {
    if ([Puzzle findAllPuzzle]) {
      [self initPuzzleTableList];
    } else {
      
    }
  }];
}

- (NSDictionary *) getTitleAndId:(NSString*)nodeName {
  NSArray *strings = [nodeName componentsSeparatedByString:@"--"];
  NSMutableDictionary *infoDictionary = [[NSMutableDictionary alloc] init];
  [infoDictionary setValue:[strings objectAtIndex:0] forKey:@"id"];
  [infoDictionary setValue:[strings objectAtIndex:1] forKey:@"title"];
  return infoDictionary;
}

@end

