//
//  RootViewController.m
//  Lot
//
//  Created by 長谷川瞬哉 on 2015/05/14.
//  Copyright (c) 2015年 長谷川瞬哉. All rights reserved.
//

#import "RootViewController.h"
#define LINEVERTIAL_MAX 12

@interface RootViewController ()
{
  ShowButton* mark[LINEVERTIAL_MAX];
  ViewController* viewController;
  ShowButton* select;
  
  UISegmentedControl* seg;
  UIImagePickerController *ipc;
  UIAlertView* imageChange;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  viewController = [[ViewController alloc]init];
  [viewController createArray];
  
  [self setImage];
  
  [self setColor];
  
  [self createSegment];
  
  [self createStartButton];

  [self createImagePicker];
  
  [self createAlert];
  
}

- (void)createAlert
{
  imageChange = [[UIAlertView alloc]initWithTitle:@"確認" message:@"画像をかえますか？" delegate:self cancelButtonTitle:@"けす" otherButtonTitles:@"かえる", @"かえない", nil];
}

- (void)createSegment
{
  seg = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"RACE START", @"AMIDA START", @"RESET", nil]];
  seg.segmentedControlStyle = UISegmentedControlStylePlain;
  
  seg.frame = CGRectMake(5, self.navigationController.navigationBar.frame.size.height + 50, self.view.frame.size.width-10, 100);
  [seg addTarget:self action:@selector(Amida:) forControlEvents:UIControlEventValueChanged];
  seg.momentary = YES;
  [self.view addSubview:seg];

}

- (void)setColor
{
  UIView* color = [[UIView alloc]init];
  color.frame = self.view.bounds;
  color.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
  [self.view addSubview:color];
}

- (void)setImage
{
  UIImageView* back = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PAK86_garimori1126500_TP_V.jpg"]];
  back.frame = self.view.bounds;
  [self.view addSubview:back];
}

- (void)createStartButton
{
  for (int i= 0; i < LINEVERTIAL_MAX; i++) {
    mark[i] = [[ShowButton alloc]init];
    [mark[i] makeButton:i];
    [mark[i] addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    CGPoint center = CGPointMake((self.view.frame.size.width-4*mark[0].frame.size.width)/5, self.view.frame.size.height/2);
    if (i < 4) {
      mark[i].frame = CGRectMake( center.x + i*(mark[i].frame.size.width + center.x), center.y - mark[i].frame.size.height, mark[i].frame.size.width, mark[i].frame.size.height);
    }
    else if (i < 8){
      mark[i].frame = CGRectMake( center.x + (i-4)*(mark[i].frame.size.width + center.x), center.y + mark[i].frame.size.height, mark[i].frame.size.width, mark[i].frame.size.height);
    }
    else if (i < 12){
      mark[i].frame = CGRectMake( center.x + (i-8)*(mark[i].frame.size.width + center.x), center.y + 3*mark[i].frame.size.height, mark[i].frame.size.width, mark[i].frame.size.height);
    }
    
    [self.view addSubview:mark[i]];
  }
}

- (void)createImagePicker
{
  ipc = [[UIImagePickerController alloc] init];  // 生成
  ipc.delegate = self;  // デリゲートを自分自身に設定
  ipc.sourceType =
  UIImagePickerControllerSourceTypePhotoLibrary;  // 画像の取得先をカメラに設定
  ipc.allowsEditing = YES;  // 画像取得後編集する
}

- (void)selectButton:(ShowButton*)button
{
  if (button.index >= 8) {
    select = button;
    if (select.currentImage != nil) {
      [imageChange show];
    }
    else {
      [self showImagePicker];
    }
  }
  else {
    if (viewController.itemArray.count < 8) {
      [viewController.itemArray addObject:button.currentImage];
    }
  }
}

- (void)showImagePicker
{
  [self presentModalViewController:ipc animated:YES];
}

-(void)imagePickerController:(UIImagePickerController*)picker
       didFinishPickingImage:(UIImage*)image editingInfo:(NSDictionary*)editingInfo
{
  [select setImage:image forState:UIControlStateNormal];
  if (viewController.itemArray.count < 8) {
    [viewController.itemArray addObject:image];
  }
  [self dismissModalViewControllerAnimated:YES];  // モーダルビューを閉じる
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  switch (buttonIndex) {
    case 0:
      [select setImage:nil forState:UIControlStateNormal];
      break;
    case 1:
      [self showImagePicker];
      break;
    case 2:
      if (viewController.itemArray.count < 8) {
        [viewController.itemArray addObject:select.currentImage];
      }
      break;
    default:
      break;
  }
}

//画像の保存完了時に呼ばれるメソッド
-(void)targetImage:(UIImage*)image
didFinishSavingWithError:(NSError*)error contextInfo:(void*)context
{
  if(error){
    // 保存失敗時
  }else{
    // 保存成功時
  }
}

//画像の選択がキャンセルされた時に呼ばれる
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
  [self dismissModalViewControllerAnimated:YES];  // モーダルビューを閉じる
  // 何かの処理
}


- (void)Amida:(UISegmentedControl*)segment
{
  switch (segment.selectedSegmentIndex) {
    case 0:
    {
      viewController.LINEVERTIAL = (int)viewController.itemArray.count;
      viewController.state = STATE_RACE;
      [self.navigationController pushViewController:viewController animated:YES];
    }
      break;
    case 1:
    {
      viewController.LINEVERTIAL = (int)viewController.itemArray.count;
      viewController.state = STATE_AMIDA;
      [self.navigationController pushViewController:viewController animated:YES];
    }
      break;
    case 2:
    {
      [viewController.itemArray removeAllObjects];
    }
      break;
      
    default:
      break;
  }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
