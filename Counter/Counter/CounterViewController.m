//
//  CounterViewController.m
//  Counter
//
//  Created by 14cm0132 on 2014/04/22.
//  Copyright (c) 2014年 jec.ac.jp. All rights reserved.
//

#import "CounterViewController.h"

@interface CounterViewController ()
{
    int count;
}

@property (weak, nonatomic) IBOutlet UILabel *display;

@end

@implementation CounterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib./Users/14cm0132/Documents/モバプロ/Counter/Counter/Base.lproj/Main.storyboard
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) updateDisplay
{

    if(count%100 == 0){
      
        self.display.textColor = [UIColor redColor]; //100で割り切れたら赤
    }else
        if(count%10 == 0){
        self.display.textColor = [UIColor blueColor]; //10で割り切れたら青
    }else
    {
        self.display.textColor = [UIColor whiteColor]; //100でも10でも割り切れなければ白
    }
    if(count == 0000){
        self.display.textColor =[UIColor whiteColor]; //カウントが0000の時は白、これでキリ番からクリアしても文字色が白に戻る
    }
    self.display.text = [NSString stringWithFormat:@"%04d", count]; //カウントの数字を4桁に


}
- (IBAction)add {
    count  = count + 1;
    [self updateDisplay];
    
}
- (IBAction)subtract {
    count = count - 1;
    if (count < 0 )
        count = 0;
    [self updateDisplay];
}

- (IBAction)clear {
    count =  0;
    [self updateDisplay];
    
}

@end
