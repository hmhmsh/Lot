//
//  ShowButton.m
//  Lot
//
//  Created by 長谷川瞬哉 on 2015/05/14.
//  Copyright (c) 2015年 長谷川瞬哉. All rights reserved.
//

#import "ShowButton.h"

@implementation ShowButton

- (id)init
{
  self = [super init];
  if (self != nil) {
    
  }
  return self;
}

- (void)makeButton:(int)index
{
  _move = YES;
  _currentIndex = _index = index;
  self.frame = CGRectMake(0, 0, 50, 50);
  self.backgroundColor = [UIColor whiteColor];
  switch (index) {
    case 0:
      [self setImage:[UIImage imageNamed:@"105689s.jpg"] forState:UIControlStateNormal];
      break;
    case 1:
      [self setImage:[UIImage imageNamed:@"105698s.jpg"] forState:UIControlStateNormal];
      break;
    case 2:
      [self setImage:[UIImage imageNamed:@"107806s.jpg"] forState:UIControlStateNormal];
      break;
    case 3:
      [self setImage:[UIImage imageNamed:@"107955s.jpg"] forState:UIControlStateNormal];
      break;
    case 4:
      [self setImage:[UIImage imageNamed:@"108002s.jpg"] forState:UIControlStateNormal];
      break;
    case 5:
      [self setImage:[UIImage imageNamed:@"108027s.jpg"] forState:UIControlStateNormal];
      break;
    case 6:
      [self setImage:[UIImage imageNamed:@"113001s.jpg"] forState:UIControlStateNormal];
      break;
    case 7:
      [self setImage:[UIImage imageNamed:@"115757s.jpg"] forState:UIControlStateNormal];
      break;
      
    default:
      break;
  }
  self.layer.cornerRadius = 25;
  self.layer.shadowOpacity = 0.7;
  self.layer.shadowRadius = 4.0;
  self.layer.shadowOffset = CGSizeMake(3, 3);
  self.layer.masksToBounds = YES;
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
