//
//  ViewController.m
//  Lot
//
//  Created by 長谷川瞬哉 on 2015/05/12.
//  Copyright (c) 2015年 長谷川瞬哉. All rights reserved.
//

#import "ViewController.h"
#define LINEVERTIAL_MAX 8
#define LINEHORIZONTALPERVERTIAL 7
#define LINEWIDTH 1
#define ANIMATEWITHDURATION 0.01

@interface ViewController ()
{
  UIScrollView *amida;
  CGPoint point[LINEVERTIAL_MAX][LINEHORIZONTALPERVERTIAL];
  CGPoint barPointLeft[LINEVERTIAL_MAX-1][LINEHORIZONTALPERVERTIAL];
  CGPoint barPointRight[LINEVERTIAL_MAX-1][LINEHORIZONTALPERVERTIAL];
  int goal;
  UIAlertView* next;
  int marginy, marginx;
  int lineX, lineY;
  
  CGPoint startPoint[LINEVERTIAL_MAX];
  CGPoint gorlPoint[LINEVERTIAL_MAX];
  SelectButton* mark[LINEVERTIAL_MAX];
  BOOL left[LINEVERTIAL_MAX];
  BOOL right[LINEVERTIAL_MAX];
  
  CAShapeLayer *sl;
  CGPoint SCVpoint;
  
  UILabel* startLabel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Do any additional setup after loading the view, typically from a nib.
  self.view.backgroundColor = [self color:2];
  
  next = [[UIAlertView alloc]initWithTitle:@"FINISH" message:@"YOUR SELECT ITEM IS HIT" delegate:self cancelButtonTitle:nil otherButtonTitles:@"CONTINUE", nil];
  
  UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(start:)];
  tap.delegate = self;
  [self.view addGestureRecognizer:tap];
  
  [self setImage];
  
  [self createLineSize];
  
  [self createGrid];
  
  [self createGoal];
  
  [self createStartButton];
  
  [self createStartLabel];
  
}

- (void)createArray
{
  _itemArray = [NSMutableArray array];
}

- (void)viewDidAppear:(BOOL)animated
{
  for (UIView* v in self.view.subviews){
    [v removeFromSuperview];
  }
  [self setImage];
  [self createLineSize];
  [self createGrid];
  [self createGoal];
  [self createStartButton];
  [self createStartLabel];
}

- (void)setImage
{
  UIImageView* back = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PAK86_garimori1126500_TP_V.jpg"]];
  back.frame = self.view.bounds;
  [self.view addSubview:back];
}

- (void)createStartLabel
{
  startLabel = [[UILabel alloc]init];
  startLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, marginy);
  startLabel.backgroundColor = [UIColor clearColor];
  startLabel.text = @"START";
  startLabel.textAlignment = NSTextAlignmentCenter;
  startLabel.font = [UIFont fontWithName:@"Zapfino" size:40];
  [amida addSubview:startLabel];
}

- (void)createLineSize
{
  amida = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  amida.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
  amida.delegate = self;
  amida.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2);
  [self.view addSubview:amida];
  [amida setScrollEnabled:NO];
  SCVpoint = CGPointZero;

  lineX = 300/_LINEVERTIAL;
  lineY = 100;
  
  marginx = (amida.contentSize.width - lineX*(_LINEVERTIAL-1))/2;
  marginy = (amida.contentSize.height - lineY*LINEHORIZONTALPERVERTIAL)/2;
}

- (void)createGrid
{
  
  for (int i = 0; i < _LINEVERTIAL; i++) {
    float x = lineX * i + marginx;
    float y = lineY * 0 + marginy;
    startPoint[i] = CGPointMake(x, y);
    y = lineY * (LINEHORIZONTALPERVERTIAL+1) + marginy;
    gorlPoint[i] = CGPointMake(x, y);
  }
  
  UIBezierPath *path = [UIBezierPath bezierPath];
  // vertical line
  for (int i = 0; i < _LINEVERTIAL; i++) {
    [path moveToPoint:startPoint[i]];
    [path addLineToPoint:gorlPoint[i]];
  }
  
  for (int i = 0; i < _LINEVERTIAL; i++) {
    for (int j = 0; j < LINEHORIZONTALPERVERTIAL; j++) {
      float x = lineX * i + marginx;
      float y = lineY * (j+1) + marginy;
      point[i][j] = CGPointMake(x, y);
    }
  }

  for (int i = 0; i < _LINEVERTIAL-1; i++) {
    for (int j = 0; j < LINEHORIZONTALPERVERTIAL; j++) {
      if (arc4random()%3) {
        // 横棒を表示
        // 線が一直線にならないようにずらす
        if (i % 2) {
          barPointLeft[i][j] = point[i][j];
          barPointRight[i][j] = point[i+1][j];
          [path moveToPoint:barPointLeft[i][j]];
          [path addLineToPoint:barPointRight[i][j]];
        } else {
          barPointLeft[i][j] = CGPointMake(point[i][j].x, point[i][j].y-lineY/2);
          barPointRight[i][j] = CGPointMake(point[i+1][j].x, point[i+1][j].y-lineY/2);
          [path moveToPoint:barPointLeft[i][j]];
          [path addLineToPoint:barPointRight[i][j]];
        }
      } else {
        CGPoint s = point[i][j];
        CGPoint e = point[i+1][j];
        CGPoint ss = CGPointMake((s.x + e.x) / 2.0 - lineX/10, s.y);
        CGPoint ee = CGPointMake((s.x + e.x) / 2.0 + lineX/10, s.y);
        // 線が一直線にならないようにずらす
        if (i % 2) {
          [path moveToPoint:s];
          [path addLineToPoint:ss];
          [path moveToPoint:ee];
          [path addLineToPoint:e];
        } else {
          [path moveToPoint:CGPointMake(s.x, s.y - lineY/2)];
          [path addLineToPoint:CGPointMake(ss.x, ss.y - lineY/2)];
          [path moveToPoint:CGPointMake(ee.x, ee.y - lineY/2)];
          [path addLineToPoint:CGPointMake(e.x, e.y - lineY/2)];
        }
        barPointLeft[i][j] = CGPointZero;
        barPointRight[i][j] = CGPointZero;
      }
    }
  }

  sl = [[CAShapeLayer alloc] init];
  sl.strokeColor = [UIColor blackColor].CGColor;
//  sl.strokeColor = [self color:0].CGColor;
  sl.fillColor = [UIColor clearColor].CGColor;
  sl.lineWidth = LINEWIDTH;
  sl.path = path.CGPath;
  
  sl.shadowOpacity = 0.7;
  sl.shadowRadius = 4.0;
  sl.shadowOffset = CGSizeMake(3, 3);
  
  [amida.layer addSublayer:sl];
}

- (void)createGoal
{
  goal = arc4random() % _LINEVERTIAL;
  
  if (_state == STATE_AMIDA) {
    UIImageView* goalView = [[UIImageView alloc]init];
    goalView.frame = CGRectMake(0, 0, 50, 50);
    goalView.backgroundColor = [UIColor whiteColor];
    goalView.center = gorlPoint[goal];
    goalView.layer.masksToBounds = YES;
    goalView.layer.cornerRadius = 25;
    [amida addSubview:goalView];
  }
}

- (void)createStartButton
{
  for (int i= 0; i < _itemArray.count; i++) {
    mark[i] = [[SelectButton alloc]init];
    [mark[i] makeButton:i item:[_itemArray objectAtIndex:i]];
    mark[i].center = startPoint[i];
    [amida addSubview:mark[i]];
    left[i] = NO;
    right[i] = NO;
  }
}

- (void)start:(UITapGestureRecognizer*)gesture
{
  [self animation];
}

- (void)animation
{
  for (int i = 0; i < _LINEVERTIAL; i++) {
    for (int j = 0; j < LINEHORIZONTALPERVERTIAL; j++) {
      if (right[i] == NO && left[i] == NO && mark[i].move == YES) {
        if (mark[i].currentIndex != _LINEVERTIAL-1) {
          if (mark[i].center.y == barPointLeft[mark[i].currentIndex][j].y) {
            right[i] = YES;
          }
        }
        if (mark[i].currentIndex != 0) {
          if (mark[i].center.y == barPointRight[mark[i].currentIndex-1][j].y) {
            left[i] = YES;
          }
        }
      }
    }
  }
  [UIView animateWithDuration:ANIMATEWITHDURATION animations:^{
    for (int i = 0; i < _LINEVERTIAL; i++) {
      if (mark[i].move == YES) {
        if (right[i] == YES) {
          mark[i].center = CGPointMake(mark[i].center.x + lineX/20, mark[i].center.y);
          if (mark[i].center.x == startPoint[mark[i].currentIndex+1].x) {
            right[i] = NO;
            mark[i].center = CGPointMake(mark[i].center.x, mark[i].center.y + arc4random()%10 + 1);
            mark[i].currentIndex++;
          }
        }
        else if (left[i] == YES) {
          mark[i].center = CGPointMake(mark[i].center.x - lineX/20, mark[i].center.y);
          if (mark[i].center.x == startPoint[mark[i].currentIndex-1].x) {
            left[i] = NO;
            mark[i].center = CGPointMake(mark[i].center.x, mark[i].center.y + arc4random()%10 + 1);
            mark[i].currentIndex--;
          }
        }
        else {
          mark[i].center = CGPointMake(mark[i].center.x, mark[i].center.y + 1);
        }
        
        if (mark[i].center.y == gorlPoint[goal].y) {
          mark[i].move = NO;
        }
      }
    }
    
    if (SCVpoint.y < self.view.frame.size.height) {
      SCVpoint.y += 1;
      [amida setContentOffset:SCVpoint animated:YES];
    }
  } completion:^(BOOL finished) {
    int NoCount = 0;
    for (int i = 0; i < _LINEVERTIAL; i++) {
      if (mark[i].move == NO) {
        NoCount++;
      }
    }
    if (_state == STATE_RACE) {
      if (NoCount == _LINEVERTIAL-1) {
        for (int i = 0; i < _LINEVERTIAL; i++) {
          if (mark[i].move == YES) {
            mark[i].center =CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height*1.25);
            CATransform3D transform = CATransform3DMakeScale(2.0, 2.0, 0.0);
            mark[i].layer.transform = transform;
            [next show];
          }
        }
      }
      else {
          // continue
          [self animation];
      }
    }
    else if (_state == STATE_AMIDA){
      if (NoCount == _LINEVERTIAL) {
        for (int i = 0; i < _LINEVERTIAL; i++) {
          if (mark[i].center.x == gorlPoint[goal].x) {
            mark[i].center =CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height*1.25);
            CATransform3D transform = CATransform3DMakeScale(2.0, 2.0, 0.0);
            mark[i].layer.transform = transform;
            [next show];
          }
        }
      }
      else {
        // continue
        [self animation];
      }
    }
  }];
  
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  [_itemArray removeAllObjects];
  [self.navigationController popToRootViewControllerAnimated:YES];
}

#define UIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
- (UIColor*)color:(int)i
{
  switch (i) {
    case 0:
      return UIColorHex(0xF88D00);
    case 1:
      return UIColorHex(0xED4500);
    case 2:
      return UIColorHex(0xFCFBE5);
    case 3:
      return UIColorHex(0xD9224C);
    case 4:
      return UIColorHex(0xBBD400);
    case 5:
      return UIColorHex(0xFF0000);
    default:
      break;
  }
  return nil;
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
