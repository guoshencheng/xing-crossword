//
//  UIView+CommonSuperview.m
//  Easyell
//
//  Created by guoshencheng.
//  Copyright (c) 2015 Easyell, Ltd. All rights reserved.
//

#import "UIView+CommonSuperview.h"

@implementation UIView (CommonSuperview)

#pragma mark - Public Methods

- (UIView *)commonSuperviewWithView:(UIView *)view {
  if (!view) {
    return self;
  } else if (self.superview == view) {
    return view;
  } else if (self == view.superview) {
    return self;
  } else if (self.superview == view.superview) {
    return self.superview;
  } else {
    UIView *commonSuperview = [self traverseViewTreeForCommonSuperViewWithView:view];
    NSAssert(commonSuperview, @"Cannot find common superview of %@ and %@. Finding common superview in view tree not implemented yet", self, view);
    return commonSuperview;
  }
}

#pragma mark - Private Methods

- (UIView *)traverseViewTreeForCommonSuperViewWithView:(UIView*)view {
  NSMutableOrderedSet *selfSuperviews = [NSMutableOrderedSet orderedSet];
  UIView *selfSuperview = self;
  while (selfSuperview) {
    [selfSuperviews addObject:selfSuperview];
    selfSuperview = selfSuperview.superview;
  }
  UIView *superview = view;
  while (superview) {
    if ([selfSuperviews containsObject:superview]) {
      return superview;
    }
    superview = superview.superview;
  }
  return nil;
}

@end
