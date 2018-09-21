//
//  AppDelegate.m
//  N95
//
//  Created by AivenLau on 2017/12/4.e
//  Copyright © 2017年 AivenLau. All rights reserved.
//

#import "AppDelegate.h"
#import "MyStart.h"
#import "MyMainView.h"
#import "HidDevice.h"

@interface AppDelegate ()
{
    
}
@property(strong,nonatomic) NSStatusItem *statusItem;
@property (strong, nonatomic)MyStart *windowsController_A;
@property(strong,nonatomic)  MyMainView *mainViewController;
@property(strong,nonatomic)  MyStart *StartViewController;
@property(strong,nonatomic)  NSWindow *window;
@property(strong,nonatomic)  NSWindowController  *windowController;
@end

#define KNotificationCenter [NSNotificationCenter defaultCenter]
@implementation AppDelegate
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _hid_device = [HidDevice shareinstance];
 
    
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* language = [[languages objectAtIndex:0] uppercaseString];
    
    //"zh-Hant-CN",
    //"zh-Hans-CN",
    
    //NSString * localeString = [[NSLocale currentLocale] localeIdentifier];
    //NSString * language = [[[localeString componentsSeparatedByString:@"_"] objectAtIndex:0] uppercaseString];
    
    NSLog(@"%@",languages);
    NSLog(@"%@",language);
    
    

    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    NSImage *image = [NSImage imageNamed:@"icon"];
    [_statusItem setImage:image];
    [_statusItem setHighlightMode:YES];
    [_statusItem setToolTip:@"N95"];
    [_statusItem setAction:@selector(statusOnClick:)];
    
    NSMenu *subMenu = [[NSMenu alloc] initWithTitle:@"Load_TEXT"];
    [subMenu addItemWithTitle:@"显示主界面"action:@selector(load1) keyEquivalent:@"D"];
    [subMenu addItemWithTitle:@"退出"action:@selector(quitApp) keyEquivalent:@"Q"];
    _statusItem.menu = subMenu;


#if 1
#if 1
    self.mainViewController = [[MyMainView alloc] initWithNibName:@"MyMainView" bundle:nil];
    self.window = [NSWindow windowWithContentViewController:self.mainViewController];
    self.windowController = [[NSWindowController alloc] initWithWindow:self.window];
    [self.windowController showWindow:self];
    [self.windowController.window center];
    
#else
    self.windowsController_A =[[MyStart alloc] initWithWindowNibName:@"MyStart"];
    [self.windowsController_A showWindow:self];
    [self.windowsController_A.window center];
#endif
#else
    __weak AppDelegate *weakself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UInt8 readBattery[]={0x81,0x80,0x00,0x01,0x04,0x00,0x00,0x00};  //电量
        NSData *data = [[NSData alloc] initWithBytes:readBattery length:8];
        [weakself.hid_device SentCmd:data];
    });
        
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(500 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
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
#endif

}



-(void)quitApp
{
    [NSApp terminate:self];
}

- (void)load1
{
    NSLog(@"load1 ---- ");
    
    //[KNotificationCenter postNotificationName:@"F_DispMainView" object:nil];
    [_mainViewController F_DispMainView];
}

- (void)statusOnClick:(NSStatusItem *)item{
    NSLog(@"statusOnClick ----- ");
}

-(void)onstatusItemClicked
{
    
}



- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
