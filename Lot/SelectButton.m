//
//  SelectButton.m
//  Lot
//
//  Created by 長谷川瞬哉 on 2015/05/13.
//  Copyright (c) 2015年 長谷川瞬哉. All rights reserved.
//

#import "SelectButton.h"

@implementation SelectButton

- (id)init
{
  self = [super init];
  if (self != nil) {
    
  }
  return self;
}

- (void)makeButton:(int)index item:(UIImage*)item
{
  _move = YES;
  _currentIndex = _index = index;
  self.frame = CGRectMake(0, 0, 50, 50);
//  self.backgroundColor = color;
  [self setImage:item];
  self.layer.masksToBounds = YES;
  self.layer.cornerRadius = 25;
  self.layer.shadowOpacity = 0.7;
  self.layer.shadowRadius = 4.0;
  self.layer.shadowOffset = CGSizeMake(3, 3);
  self.tag = index;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
