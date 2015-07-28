//
//  ViewController.h
//  Lot
//
//  Created by 長谷川瞬哉 on 2015/05/12.
//  Copyright (c) 2015年 長谷川瞬哉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectButton.h"

typedef enum:NSInteger {
  STATE_RACE = 0,
  STATE_AMIDA = 1
}State;

@interface ViewController : UIViewController
- (void)createArray;

@property (nonatomic) int LINEVERTIAL;
@property (nonatomic) NSMutableArray* itemArray;
@property (nonatomic) State state;


@end

