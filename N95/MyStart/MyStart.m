//
//  MyStart.m
//  N95
//
//  Created by AivenLau on 2018/1/12.
//  Copyright © 2018年 AivenLau. All rights reserved.
//

#import "MyStart.h"
#import "MyLogin_Setup.h"
#include "AppDelegate.h"
#import "MyMainView.h"
@interface MyStart ()<NSPopoverDelegate>
@property(assign,nonatomic) BOOL  bDispSetup;
@property(assign,nonatomic) BOOL  bFisetDisp;
@property(strong,nonatomic)  NSPopover *popover;
@property (weak) IBOutlet NSView *HeadView;
@property (weak) IBOutlet NSView *BottomView;


@end

@implementation MyStart

- (void)windowDidLoad {
    [super windowDidLoad];
    
    
    // Do view setup here.
    self.bDispSetup = NO;
    _bFisetDisp = YES;
    
    [self.HeadView setWantsLayer:YES];
    [self.HeadView.layer setBackgroundColor:[[NSColor colorWithRed:49/255.0f green:99/255.0f blue:170/255.0f alpha:1.0] CGColor]];
    
    [self.BottomView setWantsLayer:YES];
    [self.BottomView.layer setBackgroundColor:[[NSColor colorWithRed:80/255.0f green:84/255.0f blue:93/255.0f alpha:1.0] CGColor]];
    
    MyLogin_Setup *mypopoverView = [[MyLogin_Setup alloc] initWithNibName:@"MyLogin_Setup" bundle:nil];//继承nsviewcontroller的类
    mypopoverView.startView = self;
    _popover = [[NSPopover alloc] init];
    [_popover setContentViewController:mypopoverView];
    [_popover setAnimates:YES];
    _popover.appearance = [NSAppearance appearanceNamed:NSAppearanceNameAqua];
    //_popover.appearance =NSPopoverAppearanceHUD;
    _popover.behavior = NSPopoverBehaviorTransient;
    _popover.delegate = self;
    
    self.window.styleMask =NSWindowStyleMaskBorderless;
    self.window.titlebarAppearsTransparent =YES;
    self.window.movableByWindowBackground =YES;
    
    
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
-(void)F_Close
{
    [self close];
}



@end
