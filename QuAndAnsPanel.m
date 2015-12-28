//
//  QuAndAnsPanel.m
//  XingCrossword
//
//  Created by guoshencheng on 5/10/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

#import "QuAndAnsPanel.h"

@implementation QuAndAnsPanel

+ (instancetype)create {
    QuAndAnsPanel *view = [[[NSBundle mainBundle] loadNibNamed:@"QuAndAnsPanel" owner:nil options:nil] lastObject];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

- (void)updateWithQuestion:(NSString *)question andAnswer:(NSString *)answer {
    NSArray *currentArray = (self.isHor ? self.horQuestionList : self.verQuestionList);
    NSDictionary *dic = [currentArray objectAtIndex:self.selectCellIndex];
    [dic setValue:question forKey:@"question"];
    [dic setValue:answer forKey:@"answer"];
    [self.tableView reloadData];
}

- (void)updateWithVarList:(NSArray *)verList andHorList:(NSArray *)horList {
    self.verQuestionList = verList;
    self.horQuestionList = horList;
    [self.tableView reloadData];
}

- (void)awakeFromNib {
    self.isHor = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"QuAndAnsPanelCell" bundle:nil] forCellReuseIdentifier:QU_AND_ANS_CELL];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    return  cell.frame.size.height;
    //return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.isHor ? self.horQuestionList.count : self.verQuestionList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuAndAnsPanelCell *cell = [self.tableView dequeueReusableCellWithIdentifier:QU_AND_ANS_CELL];
    NSArray *currentArray = (self.isHor ? self.horQuestionList : self.verQuestionList);
    NSDictionary *dic = [currentArray objectAtIndex:indexPath.row];
    [cell updateWithQuestion:[dic valueForKey:@"question"] answer:[dic objectForKey:@"answer"] andAnswerCount:[[dic valueForKey:@"count"] integerValue]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *currentArray = (self.isHor ? self.horQuestionList : self.verQuestionList);
    NSDictionary *dic = [currentArray objectAtIndex:indexPath.row];
    self.selectCellIndex = indexPath.row;
    if ([self.delegate respondsToSelector:@selector(quAndAnsPanel:didClickCellWithQuestion:answer:andWordCount:)]) {
        [self.delegate quAndAnsPanel:self didClickCellWithQuestion:[dic valueForKey:@"question"] answer:[dic objectForKey:@"answer"] andWordCount:[[dic valueForKey:@"count"] integerValue]];
    }
    
}

- (NSArray *)acrossArrayForUpLoad {
    NSMutableArray *acrossArray = [[NSMutableArray alloc] init];
    for (int i  = 0; i < self.horQuestionList.count ; i ++) {
        NSDictionary *dic = [self.horQuestionList objectAtIndex:i];
        NSMutableDictionary *upLoadDic = [[NSMutableDictionary alloc] init];
        [upLoadDic setValue:@(i + 1) forKey:@"order"];
        [upLoadDic setValue:[dic objectForKey:@"question"] forKey:@"hint"];
        [upLoadDic setValue:[dic objectForKey:@"answer"] forKey:@"word"];
        [acrossArray addObject:upLoadDic];
    }
    NSData *jsonData = [self toJSONData:acrossArray];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByReplacingOccurrencesOfString : @"\r\n" withString : @"" ];
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString : @"\n" withString : @"" ];
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString : @"\t" withString : @"" ];
    return acrossArray;
}

- (NSData *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}

- (NSArray *)downArrayForUpLoad {
    NSMutableArray *downArray = [[NSMutableArray alloc] init];
    for (int i  = 0; i < self.verQuestionList.count ; i ++) {
        NSDictionary *dic = [self.verQuestionList objectAtIndex:i];
        NSMutableDictionary *upLoadDic = [[NSMutableDictionary alloc] init];
        [upLoadDic setValue:@(i + 1) forKey:@"order"];
        [upLoadDic setValue:[dic objectForKey:@"question"] forKey:@"hint"];
        [upLoadDic setValue:[dic objectForKey:@"answer"] forKey:@"word"];
        [downArray addObject:upLoadDic];
    }
    NSData *jsonData = [self toJSONData:downArray];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByReplacingOccurrencesOfString : @"\r\n" withString : @"" ];
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString : @"\n" withString : @"" ];
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString : @"\t" withString : @"" ];
    return downArray;
}

- (IBAction)didClickHorButton:(id)sender {
    self.isHor = YES;
    [self.tableView reloadData];
}

- (IBAction)didClickVerButton:(id)sender {
    self.isHor = NO;
    [self.tableView reloadData];
}

- (void)animateToShow {
    [UIView animateWithDuration:0.2 animations:^{
        [self setLeftSpace:0];
        [self setRightSpace:0];
        [self layoutIfNeeded];
    }];
}

- (void)animateToHide {
    [UIView animateWithDuration:0.2 animations:^{
        [self setLeftSpace:[UIScreen mainScreen].bounds.size.width];
        [self setRightSpace:[UIScreen mainScreen].bounds.size.width];
        [self layoutIfNeeded];
    }];
}

@end
