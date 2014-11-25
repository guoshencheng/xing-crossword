//
//  CreateGameScene.h
//  XingCrossword
//
//  Created by apple on 14-9-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CreateGameScene : SKScene

@property (assign, nonatomic) BOOL isCreateMap;
@property (strong, nonatomic) SKSpriteNode *puzzle;
@property (strong, nonatomic) NSArray *wordArray;
@property (assign, nonatomic) NSInteger wordArrayXMaxNumber;
@property (assign, nonatomic) NSInteger wordArrayYMaxNumber;

@end
