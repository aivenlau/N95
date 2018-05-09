//
//  AppDelegate.m
//  N95
//
//  Created by AivenLau on 2017/12/4.
//  Copyright © 2017年 AivenLau. All rights reserved.
//

#import "AppDelegate.h"
#import "MyStart.h"
#import "MyMainView.h"
#import "HidDevice.h"
#import "USBDeviceTool.h"
@interface AppDelegate ()
@property(strong,nonnull) NSStatusItem *statusItem;

@property (strong, nonatomic)MyStart *windowsController_A;
@property(strong,nonatomic)  MyMainView *mainViewController;
@property(strong,nonatomic)  NSWindow *window;
@property(strong,nonatomic)  NSWindowController  *windowController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _hid_device = [HidDevice shareinstance];
    USBDeviceTool *dd = [USBDeviceTool share];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //UInt8 readBattery[]={0x81,0x80,0x00,0x04,0x00,0x00,0x00,0x00};
        UInt8 readBattery[]={0x81,0x40,0x00,0x01,0x00,0x00,0x00,0x00};
        //UInt8 readBattery[]={0x81,0x00,0x00,0x00,0x04,0x00,0x00,0x00};
        NSData *data = [[NSData alloc] initWithBytes:readBattery length:8];
        //[_hid_device SentCmd:data];
        [dd F_SentCmd:data];
    });
    
    __weak  AppDelegate *weakself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(100 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        
        if(weakself.hid_device.bHasHid)
        {
            weakself.mainViewController = [[MyMainView alloc] initWithNibName:@"MyMainView" bundle:nil];
            weakself.window = [NSWindow windowWithContentViewController:weakself.mainViewController];
            weakself.windowController = [[NSWindowController alloc] initWithWindow:weakself.window];
            [weakself.windowController showWindow:self];
            [weakself.windowController.window center];
        }
        else
        {
            weakself.windowsController_A =[[MyStart alloc] initWithWindowNibName:@"MyStart"];
            [weakself.windowsController_A showWindow:self];
            [weakself.windowsController_A.window center];
        }
    });
    /*
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    NSImage *image = [NSImage imageNamed:@"icon"];
    [_statusItem setImage:image];
    [_statusItem setHighlightMode:YES];
    [_statusItem setToolTip:@"StatusItem"];
    */
    
    
}

-(void)onstatusItemClicked
{
    
}



- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
