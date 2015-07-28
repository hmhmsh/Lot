//
//  AppDelegate.h
//  Lot
//
//  Created by 長谷川瞬哉 on 2015/05/12.
//  Copyright (c) 2015年 長谷川瞬哉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "RootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController* vc;
@property (strong, nonatomic) RootViewController* root;
@property (strong, nonatomic) UINavigationController* navi;


@end

