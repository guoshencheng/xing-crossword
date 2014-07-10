//
//  Item+DataManager.h
//  XingCrossword
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Item.h"

@interface Item (DataManager)

- (void)saveItemWithOrder:(NSNumber*)order andWord:(NSString*)word andHint:(NSString*)hint andInport:(NSString*)input andDirection:(NSNumber*)direction andPuzzle:(NSManagedObject*)puzzle;
- (void)getItemHintWithOrider:(NSNumber*)order andDirection:(NSNumber*)direction andPuzzle:(NSManagedObject*)puzzle;
- (void)getItemWordWithOrider:(NSNumber*)order andDirection:(NSNumber*)direction andPuzzle:(NSManagedObject*)puzzle;
- (void)getItemInputWithOrider:(NSNumber *)order andDirection:(NSNumber *)direction andPuzzle:(NSManagedObject *)puzzle;

@end
