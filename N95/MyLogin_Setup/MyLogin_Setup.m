//
//  MyLogin_Setup.m
//  N95
//
//  Created by AivenLau on 2017/12/4.
//  Copyright © 2017年 AivenLau. All rights reserved.
//

#import "MyLogin_Setup.h"
#import "MyMainView.h"

@interface MyLogin_Setup ()
@property (weak) IBOutlet NSButton *Button1;
@property (weak) IBOutlet NSButton *Button2;
@property (weak) IBOutlet NSButton *Button3;
@property (weak) IBOutlet NSButton *Button4;

@property (strong) IBOutlet NSView *RootView;

@end

@implementation MyLogin_Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    NSColor *color = [NSColor colorWithCalibratedRed:1.0f  green:1.0f blue:1.0f alpha:1.0f];
    
    
    [self F_SetButBackColor:_Button1 Color:color];
    [self F_SetButBackColor:_Button2 Color:color];
    [self F_SetButBackColor:_Button3 Color:color];
    [self F_SetButBackColor:_Button4 Color:color];
    
}

-(void)viewDidAppear
{
}
-(void)F_SetButBackColor:(NSButton *)bt Color:(NSColor *)color
{
    NSButtonCell *cell =bt.cell;
    cell.bordered = NO;
    cell.backgroundColor=color;
}

- (IBAction)LinkerClick:(id)sender {
    MyMainView *view1 = [[MyMainView alloc] initWithNibName:@"MyMainView" bundle:nil];
    [self presentViewControllerAsModalWindow:view1];
    [_startView F_Close];
}

- (IBAction)ExitAll_Clicked:(id)sender {
    [[NSApplication sharedApplication] terminate:nil]; 
}
@end
