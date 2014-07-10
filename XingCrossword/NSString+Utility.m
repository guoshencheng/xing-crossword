//
//  NSString+Utility.m
//  XingCrossword
//
//  Created by Sherlock on 7/10/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "NSString+Utility.h"

@implementation NSString (Utility)

- (NSArray *)letterArray {
  NSMutableArray *letterArray = [NSMutableArray arrayWithCapacity:[self length]];
  for (int i = 0; i < [self length]; i++) {
    NSString *ch = [self substringWithRange:NSMakeRange(i, 1)];
    [letterArray addObject:ch];
  }
  return letterArray;
}

@end
