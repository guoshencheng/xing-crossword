//
//  Puzzle+DataManager.h
//  XingCrossword
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Puzzle.h"

@interface Puzzle (DataManager)

+ (void)createPuzzleWithResponse:(NSDictionary*)response;
+ (NSString*)getMapWithPuzzleid:(NSString*)puzzleId;

@end
