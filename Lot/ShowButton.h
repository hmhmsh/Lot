//
//  ShowButton.h
//  Lot
//
//  Created by 長谷川瞬哉 on 2015/05/14.
//  Copyright (c) 2015年 長谷川瞬哉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowButton : UIButton
- (void)makeButton:(int)index;
@property (nonatomic) int currentIndex;
@property (nonatomic) int index;
@property (nonatomic) BOOL move;

@end
