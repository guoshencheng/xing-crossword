//
//  ProblemListViewPanel.h
//  XingCrossword
//
//  Created by apple on 14-9-19.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ProblemListViewCell.h"

@protocol ProblemListViewPanelDelegate;

@interface ProblemListViewPanel : UIView <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) id<ProblemListViewPanelDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

+ (id)create;

@end

@protocol ProblemListViewPanelDelegate <NSObject>

- (void)problemListViewPanel:(ProblemListViewPanel *)problemListView DidClickWithIndex:(NSInteger)index;

@end