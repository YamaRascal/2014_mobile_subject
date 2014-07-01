//
//  PileViewController.m
//  Pile
//
//  Created by 14cm0132 on 2014/06/25.
//  Copyright (c) 2014年 jec.ac.jp. All rights reserved.
//

#import "PileViewController.h"

@interface PileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *photoLibraryButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;
@property (nonatomic,strong) UIImagePickerController *imagePicker; //イメージピッカー

@property(nonatomic,strong)UIAlertView *saveAlert;  //保存確認アラート
@property(nonatomic,strong)UIAlertView *clearAlert; //消去確認アラート

@end

@implementation PileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //イメージピッカーの作成
    self.imagePicker = [[UIImagePickerController alloc] init];
    //イメージピッカーのデリゲートを作成
    self.imagePicker.delegate = self;
    
    //カメラを利用できない機種であれば、カメラボタンを無効にする
    self.cameraButton.enabled = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    self.photoLibraryButton.enabled = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    
    //保存確認アラートの生成と初期化
    self.saveAlert = [[UIAlertView alloc] init];
    self.saveAlert.title =@"Save Image";                //タイトルの設定
    self.saveAlert.message = @"Are you sure ?";         //メッセージの設定
    self.saveAlert.delegate = self;                     //デリゲートの設定
    [self.saveAlert addButtonWithTitle:@"Cansel"];      //ボタンの設定
    [self.saveAlert addButtonWithTitle:@"OK"];          //ボタンの設定
    
    //消去確認アラートの生成と初期化
    self.clearAlert = [[UIAlertView alloc] init];
    self.clearAlert.title =@"Clear Image";              //タイトルの設定
    self.clearAlert.message = @"Are you sure ?";        //メッセージの設定
    self.clearAlert.delegate = self;                    //デリゲートの設定
    [self.clearAlert addButtonWithTitle:@"Cansel"];     //ボタンの設定
    [self.clearAlert addButtonWithTitle:@"OK"];         //ボタンの設定
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//合成画像を保存するときに呼び出されるメソッド
- (IBAction)saveImage:(id)sender {
    
    [self.saveAlert show];  //保存確認アラートを表示
    
}

- (IBAction)openPhotoLibrary:(id)sender {
    
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //イメージピッカーを開く
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
    
}
//カメラを開く
- (IBAction)openCamera:(id)sender {
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}
//合成画像を消去するときに呼び出されるメソッド
- (IBAction)clearImage:(id)sender {
    
    [self.clearAlert show]; //消去確認のアラート
    
}

//写真が撮影されたとき呼び出されるメソッド
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //写真の処理
    
    //画像を取得する
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    //イメージ・ピッカーを閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //イメージ。ビューの領域を取得
    CGRect canvasRect = self.imageView.bounds;
    //グラッフィク・コンテクトを作成
    UIGraphicsBeginImageContext(canvasRect.size);
    [self.imageView.image drawInRect:canvasRect];
    //写真の画像をブレンド・モードを指定して描画
    [image drawInRect:canvasRect blendMode:kCGBlendModeLighten alpha:1.0];
    
    //グラフィックス・コンテクストから画像を取得
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //取得した画像をイメージビューに設定
    self.imageView.image = newImage;
    //グラフィックス・コンテクストを解放
    UIGraphicsEndImageContext();
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //タップされたボタンに応じた処理
    
    //アラートが保存確認であり、ボタンがOKであれば
    if(alertView == self.saveAlert && buttonIndex ==1)
    {
        //イメージ・ビューの画像を写真アルバムに保存
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
    }
    
    //アラートが消去確認であり、ボタンがOKであれば、
    if(alertView == self.clearAlert && buttonIndex ==1)
    {
        //イメージ・ビューの画像を消去(nilに設定)
        self.imageView.image = nil;
    }
    
    //アラートの表示を消す
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
}



@end
