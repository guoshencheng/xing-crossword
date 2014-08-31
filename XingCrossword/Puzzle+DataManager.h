//
//  Puzzle+DataManager.h
//  XingCrossword
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Puzzle.h"
#import "PuzzleTool.h"

@interface Puzzle (DataManager)

+ (NSArray*)findAllPuzzle;
+ (void)createPuzzleWithResponse:(NSDictionary*)response completion:(void(^)(BOOL success, NSError *error))completion;
+ (void)createPuzzleWithPuzzle:(PuzzleTool *)puzzleTool completion:(void (^)(BOOL, NSError *))completion;
+ (Puzzle*)findByPuzzleid:(NSString*)puzzleId;
+ (id)getPuzzleWithPuzzleid:(NSString*)puzzleId inContext:(NSManagedObjectContext *)context;

@end
