//
//  CreateGameScene.h
//  XingCrossword
//
//  Created by apple on 14-9-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol CreateGameSceneDelegate;

@interface CreateGameScene : SKScene

@property (strong, nonatomic) NSString *puzzleId;
@property (strong, nonatomic) NSMutableArray *horProblemArray;
@property (strong, nonatomic) NSMutableArray *verProblemArray;
@property (strong, nonatomic) NSMutableArray *horProblemNumberArray;
@property (strong, nonatomic) NSMutableArray *verProblemNumberArray;
@property (assign, nonatomic) NSInteger currentProblemNumber;
@property (assign, nonatomic) BOOL hor;
@property (assign, nonatomic) BOOL isCreateMap;
@property (strong, nonatomic) SKSpriteNode *puzzle;
@property (strong, nonatomic) NSArray *wordArray;
@property (assign, nonatomic) NSInteger wordArrayXMaxNumber;
@property (assign, nonatomic) NSInteger wordArrayYMaxNumber;

@property (weak, nonatomic) id<CreateGameSceneDelegate> delegate;

- (BOOL)isACorrectMap;
- (void)handleIfMapIsCorrect;

@end


@protocol CreateGameSceneDelegate <NSObject>

- (void)createGameSceneGridHasFinishCreateWithNumberArrayOfHorAnswerWords:(NSArray *)horAnswer andVerAnswerWords:(NSArray *)verAnswer;

@end