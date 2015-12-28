//
//  AutoLayoutView.m
//  Easyell
//
//  Created by guoshencheng.
//  Copyright (c) 2015 Easyell, Ltd. All rights reserved.
//

#import "AutoLayoutView.h"
#import "UIView+CommonSuperview.h"

@interface AutoLayoutView ()

@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *widthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *topConstraint;
@property (nonatomic, strong) NSLayoutConstraint *rightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *bottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint *leftConstraint;

@end

@implementation AutoLayoutView

#pragma mark - Override Methods

- (void)removeFromSuperview {
  NSMutableArray *constraintsToRemove = [NSMutableArray new];
  UIView *superview = self.superview;
  for (NSLayoutConstraint * constraint in superview.constraints) {
    if (constraint.firstItem == self || constraint.secondItem == self) {
      [constraintsToRemove addObject:constraint];
    }
  }
  [superview removeConstraints:constraintsToRemove];
  [super removeFromSuperview];
  self.topConstraint = nil;
  self.rightConstraint = nil;
  self.bottomConstraint = nil;
  self.leftConstraint = nil;
}

#pragma mark - Public Methods

+ (instancetype)create {
  NSAssert(false, @"-base autolayout view should never be created without subclass");
  return nil;
}

- (void)addGestureRecognizerToView:(UIView *)view target:(id)target action:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [view addGestureRecognizer:tap];
}

- (void)setHeightConstant:(CGFloat)height {
  AutoLayoutPredicate predicate = AutoLayoutPredicateEasyMake(NSLayoutAttributeHeight, height);
  self.heightConstraint = [self updateConstraint:self.heightConstraint withPredicate:predicate toView:nil];
}

- (void)setWidthConstant:(CGFloat)width {
  AutoLayoutPredicate predicate = AutoLayoutPredicateEasyMake(NSLayoutAttributeWidth, width);
  self.widthConstraint = [self updateConstraint:self.widthConstraint withPredicate:predicate toView:nil];
}

- (void)setLeftSpace:(CGFloat)space {
  AutoLayoutPredicate predicate = AutoLayoutPredicateEasyMake(NSLayoutAttributeLeft, space);
  self.leftConstraint = [self updateConstraint:self.leftConstraint withPredicate:predicate toView:self.superview];
}

- (void)setRightSpace:(CGFloat)space {
  AutoLayoutPredicate predicate = AutoLayoutPredicateEasyMake(NSLayoutAttributeRight, space);
  self.rightConstraint = [self updateConstraint:self.rightConstraint withPredicate:predicate toView:self.superview];
}

- (void)setTopSpace:(CGFloat)space {
  AutoLayoutPredicate predicate = AutoLayoutPredicateEasyMake(NSLayoutAttributeTop, space);
  self.topConstraint = [self updateConstraint:self.topConstraint withPredicate:predicate toView:self.superview];
}

- (void)setBottomSpace:(CGFloat)space {
  AutoLayoutPredicate predicate = AutoLayoutPredicateEasyMake(NSLayoutAttributeBottom, space);
  self.bottomConstraint = [self updateConstraint:self.bottomConstraint withPredicate:predicate toView:self.superview];
}

- (void)setLeftSpace:(CGFloat)space toView:(UIView *)referenceView {
  AutoLayoutPredicate predicate = AutoLayoutPredicateMake(NSLayoutAttributeLeft, NSLayoutAttributeRight, space);
  self.leftConstraint = [self updateConstraint:self.leftConstraint withPredicate:predicate toView:referenceView];
}

- (void)setRightSpace:(CGFloat)space toView:(UIView *)referenceView {
  AutoLayoutPredicate predicate = AutoLayoutPredicateMake(NSLayoutAttributeRight, NSLayoutAttributeLeft, space);
  self.rightConstraint = [self updateConstraint:self.rightConstraint withPredicate:predicate toView:referenceView];
}

- (void)setTopSpace:(CGFloat)space toView:(UIView *)referenceView {
  AutoLayoutPredicate predicate = AutoLayoutPredicateMake(NSLayoutAttributeTop, NSLayoutAttributeBottom, space);
  self.topConstraint = [self updateConstraint:self.topConstraint withPredicate:predicate toView:referenceView];
}

- (void)setBottomSpace:(CGFloat)space toView:(UIView *)referenceView {
  AutoLayoutPredicate predicate = AutoLayoutPredicateMake(NSLayoutAttributeBottom, NSLayoutAttributeTop, space);
  self.bottomConstraint = [self updateConstraint:self.bottomConstraint withPredicate:predicate toView:referenceView];
}

- (void)updateLeftSpace:(CGFloat)space {
  self.leftConstraint.constant = space;
}

- (void)updateRightSpace:(CGFloat)space {
  self.rightConstraint.constant = space;
}

- (void)updateTopSpace:(CGFloat)space {
  self.topConstraint.constant = space;
}

- (void)updateBottomSpace:(CGFloat)space {
  self.bottomConstraint.constant = space;
}

- (void)updateHeightConstant:(CGFloat)height {
  self.heightConstraint.constant = height;
}

- (void)updateWidthConstant:(CGFloat)width {
  self.widthConstraint.constant = width;
}

- (void)updateWihtFrame:(CGRect)frame {
  [self updateTopSpace:frame.origin.y];
  [self updateLeftSpace:frame.origin.x];
  [self updateHeightConstant:frame.size.height];
  [self updateWidthConstant:frame.size.width];
}

- (CGFloat)topSpace {
  return self.topConstraint.constant;
}

- (CGFloat)leftSpace {
  return self.leftConstraint.constant;
}

- (CGFloat)rightSpace {
  return self.rightConstraint.constant;
}

- (CGFloat)bottomSpace {
  return self.bottomConstraint.constant;
}

- (CGFloat)widthConstant {
  return self.widthConstraint.constant;
}

- (CGFloat)heightConstant {
  return self.heightConstraint.constant;
}

#pragma mark - Private Methods

/**
 * 1. Remove old constraint if exists.
 * 2. Create new constraint based on predicate.
 * 3. Add new constraint to common supperview of self and reference view.
 * 4. Return the new constraint.
**/
- (NSLayoutConstraint *)updateConstraint:(NSLayoutConstraint *)oldConstraint withPredicate:(AutoLayoutPredicate)predicate toView:(UIView *)referenceView {
  UIView *commonSuperview = [self commonSuperviewWithView:referenceView];
  if (oldConstraint) {
    [commonSuperview removeConstraint:oldConstraint];
  }
  NSLayoutConstraint *newConstraint = [NSLayoutConstraint constraintWithItem:self attribute:predicate.fromAttribute relatedBy:predicate.relation toItem:referenceView attribute:predicate.toAttribute multiplier:predicate.multiplier constant:predicate.constant];
  [commonSuperview addConstraint:newConstraint];
  return newConstraint;
}

@end
