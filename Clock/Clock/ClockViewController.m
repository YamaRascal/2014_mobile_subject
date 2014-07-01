//
//  ClockViewController.m
//  Clock
//
//  Created by 14cm0132 on 2014/06/10.
//  Copyright (c) 2014年 jec.ac.jp. All rights reserved.
//

#import "ClockViewController.h"

@interface ClockViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *alarmHand;
@property (weak, nonatomic) IBOutlet UIImageView *hourHand;
@property (weak, nonatomic) IBOutlet UIImageView *minuteHand;
@property (weak, nonatomic) IBOutlet UIImageView *secondHond;
@property (weak, nonatomic) IBOutlet UIButton *alarmButton;

@property (nonatomic) BOOL alarmEnabled; //アラームの状態（オン・オフ）
@property (nonatomic) float alarmHour;  //アラームの時刻（12時間制）

@property(nonatomic,strong)AVAudioPlayer *alarmPlayer;  //アラーム音の再生プレーヤ

@end

@implementation ClockViewController

//クラスの初期化

+(void)initialize
{
    //ユーザ・デフォルトの初期化
    
    NSMutableDictionary *defaultValues =[NSMutableDictionary dictionary];
    
    //初期値の設定
    [defaultValues setValue:[NSNumber numberWithBool:NO]
                     forKey:kAlarmEnabledKey];
    [defaultValues setValue:[NSNumber numberWithFloat:0.0]
                     forKey:kAlarmHourKey];
    
    //ユーザー・デフォルトを取得
    NSUserDefaults *userDefaults =[NSUserDefaults standardUserDefaults];
    //ユーザー・デフォルトに初期値を登録
    
    [userDefaults registerDefaults:defaultValues];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //自動ロックの禁止
    UIApplication *application = [UIApplication sharedApplication];
    application.idleTimerDisabled = YES;
    
    //ユーザーデフォルトの取得
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //ユーザーデフォルトから設定値を取得
    self.alarmEnabled = [userDefaults boolForKey:kAlarmEnabledKey];
    self.alarmHour = [userDefaults floatForKey:kAlarmHourKey];
    
    [self setAlarmItems];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0//時間感覚（秒）
                                    target:self
                                    selector:@selector(driveClock:)
                                    userInfo:nil
                                    repeats:YES];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Alarm" ofType:@"caf"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    self.alarmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.alarmPlayer.numberOfLoops = -1;//ループ再生
    
}
//タイマーから呼び出されるメソッド
-(void)driveClock:(NSTimer *)timer
{
    //タイマー動作時の処理
    
    //現在時刻の取得
    NSDate *today = [NSDate date];
    
    
    //現在時刻の時、分、秒を取得
    
    NSCalendar *calemder = [NSCalendar currentCalendar];
    unsigned flags = NSHourCalendarUnit | NSMinuteCalendarUnit  | NSSecondCalendarUnit  ;
    NSDateComponents *todayComponents = [calemder components:flags fromDate:today];
    
    int hour  = [todayComponents hour];
    int min   = [todayComponents minute];
    int sec   = [todayComponents second];
    
    float fineHour = (hour %12)+min /60.0;
    
    //時針、分針、秒針、の回転
    self.hourHand.transform = CGAffineTransformMakeRotation(M_PI * 2 * fineHour / 12.0);
    self.minuteHand.transform = CGAffineTransformMakeRotation(M_PI * 2 * min / 60.0);
    self.secondHond.transform  = CGAffineTransformMakeRotation(M_PI * 2 * sec /60.0);
    
    //アラームの処理
    if(self.alarmEnabled)
    {
        float difference = fineHour - self.alarmHour;
        if(difference >= 0.0 && difference < 0.1)
        {
            if(!self.alarmPlayer.playing)
            {
                [self.alarmPlayer play];
            }
        }else{
                if (self.alarmPlayer.playing)
                {
                     [self.alarmPlayer stop];
                }
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)toggleAlarmButton
{
    //アラームの状態を反転
    self.alarmEnabled = !self.alarmEnabled;
    
    //アラームのビュー・アイテムを設定
    [self setAlarmItems];
    
    //アラーム状態がオフであれば、アラームを停止
    if(self.alarmEnabled  == NO){
        [self.alarmPlayer stop];
    }
}

//アラームのビュー・アイテムを設定
- (void)setAlarmItems
{
    //アラーム・ボタンを設定
    
    self.alarmButton.selected = self.alarmEnabled;
    
    //アラーム針を設定
    
    self.alarmHand.transform =
    CGAffineTransformMakeRotation(M_PI * 2 *self.alarmHour / 12.0);
    
}

//盤面の透明ボタンがタップドラッグされたときに呼び出されるメソッド
- (IBAction)moveAlarmHand:(UIButton *)sender forEvent:(UIEvent *)event {
    
    //タップされた座標を取得する
    NSSet  *touches = [event touchesForView:sender];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:sender];
    
    //タップされた座標に対応するアラーム時刻を算定
    float angle = atan2(150 - touchPoint.y,touchPoint.x - 150);
    self.alarmHour = (M_PI * 0.5 - angle) * 12.0 / (M_PI *2);
    if(self.alarmHour<0.0)
        self.alarmHour += 12.0;
    
   //アラームのビュー・アイテムを設定
    [self setAlarmItems];
    
}

-(void)saveUserDefaults;
{
    //ユーザー・デフォルトを取得
    
    NSUserDefaults *userDefults = [NSUserDefaults standardUserDefaults];
    
    [userDefults setBool:self.alarmEnabled forKey:kAlarmEnabledKey];
    [userDefults setFloat:self.alarmHour forKey:kAlarmHourKey];
    
    [userDefults synchronize];
    
}

@end
