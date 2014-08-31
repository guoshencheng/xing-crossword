//
//  ItemTool.h
//  XingCrossword
//
//  Created by apple on 14-8-29.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PuzzleTool.h"

@interface ItemTool : NSObject

@property  NSNumber * order;
@property  NSString * word;
@property  NSString * hint;
@property  NSString * input;
@property  NSNumber * direction;
@property  PuzzleTool *puzzle;

@end
