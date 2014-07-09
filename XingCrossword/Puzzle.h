//
//  Puzzle.h
//  XingCrossword
//
//  Created by Sherlock on 7/9/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface Puzzle : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * puzzleId;
@property (nonatomic, retain) NSString * map;
@property (nonatomic, retain) NSSet *items;
@end

@interface Puzzle (CoreDataGeneratedAccessors)

- (void)addItemsObject:(Item *)value;
- (void)removeItemsObject:(Item *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
