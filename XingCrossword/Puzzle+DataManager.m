//
//  Puzzle+DataManager.m
//  XingCrossword
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Puzzle+DataManager.h"
#import "CoreData+MagicalRecord.h"

@implementation Puzzle (DataManager)

+ (void)createPuzzleWithResponse:(NSDictionary*)response {
  NSString *puzzleId = [response objectForKey:@"id"];
  [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
    Puzzle *puzzle = [self findOrCreateWithPuzzleid:puzzleId inContext:localContext];
    NSString *map = [response objectForKey:@"map"];
    NSString *title = [response objectForKey:@"title"];
    puzzle.title = title;
    puzzle.map = map;
  } completion:nil];
}

+ (NSString*)getMapWithPuzzleid:(NSString*)puzzleId {
  Puzzle *puzzle = [Puzzle MR_findFirstByAttribute:@"puzzleId" withValue:puzzleId];
  return puzzle.map;
}

#pragma mark - Private 

+ (id)findOrCreateWithPuzzleid:(NSString*)puzzleId inContext:(NSManagedObjectContext *)context {
  Puzzle *puzzle = [self getPuzzleWithPuzzleid:puzzleId inContext:context];
  if (!puzzle) {
    puzzle = [Puzzle MR_createInContext:context];
    puzzle.puzzleId = puzzleId;
  }
  return puzzle;
}

+ (id)getPuzzleWithPuzzleid:(NSString*)puzzleId inContext:(NSManagedObjectContext *)context {
  return [Puzzle MR_findFirstByAttribute:@"puzzleId" withValue:puzzleId inContext:context];
}

@end
