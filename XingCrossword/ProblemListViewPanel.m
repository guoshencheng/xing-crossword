//
//  ProblemListViewPanel.m
//  XingCrossword
//
//  Created by apple on 14-9-19.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Item.h"
#import "ProblemListViewPanel.h"

@implementation ProblemListViewPanel

+ (id)create {
  return [[[NSBundle mainBundle] loadNibNamed:@"ProblemListViewPanel" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  [self.tableView registerNib:[UINib nibWithNibName:@"ProblemListViewCell" bundle:nil] forCellReuseIdentifier:CELL];
}

- (void)animateToHide {
  [UIView animateWithDuration:0.2 animations:^{
    self.frame = CGRectMake(-320, 0, 320, 568);
  } completion:^(BOOL finished) {
    self.hidden = YES;
  }];
}

- (void)animateToShow {
  self.hidden = NO;
  [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear  animations:^{
     self.frame = CGRectMake(0, 0, 320, 568);
  } completion:^(BOOL finished) {
    
  }];
//  
//  [UIView animateWithDuration:0.2 animations:^{
//    self.frame = CGRectMake(0, 0, 320, 568);
//  }];
}

- (IBAction)horProblemButtonClickAction:(id)sender {
  self.isHor = YES;
  [self.tableView reloadData];
}

- (IBAction)verProblemButtonClickAction:(id)sender {
  self.isHor = NO;
  [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([self.delegate respondsToSelector:@selector(problemListViewPanel:DidClickWithIndex:andDirection:)]) {
    [self.delegate problemListViewPanel:self DidClickWithIndex:indexPath.row andDirection:(self.isHor ? @(0) : @(1))];
  }
  [self animateToHide];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ProblemListViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CELL forIndexPath:indexPath];
  NSDictionary *currentDictionary = self.isHor ? self.horPorblemArray : self.verProblemArray;
  NSString *hint = [currentDictionary objectForKey:@(indexPath.row)];
  [cell updateWithProblemString:hint];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.isHor ? self.horPorblemArray.count : self.verProblemArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 60;
}

@end
