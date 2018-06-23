//
//  MyTimerWindowController.m
//  N95
//
//  Created by AivenLau on 2018/6/15.
//  Copyright © 2018年 AivenLau. All rights reserved.
//

#import "MyTimerWindowController.h"

@interface MyTimerWindowController ()
@property (weak) IBOutlet NSTextField *Time_Lable;
@property (assign,nonatomic) BOOL   bNeedExit;
@property (weak) IBOutlet NSView *View;

@end

@implementation MyTimerWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    _nType = 0;
    _nDownTimer = 30;
    _bChanged = NO;
    [self F_StartTimer];
    self.window.movableByWindowBackground =YES;
    
    [self.View  setWantsLayer:YES];
    [self.View.layer setBackgroundColor:[[NSColor clearColor] CGColor]];
    [self.Time_Lable setBackgroundColor:[NSColor clearColor] ];
    
    [self.window setBackgroundColor:[NSColor clearColor]];//这一步已将window的背景设置为透明了；
    [self.window setOpaque:NO];
    [self.window setLevel:NSStatusWindowLevel];
    
}


-(void)F_StartTimer
{
    __weak MyTimerWindowController *weakself = self;
    _bNeedExit = NO;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        int ad = 0;
        int64_t N1 =(int64_t)[[NSDate date] timeIntervalSince1970];
        while(!weakself.bNeedExit)
        {
            if(weakself.bChanged)
            {
                weakself.bChanged = NO;
                N1 =(int64_t)[[NSDate date] timeIntervalSince1970];
            }
            if(ad == 0 || ad>=10)
            {
                ad=0;
                if(weakself.nType == 0)
                {
                    NSDate *date = [NSDate date];
                    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                    //实例化一个日期的对象,这个对象不是NSDate的是NSDateComponents的
                    NSDateComponents *com = [[NSDateComponents alloc] init];
                    //做一个标示，表示我们要什么内容
                    NSInteger flags =  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
                    //从一个日期里面把这些内容取出来
                    com = [calendar components:flags fromDate:date];
                    
                    NSInteger hour = [com hour];
                    NSInteger minute = [com minute];
                    NSInteger sec = [com second];
                    NSString *str = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)hour,(int)minute,(int)sec];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakself.Time_Lable.stringValue = str;
                    });
                    
                }
                else if(weakself.nType ==1)
                {
                    int aa;
                    aa = weakself.nDownTimer;
                    if(aa>=0)
                    {
                        int H =  aa/3600;
                        aa -=H*3600;
                        int M = aa/60;
                        int S = aa % 60;
                        NSString *str = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)H,(int)M,(int)S];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            weakself.Time_Lable.stringValue = str;
                        });
                        int64_t N2 =(int64_t)[[NSDate date] timeIntervalSince1970];
                        N2 = N2-N1;
                        if(N2>=1)
                        {
                            weakself.nDownTimer-=(int)N2;
                            
                        }
                    }
                    N1 =(int64_t)[[NSDate date] timeIntervalSince1970];
                }
                else if(weakself.nType ==2)
                {
                    
                }
            }
            ad++;
            usleep(1000*10);
        }
    });
}
-(void)setNType:(int)nType
{
    
    _nType = nType;
    if(self.nType==0)
    {
        
    }
}

@end
