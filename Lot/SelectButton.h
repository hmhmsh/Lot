//
//  SelectButton.h
//  Lot
//
//  Created by 長谷川瞬哉 on 2015/05/13.
//  Copyright (c) 2015年 長谷川瞬哉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectButton : UIImageView
- (void)makeButton:(int)index item:(UIImage*)item;
@property (nonatomic) int currentIndex;
@property (nonatomic) int index;
@property (nonatomic) BOOL move;
@end
