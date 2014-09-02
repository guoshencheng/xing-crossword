//
//  Puzzle+DataManager.m
//  XingCrossword
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Puzzle+DataManager.h"
#import "Item+DataManager.h"
#import "CoreData+MagicalRecord.h"

@implementation Puzzle (DataManager)

+ (NSArray*)findAllPuzzle {
  return [Puzzle MR_findAll];
}

+ (void)createPuzzleWithResponse:(NSDictionary*)response completion:(void(^)(BOOL success, NSError *error))completion{
  NSString *puzzleId = [response objectForKey:@"id"];
  [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
    Puzzle *puzzle = [self findOrCreateWithPuzzleid:puzzleId inContext:localContext];
    NSString *map = [response objectForKey:@"map"];
    NSString *title = [response objectForKey:@"title"];
    puzzle.title = title;
    puzzle.map = map;
  } completion:completion];
}

+(void)createPuzzleWithPuzzle:(PuzzleTool *)puzzleTool acrossHint:(NSArray *)acrossHint acrossWord:(NSArray *)acrossWord downHint:(NSArray *)downHint downWord:(NSArray *)downWord completion:(void (^)(BOOL success, NSError *error))completion {
  [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
    Puzzle *puzzle = [self findOrCreateWithPuzzleid:puzzleTool.puzzleId inContext:localContext];
    puzzle.title = puzzleTool.title;
    puzzle.map = puzzleTool.map;
    for (int i = 0;i < acrossHint.count;i ++)
    {
      Item *item = [Item findOrCreateWithDirection:@(0) andOrder:@(i) andPuzzleId:puzzleTool.puzzleId inContext:localContext];
      item.hint = [acrossHint objectAtIndex:i];
      item.word = [acrossWord objectAtIndex:i];
      item.direction = @(0);
      item.order = @(i);
      item.puzzle = puzzle;
    }
    
    for (int i =0; i < downHint.count; i ++) {
      Item *item = [Item findOrCreateWithDirection:@(1) andOrder:@(i) andPuzzleId:puzzleTool.puzzleId inContext:localContext];
      item.hint = [downHint objectAtIndex:i];
      item.word = [downWord objectAtIndex:i];
      item.direction = @(1);
      item.order = @(i);
      item.puzzle = puzzle;
    }
  } completion:completion];
}

+ (Puzzle*)findByPuzzleid:(NSString*)puzzleId {
  return  [Puzzle MR_findFirstByAttribute:@"puzzleId" withValue:puzzleId];
}

+(Puzzle *)findByPuzzletitle:(NSString *)title {
  return  [Puzzle MR_findFirstByAttribute:@"title" withValue:title];
}

#pragma mark - Private Methods

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
