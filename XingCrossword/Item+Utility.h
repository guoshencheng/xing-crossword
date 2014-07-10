//
//  Item+Utility.h
//  XingCrossword
//
//  Created by Sherlock on 7/10/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "Item.h"

typedef enum {
  ItemDirectionAcross = 0,
  ItemDirectionDown = 1,
} PuzzleItemDirection;

@interface Item (Utility)

- (BOOL)isAcrossItem;
- (BOOL)isDownItem;

@end
