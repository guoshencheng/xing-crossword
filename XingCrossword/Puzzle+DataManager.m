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

+ (void)createPuzzleWithResponse:(NSDictionary*)response completion:(void(^)(BOOL success, NSError *error))completion {
  NSString *puzzleId = [response objectForKey:@"id"];
  [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
    Puzzle *puzzle = [self findOrCreateWithPuzzleid:puzzleId inContext:localContext];
    NSString *map = [response objectForKey:@"map"];
    NSString *title = [response objectForKey:@"title"];
    puzzle.title = title;
    puzzle.map = map;
  } completion:completion];
}

+ (void)createPuzzleWithGrid:(NSArray *)grid completion:(void(^)(BOOL success, NSError *error))completion {
  [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
    Puzzle *puzzle = [self findOrCreateWithPuzzleid:@"myPuzzle" inContext:localContext];
    puzzle.map = [self changeToStringFromArray:grid];
  } completion:completion];
}

+ (void)createPuzzleWithCrossHint:(NSArray *)hintArray CrossWord:(NSArray *)wordArray completion:(void(^)(BOOL success, NSError *error))completion {
  [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
    Puzzle *puzzle = [self findOrCreateWithPuzzleid:@"myPuzzle" inContext:localContext];
    for (int i = 0; i < wordArray.count; i ++) {
      Item *item = [Item findOrCreateWithDirection:@(0) andOrder:@(i) andPuzzleId:@"myPuzzle" inContext:localContext];
      item.hint = [hintArray objectAtIndex:i];
      item.word = [wordArray objectAtIndex:i];
      item.direction = @(0);
      item.order = @(i);
      item.puzzle = puzzle;
    }
  } completion:completion];
}

+ (void)createPuzzleWithDownHint:(NSArray *)hintArray DownWord:(NSArray *)wordArray completion:(void(^)(BOOL success, NSError *error))completion {
  [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
    Puzzle *puzzle = [self findOrCreateWithPuzzleid:@"myPuzzle" inContext:localContext];
    for (int i = 0; i < wordArray.count; i ++) {
      Item *item = [Item findOrCreateWithDirection:@(1) andOrder:@(i) andPuzzleId:@"myPuzzle" inContext:localContext];
      item.hint = [hintArray objectAtIndex:i];
      item.word = [wordArray objectAtIndex:i];
      item.direction = @(1);
      item.order = @(i);
      item.puzzle = puzzle;
    }
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

+ (Puzzle*)findByPuzzleid:(NSString*)puzzleId inContext:(NSManagedObjectContext *)context {
  return  [Puzzle MR_findFirstByAttribute:@"puzzleId" withValue:puzzleId inContext:context];
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

+ (NSString*)changeToStringFromArray:(NSArray *)stringArray {
  NSString *gridString = @"";
  for (NSArray *array  in stringArray) {
    NSString *rowString = @"";
    for (int i = 0; i < array.count; i ++) {
      rowString = [NSString stringWithFormat:@"%@%@",rowString,array[i]];
    }
    gridString = [NSString stringWithFormat:@"%@,%@",gridString,rowString];
  }
  return gridString;
}

@end
