//
//  Item+Utility.m
//  XingCrossword
//
//  Created by Sherlock on 7/10/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "Item+Utility.h"

@implementation Item (Utility)

- (BOOL)isAcrossItem {
  return ItemDirectionAcross == [self.direction intValue];
}

- (BOOL)isDownItem {
  return ItemDirectionDown == [self.direction intValue];
}

@end
