//
//  ProblemListViewPanel.m
//  XingCrossword
//
//  Created by apple on 14-9-19.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ProblemListViewPanel.h"

@implementation ProblemListViewPanel

+ (id)create {
  return [[NSBundle mainBundle] loadNibNamed:@"ProblemListViewPanel" owner:nil options:nil];
}

- (void)awakeFromNibs {
  self.tableView.delegate = self;
  [self.tableView registerNib:[UINib nibWithNibName:@"ProblemListViewPanel" bundle:nil] forCellReuseIdentifier:CELL];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [self.tableView dequeueReusableCellWithIdentifier:CELL forIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 60;
}

@end
