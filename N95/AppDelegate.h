//
//  AppDelegate.h
//  N95
//
//  Created by AivenLau on 2017/12/4.
//  Copyright © 2017年 AivenLau. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "USBDeviceTool.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    
}

@property(strong,nonatomic)USBDeviceTool *device;


@end

