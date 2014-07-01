//
//  SmashViewController.m
//  Smash
//
//  Created by 14cm0132 on 2014/05/07.
//  Copyright (c) 2014年 jec.ac.jp. All rights reserved.
//

#import "SmashViewController.h"

@interface SmashViewController ()
@property (weak, nonatomic) IBOutlet UIButton *target;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) NSTimer *smashTimer;

@end

@implementation SmashViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 乱数の初期化
    srand(time(NULL));
    [self move:nil];
    
    self.smashTimer =[NSTimer scheduledTimerWithTimeInterval:1                   //時間間隔
                                     target:self                //呼び出すオブジェクト
                                   selector:@selector(move:)  //呼び出すメソッド
                                    userInfo:nil                //ユーザー利用の情報オブジェクト
                                    repeats:YES];               //繰り返し
    
    
    //効果音の再生
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Smash" ofType:@"caf"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url,&soundID);
}

//タイマーから呼び出されるメソッド

-(void)move:(NSTimer *)timer
{
    //アニメーションの定義
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    
    
    //タイマー動作時の処理
    
    
    //アニメーションによって変化させる事柄を設定
    //UFOの移動
    int x = (rand() % 160) + 80;
    int y = (rand() % 283) + 142;
    self.target.center = CGPointMake(x,y);
    
    // アニメーションの定義終了、実行
    [UIView commitAnimations];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)smash {
    // 効果音を再生
    AudioServicesPlayAlertSound(soundID);
    
    //スコアをインクリメント
    score = score + 10;
    
    //スコアを表示
    [self updateDisplay];
}
- (IBAction)missAction
{
    //スコアをデクリメント
    score = score - 1;

    //スコア表示
    [self updateDisplay];
}

- (void)updateDisplay
{
    if(score < 0){
        self.scoreLabel.textColor = [UIColor redColor];
    }else{
        self.scoreLabel.textColor = [UIColor whiteColor];
    }
    
    if(score >= 100){
        self.scoreLabel.text=@"Complate";
        [self.smashTimer invalidate];
        //self.messageLabel.text = @"Congratulation";
    }else{
    self.scoreLabel.text = [NSString stringWithFormat:@"%04d", abs(score)];
    }
}

@end
