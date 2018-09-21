//
//  HidDevice.h
//  N95
//
//  Created by AivenLau on 2018/5/5.
//  Copyright © 2018年 AivenLau. All rights reserved.eeeeeeeee
//

#import<Foundation/Foundation.h>
#include <IOKit/hid/IOHIDManager.h>
#include <IOKit/hid/IOHIDKeys.h>


typedef int (^hidItem)(IOHIDDeviceRef pDeviceRef, UInt16 pVendorID, UInt16 pProductID, BOOL *pStop);

@interface HidDevice : NSObject
{
    

}
@property(assign,nonatomic)  BOOL   bHasHid;
@property(assign,nonatomic)  BOOL   bCanMoved;
@property(assign,nonatomic)  BOOL   bExit;



+(instancetype)shareinstance;
-(int)SentCmd:(NSData *)data;
-(void)disConnectDevice;



@end
