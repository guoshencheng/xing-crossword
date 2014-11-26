//
//  CreateGameScene+PostionHandler.h
//  XingCrossword
//
//  Created by apple on 14-11-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CreateGameScene.h"

@interface CreateGameScene (PostionHandler)

- (BOOL)haveHorTextField:(CGPoint)point;
- (BOOL)haveVerTextField:(CGPoint)point;

- (BOOL)haveLeftTextFieldCellWithPostion:(CGPoint)point;
- (BOOL)haveRightTextFieldCellWithPostion:(CGPoint)point;

- (BOOL)isHaveUpTextFieldCellWithPostion:(CGPoint)point;
- (BOOL)isHaveDownTextFieldCellWithPostion:(CGPoint)point;

- (BOOL)isInGridWithPostion:(CGPoint)mytouch;

- (BOOL)isTextFieldCellWithPostion:(CGPoint)point;

- (SKSpriteNode*)getNodeWithPoint:(CGPoint)point;

- (void)changeDirectionByTouch:(CGPoint)myTouch;

- (NSString*)getStringFromVerCrossWordWithPoint:(CGPoint)point andStringBefore:(NSString*)string;
- (NSString*)getStringFromHorCrossWordWithPoint:(CGPoint)point andStringBefore:(NSString*)string;


@end
