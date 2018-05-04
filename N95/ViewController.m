//
//  ViewController.m
//  N95
//
//  Created by AivenLau on 2017/12/4.
//  Copyright © 2017年 AivenLau. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "MyN95.h"
#import "MyLogin_Setup.h"

@interface ViewController ()<NSPopoverDelegate>
@property(assign,nonatomic) BOOL  bDispSetup;
@property(assign,nonatomic) BOOL  bFisetDisp;
@property(strong,nonatomic)  NSPopover *popover;
 


@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.bDispSetup = NO;
    _bFisetDisp = YES;
    [self.view.layer setBackgroundColor:[[NSColor colorWithRed:222/255.0f green:223/255.0f blue:225/255.0f alpha:1.0] CGColor]];
    
    
    [self.HeadView setWantsLayer:YES];
    [self.HeadView.layer setBackgroundColor:[[NSColor colorWithRed:49/255.0f green:99/255.0f blue:170/255.0f alpha:1.0] CGColor]];
    
    [self.BottomView setWantsLayer:YES];
    [self.BottomView.layer setBackgroundColor:[[NSColor colorWithRed:80/255.0f green:84/255.0f blue:93/255.0f alpha:1.0] CGColor]];
    
    MyLogin_Setup *mypopoverView = [[MyLogin_Setup alloc] initWithNibName:@"MyLogin_Setup" bundle:nil];//继承nsviewcontroller的类
    _popover = [[NSPopover alloc] init];
    [_popover setContentViewController:mypopoverView];
    [_popover setAnimates:YES];
    _popover.appearance = [NSAppearance appearanceNamed:NSAppearanceNameAqua];
    _popover.delegate = self;
    
    NSWindow *window = [[NSApplication sharedApplication].windows lastObject];
    //隐藏标题栏的背景色
    window.titlebarAppearsTransparent =YES;
    //设置可以通过window区域移动窗口
    window.movableByWindowBackground =YES;
}

-(void)viewWillAppear
{
    [super viewWillAppear];
    if(_bFisetDisp)
    {
        _bFisetDisp = NO;
    NSWindow *window = [[NSApplication sharedApplication].windows lastObject];
    CGRect  frame = window.frame;
    frame.origin.y+=200;
    [window setFrame:frame display:YES];
    }
}
- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (IBAction)Setup_Clicked:(id)sender {
    if(!self.popover.shown)
    {
        NSButton* btn = sender;
        NSRect cellRect = [btn bounds];        
        [self.popover showRelativeToRect:cellRect ofView:btn preferredEdge:NSMaxXEdge];
    }
    else
    {
        [self.popover close];
    }
}

- (void)popoverDidClose:(NSNotification *)notification
{
    
}


@end
