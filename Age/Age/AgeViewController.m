//
//  AgeViewController.m
//  Age
//
//  Created by 14cm0132 on 2014/06/24.
//  Copyright (c) 2014年 jec.ac.jp. All rights reserved.
//

#import "AgeViewController.h"

@interface AgeViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *birthdayPicker;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unitControl;

@end

@implementation AgeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //デイト・ピッカーを今日の日付に設定
    self.birthdayPicker.date = [NSDate date];
    
    //年齢を計算
    [self calc];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calc {
    
    //年齢計算
    //デイト・ピッカーからの誕生日の取得
    NSDate *birthday = self.birthdayPicker.date;
    
    //今日の日付を取得
    NSDate *today = [NSDate date];
    
    
    //グレゴリオ暦のカレンダーを作成
    
    NSCalendar * gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    
    
    //期間の単位の設定
    NSUInteger unitFlags;
    switch (self.unitControl.selectedSegmentIndex) {
        case 0:
            unitFlags = NSYearCalendarUnit;
            break;
        case 1:
            unitFlags = NSMonthCalendarUnit;
            break;
        case 2:
            unitFlags = NSDayCalendarUnit;
            break;
            
            
        default:
            break;
    }
    
    //誕生日から今日までの期間を求める
    
    NSDateComponents *components = [gregorian components:unitFlags fromDate:birthday toDate:today options:0];
    
    //期間から年齢を得る
    
    NSInteger age;
    switch (unitFlags) {
        case NSYearCalendarUnit:
            age =[components year];
            break;
        case NSMonthCalendarUnit:
            age = [components month];
            break;
        case NSDayCalendarUnit:
            age = [components day];
                break;
            
        default:
            break;
    }
            
    //年齢を結果ラベルに表示
    self.resultLabel.text = [NSString stringWithFormat:@"%d",age];
            
            
    //表示単位によって年齢ラベルの表示を変更
    switch (unitFlags) {
        case NSYearCalendarUnit:
            self.ageLabel.text = NSLocalizedString(@"Age in Years", @"");
            break;
        case NSMonthCalendarUnit:
            self.ageLabel.text = NSLocalizedString(@"Age in Months", @"");
            break;
        case NSDayCalendarUnit:
            self.ageLabel.text = NSLocalizedString(@"Age in Days", @"");
            break;
    }
    
    
    
}
@end
