//
//  Item+DataManager.h
//  XingCrossword
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Item.h"
#import "ItemTool.h"

@interface Item (DataManager)

+ (void)createItemWithItemTool:(ItemTool *)itemtool andPuzzleId:(NSString *)puzzleId completion:(void(^)(BOOL success, NSError *error))completion;
+ (Item*)createAcrossItemWithOrder:(NSDictionary *)response andOrder:(NSNumber *)order completion:(void(^)(BOOL success, NSError *error))completion;
+ (Item*)createDownItemWithOrder:(NSDictionary *)response andOrder:(NSNumber *)order completion:(void(^)(BOOL success, NSError *error))completion;
+ (Item*)findByDirection:(NSNumber*)direction andOrder:(NSNumber*)order andPuzzleId:(NSString*)puzzleId;

@end
