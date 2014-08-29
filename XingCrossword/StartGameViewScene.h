//
//  StartGameViewScene.h
//  XingCrossword
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "WebService.h"

@protocol StartGameViewSceneDelegate;

@interface StartGameViewScene : SKScene <WebServiceDelegate>

@property WebService *webService;
@property NSArray *puzzleArray;
@property id<StartGameViewSceneDelegate> delegate;

@end
