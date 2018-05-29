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
    
@public
    BOOL    _bIsMoved;
}

@property (assign , nonatomic) char *inputbuffer;

@property (assign , nonatomic) IOHIDManagerRef managerRef;
@property (assign , nonatomic) IOHIDDeviceRef deviceRef;

@property(assign,nonatomic)  UInt16  nVendorID;
@property(assign,nonatomic)  UInt16  nProductID;
//@property(assign,nonatomic)


-(BOOL)isMatchHid:(IOHIDDeviceRef)devuceFef;


@end

static int nNum = 0;
//////////////
void Handle_valueData(void * _Nullable        context,
                    IOReturn                result,
                    void * _Nullable        sender,
                      IOHIDValueRef           value)
{
    /*
    IOHIDElementRef elem = IOHIDValueGetElement( value );
    uint32_t scancode = IOHIDElementGetUsage( elem );
    NSLog(@"dddddfffff");
    */
    
    
    
    
}
void Handle_DeviceOutgoingData(void* context, IOReturn result, void* sender, IOHIDReportType type, uint32_t reportID, uint8_t *report,CFIndex reportLength) {
    //[[USBDeviceTool share].delegate robotPenUSBRecvData:report];
    
    NSString *str=@"";;
    int len =(int ) reportLength;//strlen((const char*)report);
    for(int i=0;i<len;i++)
    {
        str=[NSString stringWithFormat:@"%@ %02X",str,report[i]];
    }
    HidDevice *hiddevice = (__bridge HidDevice *)context;
    if(len == 4 && report[0] == 0x02)
    {
        nNum++;
        if(nNum>6)
        {
            nNum = 6;
            hiddevice->_bIsMoved = YES;
        }
    }
    else
    {
        nNum=0;
    }
    NSLog(@"GetData %@",str);
}
void Handle_DeviceMatchingCallback(void *inContext,IOReturn inResult,void *inSender,IOHIDDeviceRef inIOHIDDeviceRef) {
    static int kk = 0;
    BOOL re =[ [HidDevice shareinstance] isMatchHid:inIOHIDDeviceRef];
    if(re)
    {
        NSLog(@"Get %d",kk);
        kk++;
    }
    if (re && ![HidDevice shareinstance].deviceRef)
    {
        [HidDevice shareinstance].deviceRef = inIOHIDDeviceRef;
        [HidDevice shareinstance].bHasHid = YES;
        
        IOHIDDeviceRegisterInputReportCallback([HidDevice shareinstance].deviceRef, (uint8_t*)[HidDevice shareinstance].inputbuffer, 64, Handle_DeviceOutgoingData, (void *)[HidDevice shareinstance]);
        IOHIDDeviceScheduleWithRunLoop([HidDevice shareinstance].deviceRef, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
        //IOHIDDeviceRegisterInputValueCallback([HidDevice shareinstance].deviceRef, Handle_valueData, (void *)[HidDevice shareinstance]);
        //IOHIDDeviceInterface
         Byte buff[]={0x81,0x00,0x00,0x00,0x04,0x00,0x00,0x01};
        NSData *data = [[NSData alloc] initWithBytes:buff length:8];
        [[HidDevice shareinstance] SentCmd:data];
    }
}

void Handle_DeviceRemovalCallback(void *inContext,IOReturn inResult,void *inSender,IOHIDDeviceRef inIOHIDDeviceRef) {
    BOOL re =[ [HidDevice shareinstance] isMatchHid:inIOHIDDeviceRef];
    if(re)
    {
        [HidDevice shareinstance].deviceRef =nil;
        [HidDevice shareinstance].bHasHid = NO;
        NSLog(@"Removed!");
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

/*
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
*/

static unsigned short get_vendor_id(IOHIDDeviceRef device)
{
    return get_int_property(device, CFSTR(kIOHIDVendorIDKey));
}

static unsigned short get_product_id(IOHIDDeviceRef device)
{
    return get_int_property(device, CFSTR(kIOHIDProductIDKey));
}



#define KNotificationCenter [NSNotificationCenter defaultCenter]

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


-(void)F_SetartCheck
{
    __weak HidDevice *weakself = self;
    __block int nT=0;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (!weakself.bExit)
        {
            if(self->_bIsMoved)
            {
                self->_bIsMoved = NO;
                weakself.bCanMoved = YES;
                [KNotificationCenter postNotificationName:@"CanMoved" object:nil];
                nT=0;
            }
            else
            {
                nT++;
                if(nT>=5)
                {
                    if(weakself.bCanMoved)
                    {
                        weakself.bCanMoved = NO;
                        nNum=0;
                        [KNotificationCenter postNotificationName:@"ReleaseCanMoved" object:nil];
                    }
                    nT=10;
                }
            }
            usleep(1000*50);
        }
    });
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


CFMutableDictionaryRef myCreateDeviceMatchingDictionary(UInt32 usagePage,  UInt32 usage )
{
    CFMutableDictionaryRef dict = CFDictionaryCreateMutable(
                                                            kCFAllocatorDefault, 0
                                                            , & kCFTypeDictionaryKeyCallBacks
                                                            , & kCFTypeDictionaryValueCallBacks );
    if ( ! dict )
        return NULL;
    
    CFNumberRef pageNumberRef = CFNumberCreate( kCFAllocatorDefault, kCFNumberIntType, & usagePage );
    if ( ! pageNumberRef ) {
        CFRelease( dict );
        return NULL;
    }
    
    CFDictionarySetValue( dict, CFSTR(kIOHIDDeviceUsagePageKey), pageNumberRef );
    CFRelease( pageNumberRef );
    
    CFNumberRef usageNumberRef = CFNumberCreate( kCFAllocatorDefault, kCFNumberIntType, & usage );
    
    if ( ! usageNumberRef ) {
        CFRelease( dict );
        return NULL;
    }
    
    CFDictionarySetValue( dict, CFSTR(kIOHIDDeviceUsageKey), usageNumberRef );
    CFRelease( usageNumberRef );
    
    return dict;
}

-(void)inia
{
 
    _bCanMoved = NO;
    _bExit = NO;
    _nVendorID = 0x046d;//0x1915;
    _nProductID = 0xb503;//0x0040;
    
    _nVendorID = 0x1915;
    _nProductID = 0x0040;
     _inputbuffer = malloc(64);
    self.managerRef = IOHIDManagerCreate(kCFAllocatorDefault, kIOHIDOptionsTypeNone);
    IOHIDManagerScheduleWithRunLoop(self.managerRef, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
    IOReturn ret = IOHIDManagerOpen(self.managerRef, kIOHIDOptionsTypeNone);
    if (ret != kIOReturnSuccess) {
        NSLog(@"打开失败");
    }
    
    IOHIDManagerRegisterDeviceMatchingCallback(self.managerRef, &Handle_DeviceMatchingCallback, NULL);
    IOHIDManagerRegisterDeviceRemovalCallback(self.managerRef, &Handle_DeviceRemovalCallback, NULL);
    IOHIDManagerSetDeviceMatching(self.managerRef, NULL);
    
    [self F_SetartCheck];
}

-(void)dealloc
{
    if(_inputbuffer!=NULL)
    {
        free(_inputbuffer);
        _inputbuffer = NULL;
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
        //IOHIDDeviceRegisterInputReportCallback(_deviceRef, (uint8_t*)inputbuffer, 64, Handle_DeviceOutgoingData, (void *)self);
        //IOHIDDeviceScheduleWithRunLoop(_deviceRef, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
        
         const unsigned short cOutputReportSize = get_int_property(_deviceRef, CFSTR(kIOHIDMaxOutputReportSizeKey));
         const unsigned short cFeatyreReportSize = get_int_property(_deviceRef, CFSTR(kIOHIDMaxFeatureReportSizeKey));
         const unsigned short cInputReportSize = get_int_property(_deviceRef, CFSTR(kIOHIDMaxInputReportSizeKey));
        
        uint8_t outBuffer[20];
        
        NSInteger reportSize = data.length;
        if(reportSize>20)
        {
            reportSize = 20;
        }
        const UInt8 * pdata = (UInt8 *)[data bytes];
        memcpy(&outBuffer[0], pdata, reportSize);
        const uint8_t *data_to_send = (const uint8_t *)outBuffer;
        CFIndex reportID = (CFIndex)(*pdata);
        
        ret = IOHIDDeviceSetReport(_deviceRef, kIOHIDReportTypeOutput, reportID, data_to_send,reportSize);//reportSize);// data.length);//cOutputReportSize ); // sendingReportSize + cReportIDPad
        if (ret == kIOReturnSuccess )
        {
            usleep(1000*200);
        }
       // IOReturn dd = kIOReturnNotFound;
       // ret = IOHIDDeviceClose(_deviceRef, kIOHIDOptionsTypeNone);
        //_deviceRef = nil;
    }
    return -10;
}




@end
