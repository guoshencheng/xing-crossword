//
//  StartGameViewController.h
//  XingCrossword
//
//  Created by apple on 14-8-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "StartGameViewScene.h"
#import "startGameCollectionViewCell.h"
#import "WebService.h"

@interface StartGameViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, WebServiceDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong ,nonatomic) NSArray *puzzleArray;

+ (id)create;

@end
