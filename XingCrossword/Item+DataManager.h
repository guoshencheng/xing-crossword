//
//  Item+DataManager.h
//  XingCrossword
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Item.h"
#import "ItemTool.h"
#import "CoreData+MagicalRecord.h"

@interface Item (DataManager)

+ (Item*)findOrCreateWithDirection:(NSNumber*)direction andOrder:(NSNumber *)order andPuzzleId:(NSString *)puzzleId  inContext:(NSManagedObjectContext*)context;
+ (void)saveInputbyDirection:(NSNumber *)direction andOrder:(NSNumber *)order andPuzzleId:(NSString *)puzzleId andInputString:(NSString *)input completion:(MRSaveCompletionHandler)completion;
+ (Item *)findWithDirection:(NSNumber *)direction andOrder:(NSNumber *)order andPuzzleId:(NSString *)puzzleId;
+ (NSString *)findHintByDirection:(NSNumber *)direction andOrder:(NSNumber *)order andPuzzleId:(NSString *)puzzleId;
+ (NSString *)findWordByDirection:(NSNumber *)direction andOrder:(NSNumber *)order andPuzzleId:(NSString *)puzzleId;
+ (NSString *)findInputByDirection:(NSNumber *)direction andOrder:(NSNumber *)order andPuzzleId:(NSString *)puzzleId;

@end
