//
//  USBDeviceTool.h
//  N95
//
//  Created by AivenLau on 2018/1/12.
//  Copyright © 2018年 AivenLau. All rights reserved.
//


#import <Foundation/Foundation.h>
#include <IOKit/hid/IOHIDManager.h>
#include <IOKit/hid/IOHIDKeys.h>
#import <limits.h>
typedef int (^hidItem)(IOHIDDeviceRef pDeviceRef, unsigned short pVendorID, unsigned short pProductID, BOOL *pStop);


@interface USBDeviceTool : NSObject



@property(assign,nonatomic)  BOOL  bFindDevice;
@property(assign,nonatomic)  UInt16  nVendorID;
@property(assign,nonatomic)  UInt16  nProductID;
+ (USBDeviceTool *)share;

-(int)F_SentCmd:(NSData *)data;
-(void)F_FindDevice;
-(int)F_ReadBattery;

@end
