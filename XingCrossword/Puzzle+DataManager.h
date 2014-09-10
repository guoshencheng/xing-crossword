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

+ (Puzzle*)findByPuzzleid:(NSString*)puzzleId;
+ (NSArray*)findAllPuzzle;
+ (void)createPuzzleWithResponse:(NSDictionary*)response completion:(void(^)(BOOL success, NSError *error))completion;
+(void)createPuzzleWithPuzzle:(PuzzleTool *)puzzleTool acrossHint:(NSArray *)acrossHint acrossWord:(NSArray *)acrossWord downHint:(NSArray *)downHint downWord:(NSArray *)downWord completion:(void (^)(BOOL, NSError *))completion;
+ (Puzzle*)findByPuzzleid:(NSString*)puzzleId inContext:(NSManagedObjectContext *)context;
+ (Puzzle *)findByPuzzletitle:(NSString *)title;
+ (id)getPuzzleWithPuzzleid:(NSString*)puzzleId inContext:(NSManagedObjectContext *)context;

@end
