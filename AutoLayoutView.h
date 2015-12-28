//
//  AutoLayoutView.h
//  Easyell
//
//  Created by guoshencheng.
//  Copyright (c) 2015 Easyell, Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
  NSLayoutAttribute fromAttribute;
  NSLayoutRelation relation;
  NSLayoutAttribute toAttribute;
  CGFloat multiplier;
  CGFloat constant;
} AutoLayoutPredicate;

static inline AutoLayoutPredicate
AutoLayoutPredicateEasyMake(NSLayoutAttribute attribute, CGFloat constant) {
  AutoLayoutPredicate predicate;
  predicate.fromAttribute = attribute;
  predicate.relation = NSLayoutRelationEqual;
  predicate.toAttribute = attribute;
  predicate.multiplier = 1;
  predicate.constant = constant;
  return predicate;
}

static inline AutoLayoutPredicate
AutoLayoutPredicateMake(NSLayoutAttribute fromAttribute, NSLayoutAttribute toAttribute, CGFloat constant) {
  AutoLayoutPredicate predicate;
  predicate.fromAttribute = fromAttribute;
  predicate.relation = NSLayoutRelationEqual;
  predicate.toAttribute = toAttribute;
  predicate.multiplier = 1;
  predicate.constant = constant;
  return predicate;
}

static inline AutoLayoutPredicate
AutoLayoutPredicateFullMake(NSLayoutAttribute fromAttribute, NSLayoutRelation relation, NSLayoutAttribute toAttribute, CGFloat multiplier, CGFloat constant) {
  AutoLayoutPredicate predicate;
  predicate.fromAttribute = fromAttribute;
  predicate.relation = relation;
  predicate.toAttribute = toAttribute;
  predicate.multiplier = multiplier;
  predicate.constant = constant;
  return predicate;
}

/**
 * Note: there is a known BUG in this class.
 * When each time the setXXX method is called, the class will try to remove the old constraint first,
 * it will find the new constraint's container view first and remove the old one from it,
 * so Make Sure the new constraint will have the same container view with the old onw.
**/

@interface AutoLayoutView : UIView

+ (instancetype)create;

- (void)setHeightConstant:(CGFloat)height;
- (void)setWidthConstant:(CGFloat)width;

- (void)setLeftSpace:(CGFloat)space;
- (void)setRightSpace:(CGFloat)space;
- (void)setTopSpace:(CGFloat)space;
- (void)setBottomSpace:(CGFloat)space;

- (void)setLeftSpace:(CGFloat)space toView:(UIView *)referenceView;
- (void)setRightSpace:(CGFloat)space toView:(UIView *)referenceView;
- (void)setTopSpace:(CGFloat)space toView:(UIView *)referenceView;
- (void)setBottomSpace:(CGFloat)space toView:(UIView *)referenceView;

- (void)updateLeftSpace:(CGFloat)space;
- (void)updateRightSpace:(CGFloat)space;
- (void)updateTopSpace:(CGFloat)space;
- (void)updateBottomSpace:(CGFloat)space;
- (void)updateHeightConstant:(CGFloat)height;
- (void)updateWidthConstant:(CGFloat)width;
- (void)updateWihtFrame:(CGRect)frame;

- (void)addGestureRecognizerToView:(UIView *)view target:(id)target action:(SEL)action;

- (CGFloat)topSpace;
- (CGFloat)leftSpace;
- (CGFloat)rightSpace;
- (CGFloat)bottomSpace;
- (CGFloat)widthConstant;
- (CGFloat)heightConstant;

@end
