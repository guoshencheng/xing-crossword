//
//  Item+DataManager.h
//  XingCrossword
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Item.h"

@interface Item (DataManager)

- (void)saveItemWithOrder:(NSDictionary*)response;
- (void)findByDirection:(NSNumber*)direction andOrder:(NSNumber*)order andPuzzleId:(NSString*)puzzleId;

@end
