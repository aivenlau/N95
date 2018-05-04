//
//  USBDeviceTool.m
//  N95
//
//  Created by AivenLau on 2018/1/12.
//  Copyright © 2018年 AivenLau. All rights reserved.
//

#import "USBDeviceTool.h"
#import "libusb.h"
#include <dlfcn.h>
#define inputBufferLen    1000
static uint8_t inputBuffer[inputBufferLen];

static uint8_t outputBuffer[inputBufferLen];
static IOHIDDeviceRef *device_array=NULL;
static CFSetRef device_set=NULL;

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
/*
static CFStringRef get_product_string(IOHIDDeviceRef device)
{
    return get_string_property(device, CFSTR(kIOHIDProductKey));
}


static CFStringRef get_transport(IOHIDDeviceRef device)
{
    return get_string_property(device, CFSTR(kIOHIDTransportKey));
}
*/
int processHIDs_comd(hidItem pItem)
{
    int result = 0 ;
    
    IOHIDManagerRef hid_mgr = IOHIDManagerCreate(kCFAllocatorDefault, kIOHIDOptionsTypeNone);
    
    if (hid_mgr){
        IOHIDManagerSetDeviceMatching(hid_mgr, NULL);
        IOHIDManagerScheduleWithRunLoop(hid_mgr, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
        
        // see how many devices we have
        if(device_set!=NULL)
        {
            CFRelease(device_set);
        }
         device_set = IOHIDManagerCopyDevices(hid_mgr);
        CFRelease(hid_mgr);
        
        /* Convert the list into a C array so we can iterate easily. */
        CFIndex num_devices = CFSetGetCount(device_set);
        
        if (num_devices)
        {
            BOOL shouldStop = FALSE;
            
            if(device_array!=NULL)
            {
                free(device_array);
            }
            device_array = calloc(num_devices, sizeof(IOHIDDeviceRef));
            CFSetGetValues(device_set, (const void **) device_array);
            for (int i = 0; i < num_devices && !shouldStop ; i++)
            {
                IOHIDDeviceRef dev = device_array[i];
                if (dev)
                {
                    unsigned short dev_vid = get_vendor_id(dev);
                    unsigned short dev_pid = get_product_id(dev);
                    result = pItem(dev, dev_vid, dev_pid, &shouldStop);
                }
                
            }
        }
        //CFRelease(device_set);
    }
    return result;
}

bool processHIDs(unsigned short nVendorID,unsigned short nPordoctID)
{
    
    IOHIDManagerRef hid_mgr = IOHIDManagerCreate(kCFAllocatorDefault, kIOHIDOptionsTypeNone);
    bool bFind=false;
    if (hid_mgr)
    {
        IOHIDManagerSetDeviceMatching(hid_mgr, NULL);
        IOHIDManagerScheduleWithRunLoop(hid_mgr, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
        // see how many devices we have        
        CFSetRef device_set = IOHIDManagerCopyDevices(hid_mgr);
        CFRelease(hid_mgr);
        CFIndex num_devices = CFSetGetCount(device_set);

        if (num_devices)
        {
            BOOL shouldStop = FALSE;
            
            IOHIDDeviceRef *device_array = calloc(num_devices, sizeof(IOHIDDeviceRef));
            CFSetGetValues(device_set, (const void **) device_array);
            
            for (int i = 0; i < num_devices && !shouldStop ; i++)
            {
                IOHIDDeviceRef dev = device_array[i];
                
                if (dev) {
                    unsigned short dev_vid = get_vendor_id(dev);
                    unsigned short dev_pid = get_product_id(dev);
                    if(nVendorID == dev_vid && nPordoctID == dev_pid)
                    {
                        bFind=true;
                        break;
                    }
                }
            }
            free(device_array);
        }
        CFRelease(device_set);
    }
    return bFind;
}


void theIOHIDReportCallback (int*                    counter,
                             IOReturn                result,
                             void *                  sender,
                             IOHIDReportType         type,
                             uint32_t                reportID,
                             uint8_t *               report,
                             CFIndex                 reportLength)
{
    // the device responded, so we can stop the runloop
   // NSLog(@"-----GetData Type = %d,reportID=%d",type,reportID);
    
    if ( type == kIOHIDReportTypeInput )
    {
        NSLog(@"dfdf");
        /*
        unsigned long len = reportLength;//strlen((const char*)report);
        NSMutableString *value = [NSMutableString stringWithCapacity:len*2];
        // skip first byte
        for (NSUInteger i = 0; i < len; ++i)
        {
            [value appendFormat:@"%02X ", report[i]];
        }
        NSLog(@"%@", value);
        *counter = *counter +1;
         */
    }
    else{
        int i=0;
        i=1;
    }
}



static USBDeviceTool *_tool = nil;


@interface USBDeviceTool ()
{
    IOHIDDeviceRef mDeviceRef;
}
@end


@implementation USBDeviceTool

+ (USBDeviceTool *)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_tool) {
            _tool = [[USBDeviceTool alloc] init];
        }
    });
    return _tool;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        mDeviceRef = NULL;
        _nVendorID = 0x1915;// 0x046d;
        _nProductID =0x0040;// 0xb503;
        [self F_FindDevice];
    }
    return self;
}

-(void)F_FindDevice
{
  //  _bFindDevice = processHIDs(_nVendorID,_nProductID);
    [self F_Connected];
}

-(void)F_DisConnected
{
    if(mDeviceRef!=NULL)
    {
        IOHIDDeviceClose(mDeviceRef, kIOHIDOptionsTypeNone);
        mDeviceRef = NULL;
    }
}

-(int)F_Connected
{
    processHIDs_comd( ^(IOHIDDeviceRef pDeviceRef, unsigned short pVendorID, unsigned short pProductID, BOOL *pStop){
        if(pVendorID == _nVendorID && pProductID == _nProductID)
        {
            _bFindDevice = YES;
            mDeviceRef = pDeviceRef;
            IOReturn res = IOHIDDeviceOpen(mDeviceRef, kIOHIDOptionsTypeSeizeDevice); // kIOHIDOptionsTypeSeizeDevice
            if(res == kIOReturnSuccess)
            {
                *pStop = true;
            }
        }
        return true;
    });
    return 0;
}

static io_service_t hidapi_IOHIDDeviceGetService(IOHIDDeviceRef device)
{
    static void *iokit_framework = NULL;
    static io_service_t (*dynamic_IOHIDDeviceGetService)(IOHIDDeviceRef device) = NULL;
    
    /* Use dlopen()/dlsym() to get a pointer to IOHIDDeviceGetService() if it exists.
     * If any of these steps fail, dynamic_IOHIDDeviceGetService will be left NULL
     * and the fallback method will be used.
     */
    if (iokit_framework == NULL) {
        iokit_framework = dlopen("/System/Library/IOKit.framework/IOKit", RTLD_LAZY);
        
        if (iokit_framework != NULL)
            dynamic_IOHIDDeviceGetService = dlsym(iokit_framework, "IOHIDDeviceGetService");
    }
    
    if (dynamic_IOHIDDeviceGetService != NULL) {
        /* Running on OS X 10.6 and above: IOHIDDeviceGetService() exists */
        return dynamic_IOHIDDeviceGetService(device);
    }
    else
    {
        /* Running on OS X 10.5: IOHIDDeviceGetService() doesn't exist.
         *
         * Be naughty and pull the service out of the IOHIDDevice.
         * IOHIDDevice is an opaque struct not exposed to applications, but its
         * layout is stable through all available versions of OS X.
         * Tested and working on OS X 10.5.8 i386, x86_64, and ppc.
         */
        struct IOHIDDevice_internal {
            /* The first field of the IOHIDDevice struct is a
             * CFRuntimeBase (which is a private CF struct).
             *
             * a, b, and c are the 3 fields that make up a CFRuntimeBase.
             * See http://opensource.apple.com/source/CF/CF-476.18/CFRuntime.h
             *
             * The second field of the IOHIDDevice is the io_service_t we're looking for.
             */
            uintptr_t a;
            uint8_t b[4];
#if __LP64__
            uint32_t c;
#endif
            io_service_t service;
        };
        struct IOHIDDevice_internal *tmp = (struct IOHIDDevice_internal *)device;
        
        return tmp->service;
    }
}

void _IOHIDReportCallback (
                             void * _Nullable        context,
                             IOReturn                result,
                             void * _Nullable        sender,
                             IOHIDReportType         type,
                             uint32_t                reportID,
                             uint8_t *               report,
                             CFIndex                 reportLength)
{
    int i=0;
    i = 1;
}

-(int)F_SentCmd:(NSData *)data
{
    /*
    libusb_context *ctx;
    libusb_device **devs;
    int rc;
    ssize_t cnt;
    
    rc = libusb_init(&ctx);
    cnt = libusb_get_device_list(ctx, &devs);
    libusb_device_handle *dev_handle;
    dev_handle = libusb_open_device_with_vid_pid(ctx,0x1915,0x0040);
    if(dev_handle == NULL) {
        libusb_exit(ctx);                 //close the session
        return -1;
    }
    if(libusb_kernel_driver_active(dev_handle, 0) == 1)
    {
        if(libusb_detach_kernel_driver(dev_handle, 0) == 0) //detach it
        {
            NSLog(@"Detach kernel driver!");
        }
    }
    rc = libusb_claim_interface(dev_handle, 0);
    */
    
    
#if 1
    if(!self.bFindDevice)
        return -1;
    if(data==nil)
        return -2;
#if 1
    if(mDeviceRef!=NULL)
    {
     //   io_object_t iokit_dev;
     //   kern_return_t res1;
     //   io_string_t path;
        
    //   iokit_dev = hidapi_IOHIDDeviceGetService(mDeviceRef);
    //   res1 = IORegistryEntryGetPath(iokit_dev, kIOServicePlane, path);
        
        IOReturn res ;
        const unsigned short cOutputReportSize = get_int_property(mDeviceRef, CFSTR(kIOHIDMaxOutputReportSizeKey));
        const unsigned short cFeatyreReportSize = get_int_property(mDeviceRef, CFSTR(kIOHIDMaxFeatureReportSizeKey));
        const unsigned short cInputReportSize = get_int_property(mDeviceRef, CFSTR(kIOHIDMaxInputReportSizeKey));
        //uint8_t *outBuffer = (uint8_t *) calloc(cOutputReportSize,sizeof(char));
        
        uint8_t outBuffer[20];// = (uint8_t *) calloc(20,sizeof(char));
        int  nosReportsReceived;
        // register our report callback
        IOHIDDeviceRegisterInputReportCallback(mDeviceRef, (uint8_t *)inputBuffer,
                                               inputBufferLen, (IOHIDReportCallback)theIOHIDReportCallback, NULL);
        //use this run loop
        IOHIDDeviceScheduleWithRunLoop(mDeviceRef, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
#define cReportIDPad 0 // first byte is used for report ID
        NSInteger reportSize = data.length-cReportIDPad;
        const UInt8 * pdata = (UInt8 *)[data bytes];
        memcpy(&outBuffer[0], pdata+cReportIDPad, reportSize);
        const uint8_t *data_to_send = (const uint8_t *)outBuffer;
        // send command to device
        CFIndex reportID = (CFIndex)(*pdata);
        nosReportsReceived = 0;
        
        //res =   IOHIDDeviceSetReportWithCallback(mDeviceRef, kIOHIDReportTypeOutput, reportID, data_to_send, cOutputReportSize, 1, _IOHIDReportCallback, NULL);
        res = IOHIDDeviceSetReport(mDeviceRef, kIOHIDReportTypeOutput, reportID, data_to_send,cOutputReportSize);//reportSize);// data.length);//cOutputReportSize ); // sendingReportSize + cReportIDPad
        if (res == kIOReturnSuccess )
        {
            usleep(1000*1000*20);
        }
        IOReturn dd = kIOReturnNotFound;
        res = IOHIDDeviceClose(mDeviceRef, kIOHIDOptionsTypeNone);
        
    }
    
#else
    processHIDs_comd( ^(IOHIDDeviceRef pDeviceRef, unsigned short pVendorID, unsigned short pProductID, BOOL *pStop){
        if(pVendorID == _nVendorID && pProductID == _nProductID)
        {
                IOReturn res = IOHIDDeviceOpen(pDeviceRef, kIOHIDOptionsTypeNone); // kIOHIDOptionsTypeSeizeDevice
                if(res == kIOReturnSuccess)
                {
                     const unsigned short cOutputReportSize = get_int_property(pDeviceRef, CFSTR(kIOHIDMaxOutputReportSizeKey));
                     const unsigned short cFeatyreReportSize = get_int_property(pDeviceRef, CFSTR(kIOHIDMaxFeatureReportSizeKey));
                     const unsigned short cInputReportSize = get_int_property(pDeviceRef, CFSTR(kIOHIDMaxInputReportSizeKey));
                   
                    //uint8_t *outBuffer = (uint8_t *) calloc(cOutputReportSize,sizeof(char));
                    uint8_t *outBuffer = (uint8_t *) calloc(20,sizeof(char));
                    int  nosReportsReceived;
                    // register our report callback
                    IOHIDDeviceRegisterInputReportCallback(pDeviceRef, (uint8_t *)inputBuffer,
                                                           inputBufferLen, (IOHIDReportCallback)theIOHIDReportCallback, &nosReportsReceived);
                    
                    //use this run loop
                    IOHIDDeviceScheduleWithRunLoop(pDeviceRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
                    
                    #define cReportIDPad 1 // first byte is used for report ID
                    NSInteger reportSize = data.length-cReportIDPad;
                    const UInt8 * pdata = (UInt8 *)[data bytes];
                    memcpy(&outBuffer[0], pdata+cReportIDPad, reportSize);
                    const uint8_t *data_to_send = (const uint8_t *)outBuffer;
                    
                    // send command to device
                    CFIndex reportID = (CFIndex)(*pdata);
                    nosReportsReceived = 0;
                    memcpy(outputBuffer,outBuffer,reportSize);
                    res = IOHIDDeviceSetReport(pDeviceRef, kIOHIDReportTypeFeature, reportID, outputBuffer,reportSize);
                    if (res == kIOReturnSuccess )
                    {
                        usleep(1000*10);
                    }
                    
                    IOReturn dd = kIOReturnNotFound;
                    free(outBuffer);
                    res = IOHIDDeviceClose(pDeviceRef, kIOHIDOptionsTypeNone);
                    *pStop = true;
                }
        }
        return true;
    });
#endif
#endif
    
    return 0;
}

-(int)F_ReadBattery
{
    if(!self.bFindDevice)
        return -1;
    return 0;
}



//链接：https://www.jianshu.com/p/46fa920e82cf

@end
