//
//  Item+DataManager.m
//  XingCrossword
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Item+DataManager.h"
#import "CoreData+MagicalRecord.h"
#import "Puzzle+DataManager.h"

@implementation Item (DataManager)

+ (Item*)createAcrossItemWithOrder:(NSDictionary *)response andOrder:(NSNumber *)order completion:(void(^)(BOOL success, NSError *error))completion {
  NSDictionary *hints = [response objectForKey:@"hints"];
  NSDictionary *words = [response objectForKey:@"words"];
  NSString *puzzleId = [response objectForKey:@"id"];
  NSArray *acrossHints = [hints objectForKey:@"across"];
  NSArray *acrossWords = [words objectForKey:@"across"];
  NSString *acrossHint = [acrossHints objectAtIndex:[order intValue] - 1];
  NSString *acrossWord = [acrossWords objectAtIndex:[order intValue] - 1];
  __block Item *item;
  [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
    item = [self findOrCreateWithDirection:@(0) andOrder:order andPuzzleId:puzzleId inContext:localContext];
    item.hint = acrossHint;
    item.word = acrossWord;
    Puzzle *puzzle = [Puzzle getPuzzleWithPuzzleid:puzzleId inContext:localContext];
    item.puzzle = puzzle;
  }];
  return item;
}

+ (Item*)createDownItemWithOrder:(NSDictionary *)response andOrder:(NSNumber *)order completion:(void(^)(BOOL success, NSError *error))completion {
  NSDictionary *hints = [response objectForKey:@"hints"];
  NSDictionary *words = [response objectForKey:@"words"];
  NSString *puzzleId = [response objectForKey:@"id"];
  NSArray *downHints = [hints objectForKey:@"down"];
  NSArray *downWords = [words objectForKey:@"down"];
  NSString *downHint = [downHints objectAtIndex:[order intValue] - 1];
  NSString *downWord = [downWords objectAtIndex:[order intValue] - 1];
  __block Item *item;
  [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
    item = [self findOrCreateWithDirection:@(1) andOrder:order andPuzzleId:puzzleId inContext:localContext];
    item.hint = downHint;
    item.word = downWord;
    Puzzle *puzzle = [Puzzle getPuzzleWithPuzzleid:puzzleId inContext:localContext];
    item.puzzle = puzzle;
  }];
  return item;
}

+ (Item*)findByDirection:(NSNumber*)direction andOrder:(NSNumber *)order andPuzzleId:(NSString *)puzzleId {
  Puzzle *puzzle = [Puzzle findByPuzzleid:puzzleId];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"puzzle == %@ AND direction == %@ AND order == %@", puzzle, direction, order];
  return [Item MR_findFirstWithPredicate:predicate];
}


#pragma mark - Private Methods

+ (Item*)findOrCreateWithDirection:(NSNumber*)direction andOrder:(NSNumber *)order andPuzzleId:(NSString *)puzzleId  inContext:(NSManagedObjectContext*)context {
  Item *item = [self getItemWithDirection:direction andOrder:order andPuzzleId:puzzleId inContext:context];
  if (!item) {
    item = [Item MR_createInContext:context];
    item.order = order;
    item.direction = direction;
  }
  return  item;
}

+(Item*)getItemWithDirection:(NSNumber*)direction andOrder:(NSNumber *)order andPuzzleId:(NSString *)puzzleId  inContext:(NSManagedObjectContext*)context {
  Puzzle *puzzle = [Puzzle findByPuzzleid:puzzleId];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"puzzle == %@ AND direction == %@ AND order == %@", puzzle, direction, order];
  return [Item MR_findFirstWithPredicate:predicate inContext:context];
}

@end
