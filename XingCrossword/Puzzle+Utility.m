//
//  Puzzle+Utility.m
//  XingCrossword
//
//  Created by Sherlock on 7/10/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "Puzzle+Utility.h"
#import "Item+Utility.h"
#import "NSString+Utility.h"

@implementation Puzzle (Utility)

#pragma mark - Public Methods

- (NSArray *)orderedDownItems {
  return [self orderedItemsWithFilter:^BOOL(Item *item) {
    return [item isDownItem];
  }];
}

- (NSArray *)orderedAcrossItems {
  return [self orderedItemsWithFilter:^BOOL(Item *item) {
    return [item isAcrossItem];
  }];
}

- (NSArray *)mapGrid {
  NSArray *rows = [self.map componentsSeparatedByString:@","];
  NSMutableArray *grid = [NSMutableArray arrayWithCapacity:[rows count]];
  for (NSString *row in rows) {
    [grid addObject:[row letterArray]];
  }
  return grid;
}

#pragma mark - Private Methods

- (NSArray *)orderedItemsWithFilter:(BOOL(^)(Item *item))filter {
  if (!filter) {
    return @[];
  }
  NSMutableArray *filteredItems = [NSMutableArray arrayWithCapacity:[self.items count]];
  for (Item *item in self.items) {
    if (filter(item)) {
      [filteredItems addObject:item];
    }
  }
  NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]];
  return [filteredItems sortedArrayUsingDescriptors:sortDescriptors];
}

@end
