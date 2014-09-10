//
//  Item+DataManager.m
//  XingCrossword
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Item+DataManager.h"
#import "Puzzle+DataManager.h"

@implementation Item (DataManager)

+ (NSString *)findHintByDirection:(NSNumber *)direction andOrder:(NSNumber *)order andPuzzleId:(NSString *)puzzleId {
  Item *item = [self findWithDirection:direction andOrder:order andPuzzleId:puzzleId];
  return item.hint;
}

+ (NSString *)findWordByDirection:(NSNumber *)direction andOrder:(NSNumber *)order andPuzzleId:(NSString *)puzzleId {
  Item *item = [self findWithDirection:direction andOrder:order andPuzzleId:puzzleId];
  return item.word;
}

+ (NSString *)findInputByDirection:(NSNumber *)direction andOrder:(NSNumber *)order andPuzzleId:(NSString *)puzzleId {
  Item *item = [self findWithDirection:direction andOrder:order andPuzzleId:puzzleId];
  return item.input;
}

+ (NSArray *)findAllItemInPuzzleWithPuzzleId:(NSString *)puzzleId {
  Puzzle *puzzle = [Puzzle findByPuzzleid:puzzleId];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"puzzle == %@", puzzle];
  return [Item MR_findAllWithPredicate:predicate];
}

+ (void)saveInputbyDirection:(NSNumber *)direction andOrder:(NSNumber *)order andPuzzleId:(NSString *)puzzleId andInputString:(NSString *)input completion:(MRSaveCompletionHandler)completion {
  [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
    Item *item = [self getItemWithDirection:direction andOrder:order andPuzzleId:puzzleId inContext:localContext];
    item.input = input;
  } completion:completion];
}

+ (Item *)findWithDirection:(NSNumber *)direction andOrder:(NSNumber *)order andPuzzleId:(NSString *)puzzleId {
  Puzzle *puzzle = [Puzzle findByPuzzleid:puzzleId];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"puzzle == %@ && direction == %@ && order == %@", puzzle, direction, order];
  return [Item MR_findFirstWithPredicate:predicate];
}

+ (Item*)findOrCreateWithDirection:(NSNumber*)direction andOrder:(NSNumber *)order andPuzzleId:(NSString *)puzzleId  inContext:(NSManagedObjectContext*)context {
  Item *item = [self getItemWithDirection:direction andOrder:order andPuzzleId:puzzleId inContext:context];
  if (!item) {
    item = [Item MR_createInContext:context];
    item.order = order;
    item.direction = direction;
  }
  return  item;
}

#pragma mark - Private Methods

+(Item*)getItemWithDirection:(NSNumber*)direction andOrder:(NSNumber *)order andPuzzleId:(NSString *)puzzleId  inContext:(NSManagedObjectContext*)context {
  Puzzle *puzzle = [Puzzle findByPuzzleid:puzzleId inContext:context];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"puzzle == %@ && direction == %@ && order == %@", puzzle, direction, order];
  return [Item MR_findFirstWithPredicate:predicate inContext:context];
}

@end
