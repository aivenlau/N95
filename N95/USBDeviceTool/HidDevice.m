//
//  HidDevice.m
//  N95
//
//  Created by AivenLau on 2018/5/5.
//  Copyright © 2018年 AivenLau. All rights reserved.
//

#import "HidDevice.h"

static id _instance;






@interface HidDevice()
{
    char *inputbuffer;
}

@property (assign , nonatomic) IOHIDManagerRef managerRef;
@property (assign , nonatomic) IOHIDDeviceRef deviceRef;

@property(assign,nonatomic)  UInt16  nVendorID;
@property(assign,nonatomic)  UInt16  nProductID;

-(BOOL)isMatchHid:(IOHIDDeviceRef)devuceFef;


@end


//////////////
void Handle_DeviceOutgoingData(void* context, IOReturn result, void* sender, IOHIDReportType type, uint32_t reportID, uint8_t *report,CFIndex reportLength) {
    //[[USBDeviceTool share].delegate robotPenUSBRecvData:report];
    NSLog(@"dfdf");
}
void Handle_DeviceMatchingCallback(void *inContext,IOReturn inResult,void *inSender,IOHIDDeviceRef inIOHIDDeviceRef) {
    
    // BOOL isRot = [[USBDeviceTool share] isRobotProdut:inIOHIDDeviceRef];
    BOOL re =[ [HidDevice shareinstance] isMatchHid:inIOHIDDeviceRef];
    if (re && ![HidDevice shareinstance].deviceRef)
    {
        //IOReturn ret = IOHIDDeviceOpen(inIOHIDDeviceRef, 0L);
        [HidDevice shareinstance].deviceRef = inIOHIDDeviceRef;
        [HidDevice shareinstance].bHasHid = YES;
        // [[HidDevice share].delegate robotPenUSBConnectDevice:inIOHIDDeviceRef];
        /*
        if (ret == kIOReturnSuccess)
        {
            char *inputbuffer = malloc(64);
            IOHIDDeviceRegisterInputReportCallback(inIOHIDDeviceRef, (uint8_t*)inputbuffer, 64, Handle_DeviceOutgoingData, NULL);
        }
         */
    }
}

void Handle_DeviceRemovalCallback(void *inContext,IOReturn inResult,void *inSender,IOHIDDeviceRef inIOHIDDeviceRef) {
    
    BOOL re =[ [HidDevice shareinstance] isMatchHid:inIOHIDDeviceRef];
    //if (re)
        //[[HidDevice shareinstance].delegate robotPenUSBRomveDevice];
    if(re)
    {
        [HidDevice shareinstance].deviceRef =nil;
        [HidDevice shareinstance].bHasHid = NO;
    }
     
}

static int32_t get_int_property(IOHIDDeviceRef device, CFStringRef key)
{
    CFTypeRef ref;
    int32_t value;
    
    ref = IOHIDDeviceGetProperty(device, key);
    
    if (ref) {
        if (CFGetTypeID(ref) == CFNumberGetTypeID())
        {
            CFNumberGetValue((CFNumberRef) ref, kCFNumberSInt32Type, &value);
            return value;
        }
    }
    return 0;
}

static CFStringRef get_string_property(IOHIDDeviceRef device, CFStringRef prop )
{
    CFTypeRef ref;
    
    ref = IOHIDDeviceGetProperty(device, prop);
    
    if (ref) {
        if (CFGetTypeID(ref) == CFStringGetTypeID()) {
            return ref;
        }
    }
    return 0;
}


static unsigned short get_vendor_id(IOHIDDeviceRef device)
{
    return get_int_property(device, CFSTR(kIOHIDVendorIDKey));
}

static unsigned short get_product_id(IOHIDDeviceRef device)
{
    return get_int_property(device, CFSTR(kIOHIDProductIDKey));
}





@implementation HidDevice
//重写allocWithZone:方法，在这里创建唯一的实例(注意线程安全)
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
            [_instance inia];
        }
    });
    return _instance;
    
}

-(BOOL)isMatchHid:(IOHIDDeviceRef)devuceFef
{
    UInt16 dev_vid = get_vendor_id(devuceFef);
    UInt16 dev_pid = get_product_id(devuceFef);
    if(dev_pid == self.nProductID && dev_vid == self.nVendorID)
    {
        return YES;
    }
    return NO;
}


-(void)inia
{
    
    _nVendorID = 0x1915;
    _nProductID = 0x0040;
     inputbuffer = malloc(64);
    self.managerRef = IOHIDManagerCreate(kCFAllocatorDefault, kIOHIDOptionsTypeNone);
    IOHIDManagerScheduleWithRunLoop(self.managerRef, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
    IOReturn ret = IOHIDManagerOpen(self.managerRef, kIOHIDOptionsTypeNone);
    if (ret != kIOReturnSuccess) {
        NSLog(@"打开失败");
    }
    IOHIDManagerRegisterDeviceMatchingCallback(self.managerRef, &Handle_DeviceMatchingCallback, NULL);
    IOHIDManagerRegisterDeviceRemovalCallback(self.managerRef, &Handle_DeviceRemovalCallback, NULL);
    IOHIDManagerSetDeviceMatching(self.managerRef, NULL);
}

-(void)dealloc
{
    if(inputbuffer!=NULL)
    {
        free(inputbuffer);
        inputbuffer = NULL;
    }
}

// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}
// 为了使实例易于外界访问 我们一般提供一个类方法
// 类方法命名规范 share类名|default类名|类名
+(instancetype)shareinstance
{
    //return _instance;
    return [[self alloc]init];
}




-(void)connectDevice
{
    if (!_deviceRef) {
        IOHIDManagerSetDeviceMatching(self.managerRef, NULL);
        return;
    }
    
}
-(void)disConnectDevice
{
    if (!_deviceRef) {
        return;
    }
    
    
    if ([[HidDevice shareinstance] isMatchHid:_deviceRef])
    {
        
        //[self exitOutUSBState];
        IOReturn ret = IOHIDDeviceClose(_deviceRef, 0L);
        if (ret == kIOReturnSuccess) {
            //_deviceRef = nil;
            //[[USBDeviceTool share].delegate robotPenUSBRomveDevice];
        }
    }
    return;
}

-(int)SentCmd:(NSData *)data
{
    if(self.bHasHid)
    {
        IOReturn ret = IOHIDDeviceOpen(_deviceRef, 0L);
        if (ret != kIOReturnSuccess) {
            return -1;
        }
        IOHIDDeviceRegisterInputReportCallback(_deviceRef, (uint8_t*)inputbuffer, 64, Handle_DeviceOutgoingData, NULL);
        IOHIDDeviceScheduleWithRunLoop(_deviceRef, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
        /*
         const unsigned short cOutputReportSize = get_int_property(_deviceRef, CFSTR(kIOHIDMaxOutputReportSizeKey));
         const unsigned short cFeatyreReportSize = get_int_property(_deviceRef, CFSTR(kIOHIDMaxFeatureReportSizeKey));
         const unsigned short cInputReportSize = get_int_property(_deviceRef, CFSTR(kIOHIDMaxInputReportSizeKey));
         */
        uint8_t outBuffer[20];
        
        NSInteger reportSize = data.length;
        if(reportSize>20)
        {
        
            reportSize = 20;
        }
        const UInt8 * pdata = (UInt8 *)[data bytes];
        memcpy(&outBuffer[0], pdata, reportSize);
        const uint8_t *data_to_send = (const uint8_t *)outBuffer;
        // send command to device
        CFIndex reportID = (CFIndex)(*pdata);
        
        
        //res =   IOHIDDeviceSetReportWithCallback(mDeviceRef, kIOHIDReportTypeOutput, reportID, data_to_send, cOutputReportSize, 1, _IOHIDReportCallback, NULL);
        ret = IOHIDDeviceSetReport(_deviceRef, kIOHIDReportTypeOutput, reportID, data_to_send,reportSize);//reportSize);// data.length);//cOutputReportSize ); // sendingReportSize + cReportIDPad
        if (ret == kIOReturnSuccess )
        {
            usleep(1000*200);
        }
        IOReturn dd = kIOReturnNotFound;
       // ret = IOHIDDeviceClose(_deviceRef, kIOHIDOptionsTypeNone);
        //_deviceRef = nil;
    }
    return -10;
}




@end
