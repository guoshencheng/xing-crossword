//
//  StartGameViewController+Configuration.m
//  XingCrossword
//
//  Created by apple on 14-9-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "StartGameViewController+Configuration.h"

@implementation StartGameViewController (Configuration)

- (void)configureView {
  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;
  [self.collectionView registerNib:[UINib nibWithNibName:@"startGameCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:START_GAME_COLLECTIONVIEW_CELL];
}

@end
