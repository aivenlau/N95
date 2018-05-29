//
//  MyMainView.m
//  N95
//
//  Created by AivenLau on 2017/12/14.
//  Copyright © 2017年 AivenLau. All rights reserved.
//

#import "MyMainView.h"

@interface MyMainView ()
@property (strong) IBOutlet NSView *View_First;
@property (strong) IBOutlet NSView *View_Image;

@property (weak) IBOutlet NSImageView *Img_View;

@property (weak) IBOutlet NSButton *Menu_Button1;
@property (weak) IBOutlet NSButton *Menu_Button2;
@property (weak) IBOutlet NSButton *Menu_Button3;
@property (weak) IBOutlet NSButton *Menu_Button4;
@property (weak) IBOutlet NSButton *Menu_Button5;
@property (weak) IBOutlet NSView *Line1;
@property (weak) IBOutlet NSView *Line2;
@property (weak) IBOutlet NSView *Line3;
@property (weak) IBOutlet NSView *Line4;
@property (weak) IBOutlet NSView *Line5;

@property (weak) IBOutlet NSSlider *mSlider;


@property (weak) IBOutlet NSButton *Button1;
@property (weak) IBOutlet NSButton *Button2;
@property (weak) IBOutlet NSButton *Button3;
@property (weak) IBOutlet NSButton *Button4;
@property (weak) IBOutlet NSView *HeadView;
@property (weak) IBOutlet NSView *BottomView;
@property (weak) IBOutlet NSView *MyView;
@property (strong) IBOutlet NSView *Normal_View;
@property (weak) IBOutlet NSView *Normal_SelectView;
@property (strong) IBOutlet NSView *Normal_Timer_View;
@property (strong) IBOutlet NSView *Normal_Pointer_View;
@property (strong) IBOutlet NSView *Normal_Next_View;

@property (strong) IBOutlet NSView *Main_Pointer_View;
@property (strong) IBOutlet NSView *Main_Alarm_View;
@property (strong) IBOutlet NSView *Main_Linker_View;
@property (strong) IBOutlet NSView *Main_About_View;


@property (weak) IBOutlet NSButton *Timer_Radio1;
@property (weak) IBOutlet NSButton *Timer_Radio2;
@property (weak) IBOutlet NSButton *Timer_Radio3;
@property (weak) IBOutlet NSButton *Timer_Radio4;
@property (weak) IBOutlet NSButton *Timer_Radio5;

@property (weak) IBOutlet NSButton *Next_Radio1;
@property (weak) IBOutlet NSButton *Next_Radio2;
@property (weak) IBOutlet NSButton *Next_Radio3;
@property (weak) IBOutlet NSButton *Next_Radio4;
@property (weak) IBOutlet NSButton *Next_Radio5;
@property (weak) IBOutlet NSButton *Next_Radio6;

@property(assign)     int   nMain_Selected;
@property(assign)     int   nNorMal_Selected;
@property(assign)     int   nTimer_Selected;
@property(assign)     int   nNext_Selected;
@property(assign)     int   nPre_Selected;
@property (weak) IBOutlet NSLayoutConstraint *tag_imgview_wh_constraint;
@property (weak) IBOutlet NSView *back_vview;
@property (weak) IBOutlet NSView *Porinter_Line1_View;
@property (weak) IBOutlet NSView *Porinter_Line2_View;
@property (weak) IBOutlet NSSlider *Pointer_Speed_Slider;
@property (weak) IBOutlet NSSlider *Vibration_Slider;


@property (weak) IBOutlet NSView *Alarm_Line1_View;
@property (weak) IBOutlet NSView *Alarm_Line2_View;
@property (weak) IBOutlet NSView *Alarm_Line3_View;

@property (weak) IBOutlet NSView *About_Line1_View;
@property (weak) IBOutlet NSView *About_Line2_View;
@property (weak) IBOutlet NSView *About_Line3_View;

@property (strong) IBOutlet NSView *Linker_View1;
@property (strong) IBOutlet NSView *Linker_View2;


@property(assign,nonatomic) CGFloat  nPointerSpeed;
@property(assign,nonatomic) CGFloat  nVibration;

@property (weak) IBOutlet NSButton *Next_Pre_Radio;

@property(assign)   CGFloat tagWidth;


@property(assign,nonatomic) BOOL  bExit;


@property(assign,nonatomic)  int  nImageViewWH;

@property(assign,nonatomic)  int bCanMoved;


@property(assign,nonatomic)  BOOL  bDispMain;

@property(assign,nonatomic)  BOOL  bMainViewDisped;



@end

#define KNotificationCenter [NSNotificationCenter defaultCenter]

#define  CIR_WIDTH  (200)

@implementation MyMainView
#define WWW (180)

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bExit =NO;
    _bCanMoved = NO;
    _nImageViewWH = CIR_WIDTH;
    _bDispMain=YES;
    _mSlider.integerValue = 0;
    
    //[self.view setWantsLayer:YES];
    //[self.view.layer setBackgroundColor:[[NSColor colorWithRed:0.0f green:0.0f blue:1.0f alpha:0.0] CGColor]];
    
    [self.View_Image setWantsLayer:YES];
    [self.View_Image.layer setBackgroundColor:[[NSColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:0.0] CGColor]];
    
    
    [self.HeadView setWantsLayer:YES];
    [self.HeadView.layer setBackgroundColor:[[NSColor colorWithRed:49/255.0f green:99/255.0f blue:170/255.0f alpha:1.0] CGColor]];
    
    [self.BottomView setWantsLayer:YES];
    [self.BottomView.layer setBackgroundColor:[[NSColor colorWithRed:75/255.0f green:81/255.0f blue:90/255.0f alpha:1.0] CGColor]];
    
    [self.Normal_Timer_View setWantsLayer:YES];
    [self.Normal_Timer_View.layer setBackgroundColor:[[NSColor whiteColor] CGColor]];
    
    [self.Normal_Pointer_View setWantsLayer:YES];
    [self.Normal_Pointer_View.layer setBackgroundColor:[[NSColor whiteColor] CGColor]];
    
    [self.Normal_Next_View setWantsLayer:YES];
    [self.Normal_Next_View.layer setBackgroundColor:[[NSColor whiteColor] CGColor]];
    
    [self.Porinter_Line1_View setWantsLayer:YES];
    [self.Porinter_Line1_View.layer setBackgroundColor:[[NSColor whiteColor] CGColor]];
    [self.Porinter_Line2_View setWantsLayer:YES];
    [self.Porinter_Line2_View.layer setBackgroundColor:[[NSColor whiteColor] CGColor]];
    
    
    [self.Alarm_Line1_View setWantsLayer:YES];
    [self.Alarm_Line1_View.layer setBackgroundColor:[[NSColor whiteColor] CGColor]];
    
    [self.Alarm_Line2_View setWantsLayer:YES];
    [self.Alarm_Line2_View.layer setBackgroundColor:[[NSColor whiteColor] CGColor]];
    
    [self.Alarm_Line3_View setWantsLayer:YES];
    [self.Alarm_Line3_View.layer setBackgroundColor:[[NSColor whiteColor] CGColor]];
    
    [self.About_Line1_View setWantsLayer:YES];
    [self.About_Line1_View.layer setBackgroundColor:[[NSColor whiteColor] CGColor]];
    
    [self.About_Line2_View setWantsLayer:YES];
    [self.About_Line2_View.layer setBackgroundColor:[[NSColor whiteColor] CGColor]];
    
    [self.About_Line3_View setWantsLayer:YES];
    [self.About_Line3_View.layer setBackgroundColor:[[NSColor whiteColor] CGColor]];
    [self.back_vview setWantsLayer:YES];
    [self.back_vview.layer setBackgroundColor:[[NSColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.5] CGColor]];
    
    
    
    [self.Line1 setWantsLayer:YES];
    [self.Line2 setWantsLayer:YES];
    [self.Line3 setWantsLayer:YES];
    [self.Line4 setWantsLayer:YES];
    [self.Line5 setWantsLayer:YES];
    
    
    
    [self F_InsertMain];
    [self F_Insert:nil];
    
    self.nNorMal_Selected = 1;
    self.nMain_Selected = 1;
    self.nPointerSpeed = 20;
    self.nVibration = 20;
    
    [self F_SetSelect];
    [self F_DispTimer_Next_Selected];
    [self F_DispTimer_Next_Selected_Radio];
    self.tagWidth =self.tag_imgview_wh_constraint.constant;
    self.Vibration_Slider.integerValue = _nVibration;
    self.Pointer_Speed_Slider.integerValue = _nPointerSpeed;
    [self F_SetMainMenu:self.nMain_Selected];
    __weak MyMainView *weakself = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while(!weakself.bExit)
        {
         //   HidDevice *hid_device = [HidDevice shareinstance];
            if(!weakself.bCanMoved)
            {
                usleep(1000*10);
                continue;
            }
            NSPoint pp=[NSEvent mouseLocation];
            NSPoint p = pp;
            NSPoint pppp;
            
            pppp.x = pp.x;
            pppp.y = pp.y;
            //NSLog(@"Point at x=%d y=%d",(int)(p.x*df),(int)(p.y*df));
            NSWindow *win = [[NSApplication sharedApplication].windows lastObject];
            if(win)
            {
                [win setOpaque:YES];
                CGRect rect = win.frame;
                CGFloat w = rect.size.width/2;
                CGFloat h = rect.size.height/2;
                p.x-=w;
                p.y-=h;
                int nx = (int)p.x;
                int ny = (int)p.y;
                int ox =(int)rect.origin.x;
                int oy =(int)rect.origin.y;
                if(nx != ox || ny != oy)
                {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        CGFloat df = [NSScreen mainScreen].backingScaleFactor;
                        NSRect ScreenFrame = [[NSScreen mainScreen] frame];
                        NSInteger winnum = win.windowNumber;
                        
                        CGRect  FRame = win.frame;
                        if(FRame.size.width !=weakself.nImageViewWH ||
                           FRame.size.height !=weakself.nImageViewWH
                           )
                        {
                            FRame.size.width =weakself.nImageViewWH;
                            FRame.size.height = weakself.nImageViewWH;
                            [win setFrame:FRame display:YES];
                        }
                        [win setFrameOrigin:p];
                        CGWindowID cgwinnum = (CGWindowID)winnum;
                        CFArrayRef windowsRef = CGWindowListCreate( kCGWindowListOptionOnScreenBelowWindow, cgwinnum);
                        NSRect rectA;// = [[NSScreen mainScreen] frame];
                        NSPoint pt = pppp;
                        pt.y = ScreenFrame.size.height-pppp.y;
                        rectA.size.width=WWW;
                        rectA.size.height=WWW;
                        rectA.origin.x=pt.x-(WWW/2);
                        rectA.origin.y=pt.y-(WWW/2);
                        CGImageRef imgRef = CGWindowListCreateImageFromArray(rectA, windowsRef, kCGWindowImageDefault);
                        CFRelease(windowsRef);
                        NSImage *img = [[NSImage alloc] initWithCGImage:imgRef size:NSZeroSize];
                        CGImageRelease(imgRef);
                        CGSize tarSize;
                        tarSize.height = weakself.nImageViewWH*df;
                        tarSize.width = weakself.nImageViewWH*df;
                        [img setSize:tarSize];
                        weakself.Img_View.image = img;
                        [weakself.Img_View setWantsLayer: YES];  // edit: enable the layer for the view.  Thanks omz
                        weakself.Img_View.layer.borderWidth = 4.0;
                        weakself.Img_View.layer.borderColor =[[NSColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:0.8] CGColor];
                        weakself.Img_View.layer.cornerRadius = weakself.Img_View.frame.size.width/2;// weakself.nImageViewWH;
                        weakself.Img_View.layer.masksToBounds = YES;
                    });
                }
                usleep(1000*10);
            }
        }
    });
    
    [KNotificationCenter addObserver:self selector:@selector(CanMoved) name:@"CanMoved" object:nil];
    [KNotificationCenter addObserver:self selector:@selector(ReleaseCanMoved) name:@"ReleaseCanMoved" object:nil];
    [KNotificationCenter addObserver:self selector:@selector(F_DispMainView) name:@"F_DispMainView" object:nil];
    _bDispMain = YES;
    [self F_SetDispMagnifier:NO];
}

-(void)F_DispMainView
{
    if(_bMainViewDisped)
    {
        _bDispMain = NO;
    }
    else
    {
        _bDispMain = YES;
    }
    [self F_SetDispMagnifier:NO];
}

-(void)dealloc
{
    [KNotificationCenter removeObserver:self];
}

-(void)ReleaseCanMoved
{
    if(_bCanMoved)
    {
        _bCanMoved = NO;
        _bDispMain = NO;
        [self F_SetDispMagnifier:NO];
    }
    
}
-(void)CanMoved
{
    if(!_bCanMoved)
    {
        _bCanMoved = YES;
        NSWindow *win = [[NSApplication sharedApplication].windows lastObject];
        [win setBackgroundColor:[NSColor clearColor]];//这一步已将window的背景设置为透明了；
        [win setOpaque:NO];
        [self F_SetDispMagnifier:_bCanMoved];
    }
}

-(void)F_SetMainMenu:(int)ix
{    
    NSColor *color_sel = [NSColor colorWithCalibratedRed:49/255.0f   green:99/255.0f blue:170/255.0f alpha:1.0f];
    NSColor *color = [NSColor colorWithCalibratedRed:1.0f  green:1.0f blue:1.0f alpha:1.0f];
    if(ix == 1)
    {
        [self.Line1.layer setBackgroundColor:[color_sel CGColor]];
        [self.Line2.layer setBackgroundColor:[color CGColor]];
        [self.Line3.layer setBackgroundColor:[color CGColor]];
        [self.Line4.layer setBackgroundColor:[color CGColor]];
        [self.Line5.layer setBackgroundColor:[color CGColor]];
        
        _Normal_View.hidden = NO;
        _Main_Pointer_View.hidden = YES;
        _Main_Alarm_View.hidden = YES;
        _Main_Linker_View.hidden = YES;
        _Main_About_View.hidden = YES;
        
    }
    if(ix == 2)
    {
        [self.Line1.layer setBackgroundColor:[color CGColor]];
        [self.Line2.layer setBackgroundColor:[color_sel CGColor]];
        [self.Line3.layer setBackgroundColor:[color CGColor]];
        [self.Line4.layer setBackgroundColor:[color CGColor]];
        [self.Line5.layer setBackgroundColor:[color CGColor]];
        _Normal_View.hidden = YES;
        _Main_Pointer_View.hidden = NO;
        _Main_Alarm_View.hidden = YES;
        _Main_Linker_View.hidden = YES;
        _Main_About_View.hidden = YES;
    }
    if(ix == 3)
    {
        [self.Line1.layer setBackgroundColor:[color CGColor]];
        [self.Line2.layer setBackgroundColor:[color CGColor]];
        [self.Line3.layer setBackgroundColor:[color_sel CGColor]];
        [self.Line4.layer setBackgroundColor:[color CGColor]];
        [self.Line5.layer setBackgroundColor:[color CGColor]];
        _Normal_View.hidden = YES;
        _Main_Pointer_View.hidden = YES;
        _Main_Alarm_View.hidden = NO;
        _Main_Linker_View.hidden = YES;
        _Main_About_View.hidden = YES;
        
    }
    if(ix == 4)
    {
        [self.Line1.layer setBackgroundColor:[color CGColor]];
        [self.Line2.layer setBackgroundColor:[color CGColor]];
        [self.Line3.layer setBackgroundColor:[color CGColor]];
        [self.Line4.layer setBackgroundColor:[color_sel CGColor]];
        [self.Line5.layer setBackgroundColor:[color CGColor]];
        _Normal_View.hidden = YES;
        _Main_Pointer_View.hidden = YES;
        _Main_Alarm_View.hidden = YES;
        _Main_Linker_View.hidden = NO;
        _Main_About_View.hidden = YES;
    }
    if(ix == 5)
    {
        [self.Line1.layer setBackgroundColor:[color CGColor]];
        [self.Line2.layer setBackgroundColor:[color CGColor]];
        [self.Line3.layer setBackgroundColor:[color CGColor]];
        [self.Line4.layer setBackgroundColor:[color CGColor]];
        [self.Line5.layer setBackgroundColor:[color_sel CGColor]];
        _Normal_View.hidden = YES;
        _Main_Pointer_View.hidden = YES;
        _Main_Alarm_View.hidden = YES;
        _Main_Linker_View.hidden = YES;
        _Main_About_View.hidden = NO;
        
    }
}

-(void)F_DispTimer_Next_Selected_Radio
{
    if(self.nTimer_Selected == 0)
    {
        self.Timer_Radio1.state = 1;
    }
    if(self.nTimer_Selected == 1)
    {
        self.Timer_Radio2.state = 1;
    }
    if(self.nTimer_Selected == 2)
    {
        self.Timer_Radio3.state = 1;
    }
    if(self.nTimer_Selected == 3)
    {
        self.Timer_Radio4.state = 1;
    }
    if(self.nTimer_Selected == 4)
    {
        self.Timer_Radio5.state = 1;
    }
    if(_nNorMal_Selected== 3)
    {
        if(self.nNext_Selected == 0)
        {
            self.Next_Radio1.state = 1;
        }
        if(self.nNext_Selected == 1)
        {
            self.Next_Radio2.state = 1;
        }
        if(self.nNext_Selected == 2)
        {
            self.Next_Radio3.state = 1;
        }
        if(self.nNext_Selected == 3)
        {
            self.Next_Radio4.state = 1;
        }
        if(self.nNext_Selected == 4)
        {
            self.Next_Radio5.state = 1;
        }
        if(self.nNext_Selected == 5)
        {
            self.Next_Radio6.state = 1;
        }
    }
    if(_nNorMal_Selected== 4)
    {
        if(self.nPre_Selected == 0)
        {
            self.Next_Radio1.state = 1;
        }
        if(self.nPre_Selected == 1)
        {
            self.Next_Radio2.state = 1;
        }
        if(self.nPre_Selected == 2)
        {
            self.Next_Radio3.state = 1;
        }
        if(self.nPre_Selected == 3)
        {
            self.Next_Radio4.state = 1;
        }
        if(self.nPre_Selected == 4)
        {
            self.Next_Radio5.state = 1;
        }
        if(self.nPre_Selected == 5)
        {
            self.Next_Radio6.state = 1;
        }
    }
    
}
-(void)F_InsertA:(NSView *)view
{
    if(view==nil)
    {
        return;
    }
    view.hidden = YES;
    NSArray *array = [self.view subviews];
    for(NSView *viewA in array)
    {
        if(viewA == view)
            return;
    }
    NSLayoutConstraint *constraint;
    [self.view addSubview:view];
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    constraint =[
                 NSLayoutConstraint
                 constraintWithItem:view
                 attribute:NSLayoutAttributeWidth
                 relatedBy:NSLayoutRelationEqual
                 toItem:self.view
                 attribute:NSLayoutAttributeWidth
                 multiplier:1.0f
                 constant:0.0f
                 ];
    [self.view addConstraint:constraint];
    constraint =[
                 NSLayoutConstraint
                 constraintWithItem:view
                 attribute:NSLayoutAttributeHeight
                 relatedBy:NSLayoutRelationEqual
                 toItem:self.view
                 attribute:NSLayoutAttributeHeight
                 multiplier:1.0f
                 constant:0.0f
                 ];
    [self.view addConstraint:constraint];
    
    
    constraint =[
                 NSLayoutConstraint
                 constraintWithItem:view
                 attribute:NSLayoutAttributeLeading
                 relatedBy:NSLayoutRelationEqual
                 toItem:self.view
                 attribute:NSLayoutAttributeLeading
                 multiplier:1.0f
                 constant:0.0f
                 ];
    [self.view addConstraint:constraint];
    
    constraint = [
                  NSLayoutConstraint
                  constraintWithItem:view
                  attribute:NSLayoutAttributeTop
                  relatedBy:NSLayoutRelationEqual
                  toItem:self.view
                  attribute:NSLayoutAttributeTop
                  multiplier:1.0f
                  constant:0.0f
                  ];
    
    [self.view addConstraint:constraint];
    
}

-(void)F_SetDispMagnifier:(BOOL)bDisp
{
    __weak MyMainView *weakself =self;
#if 1
    dispatch_async(dispatch_get_main_queue(), ^{
        if(bDisp)
        {
            CGFloat df = [NSScreen mainScreen].backingScaleFactor;
            
            weakself.View_Image.hidden = NO;
            weakself.View_First.hidden = YES;
            NSWindow *win = [[NSApplication sharedApplication].windows lastObject];
            [win setBackgroundColor:[NSColor clearColor]];//这一步已将window的背景设置为透明了；
            [win setOpaque:NO];
            
            CGRect  rect = win.frame;
            CGSize  size;
            rect.size.height=weakself.nImageViewWH;
            rect.size.width=weakself.nImageViewWH;
            size.width = weakself.nImageViewWH*df;
            size.height = size.width;
            NSImage *img = self.Img_View.image;
            if(img)
            {
                [img setSize:size];
            }
            else
            {
                img = [[NSImage alloc] initWithSize:size];
            }
            self.Img_View.image = img;
            
            [win setFrame:rect display:YES];
            
            NSPoint pp=[NSEvent mouseLocation];
            NSPoint p = pp;
            
            rect = win.frame;
            CGFloat w = rect.size.width/2;
            CGFloat h = rect.size.height/2;
            p.x-=w;
            p.y-=h;
            [win makeKeyAndOrderFront:nil];
            [win center];
//            [win setFrameOrigin:p];
            weakself.bMainViewDisped = NO;
        }
        else
        {
            weakself.View_Image.hidden = YES;
            weakself.View_First.hidden = NO;
            weakself.Img_View.image = nil;
            NSWindow *win = [[NSApplication sharedApplication].windows lastObject];
            NSImage *img = weakself.Img_View.image;
            if(img)
            {
                [img setSize:(NSMakeSize(1, 1))];
            }
            CGRect rrr = win.contentView.frame;
            CGRect  rect = win.frame;
            rect.size.height=491;
            rect.size.width=781;
            rrr.size = rect.size;
            [win setFrame:rect display:YES];
            [win setBackgroundColor:[NSColor whiteColor]];
            [win setOpaque:YES];
            if(!weakself.bDispMain)
            {
                weakself.bMainViewDisped = NO;
                [win orderOut:nil];
                //[win center];
            }
            else
            {
                weakself.bMainViewDisped = YES;
                [win makeKeyAndOrderFront:nil];
                [win center];
            }
        }
    });
#endif
}



-(void)F_InsertMain
{
    [self F_InsertA:_View_First];
    [self F_InsertA:_View_Image];
    _View_Image.hidden = YES;
    _View_First.hidden = NO;
    
}

-(void)F_Insert:(NSView *)view
{
    [self.Normal_SelectView addSubview:_Normal_Timer_View];
    [self.Normal_SelectView addSubview:_Normal_Pointer_View];
    [self.Normal_SelectView addSubview:_Normal_Next_View];
    
    [self.Main_Linker_View addSubview:_Linker_View1];
    [self.Main_Linker_View addSubview:_Linker_View2];
    _Linker_View1.hidden = NO;
    _Linker_View2.hidden = YES;
    
    _Normal_SelectView.hidden = NO;
    _Normal_Timer_View.hidden = YES;
    _Normal_Pointer_View.hidden = YES;
    _Normal_Next_View.hidden = YES;
    
    
    
    [self.MyView addSubview:_Normal_View];
    [self.MyView addSubview:_Main_Pointer_View];
    [self.MyView addSubview:_Main_Alarm_View];
    [self.MyView addSubview:_Main_Linker_View];
    [self.MyView addSubview:_Main_About_View];
}

-(void)F_SetSelect
{
    NSColor *color_sel = [NSColor colorWithCalibratedRed:115/255.0f   green:163/255.0f blue:212/255.0f alpha:1.0f];
    NSColor *color = [NSColor colorWithCalibratedRed:1.0f  green:1.0f blue:1.0f alpha:1.0f];
    int inx = self.nNorMal_Selected;
    if(inx ==1)
    {
        [self F_DispNorMal_byInx:1];
        [self F_SetButBackColor:_Button1 Color:color_sel];
        [self F_SetButBackColor:_Button2 Color:color];
        [self F_SetButBackColor:_Button3 Color:color];
        [self F_SetButBackColor:_Button4 Color:color];
    }
    if(inx ==2)
    {
        [self F_DispNorMal_byInx:2];
        [self F_SetButBackColor:_Button1 Color:color];
        [self F_SetButBackColor:_Button2 Color:color_sel];
        [self F_SetButBackColor:_Button3 Color:color];
        [self F_SetButBackColor:_Button4 Color:color];
    }
    if(inx ==3)
    {
        [self F_DispNorMal_byInx:3];
        [self F_SetButBackColor:_Button1 Color:color];
        [self F_SetButBackColor:_Button2 Color:color];
        [self F_SetButBackColor:_Button3 Color:color_sel];
        [self F_SetButBackColor:_Button4 Color:color];
    }
    if(inx ==4)
    {
        [self F_DispNorMal_byInx:4];
        [self F_SetButBackColor:_Button1 Color:color];
        [self F_SetButBackColor:_Button2 Color:color];
        [self F_SetButBackColor:_Button3 Color:color];
        [self F_SetButBackColor:_Button4 Color:color_sel];
    }
}

-(void)F_DispNorMal_byInx:(int)inx
{
    if(inx==1)
    {
        _Normal_Timer_View.hidden= NO;
        _Normal_Pointer_View.hidden = YES;
        _Normal_Next_View.hidden = YES;
        
        
    }
    else if(inx ==2)
    {
        _Normal_Timer_View.hidden= YES;
        _Normal_Pointer_View.hidden = NO;
        _Normal_Next_View.hidden = YES;
    }
    else if(inx == 3 )
    {
        _Normal_Timer_View.hidden= YES;
        _Normal_Pointer_View.hidden = YES;
        _Normal_Next_View.hidden = NO;
        _Next_Pre_Radio.title = @"快进";
        [self F_DispTimer_Next_Selected_Radio];
        
    }
    else if(inx == 4)
    {
        _Normal_Timer_View.hidden= YES;
        _Normal_Pointer_View.hidden = YES;
        _Normal_Next_View.hidden = NO;
        _Next_Pre_Radio.title = @"快退";
        [self F_DispTimer_Next_Selected_Radio];
    }
    else
    {
        _Normal_Timer_View.hidden= YES;
        _Normal_Pointer_View.hidden = YES;
        _Normal_Next_View.hidden = YES;
    }
    
}
- (IBAction)Changed_tag_size:(id)sender {
    NSSlider *slider = (NSSlider *)sender;
    NSInteger n = slider.integerValue;
    CGFloat dx = (n-50)/100.0f;
    dx=1+dx;
    CGFloat dw =  self.tagWidth*dx;
    self.tag_imgview_wh_constraint.constant = dw;
    _nImageViewWH = (int)(CIR_WIDTH+n);
}


-(void)F_SetButBackColor:(NSButton *)bt Color:(NSColor *)color
{
    NSButtonCell *cell =bt.cell;
    cell.bordered = NO;
    cell.backgroundColor=color;
}

-(void)viewDidAppear
{
    [super viewDidAppear];
    NSWindow *win = [[NSApplication sharedApplication].windows lastObject];
    win.styleMask =NSWindowStyleMaskBorderless;
    win.titlebarAppearsTransparent =YES;
    win.movableByWindowBackground =YES;
    [win makeKeyAndOrderFront:nil];
    [win setLevel: NSScreenSaverWindowLevel];
    
    
}

- (IBAction)Select_Fuc1_Click:(id)sender {
    self.nNorMal_Selected = 1;
    [self F_SetSelect];
}
- (IBAction)Select_Fuc2_Click:(id)sender {
    self.nNorMal_Selected = 2;
    [self F_SetSelect];
}
- (IBAction)Select_Fuc3_Click:(id)sender {
    self.nNorMal_Selected = 3;
    [self F_SetSelect];
}
- (IBAction)Select_Fuc4_Click:(id)sender {
    self.nNorMal_Selected =4;
    [self F_SetSelect];
}

-(void)F_DispTimer_Next_Selected
{
    //NSString *spac=@"　";
    NSString *sTitle = @"　　计时器　　　　　　　　　　关闭";
    if(self.nTimer_Selected == 1)
    {
        
        sTitle = @"　　定时器　　　　　　　　显示时针";
    }
    if(self.nTimer_Selected == 2)
    {
        sTitle = @"　　定时器　　　　　　　　　30分钟";
    }
    if(self.nTimer_Selected == 3)
    {
        sTitle = @"　　定时器　　　　　　　　　60分钟";
    }
    if(self.nTimer_Selected == 4)
    {
        sTitle = @"　　定时器　　　　　　　　　自定义";
    }
    self.Button1.title = sTitle;
    
    sTitle =@"　　长按下一页按钮　　　　　无操作";
    if(self.nNext_Selected == 1)
    {
        
        
        sTitle =@"　　长按下一页按钮　　　　　　快进";
        
    }
    if(self.nNext_Selected == 2)
    {
        sTitle =@"　　长按下一页按钮　　　　　　滚动";
    }
    if(self.nNext_Selected == 3)
    {
        sTitle =@"　　长按下一页按钮　　　　空白屏幕";
    }
    if(self.nNext_Selected == 4)
    {
        sTitle =@"　　长按下一页按钮　　　　音量控制";
    }
    if(self.nNext_Selected == 5)
    {
        sTitle =@"　　长按下一页按钮　　　自定义按键";
    }
    self.Button3.title = sTitle;
    
    
    sTitle =@"　　长按上一页按钮　　　　　无操作";
    if(self.nPre_Selected == 1)
    {
        
        
        sTitle =@"　　长按上一页按钮　　　　　　快退";
        
    }
    if(self.nPre_Selected == 2)
    {
        sTitle =@"　　长按上一页按钮　　　　　　滚动";
    }
    if(self.nPre_Selected == 3)
    {
        sTitle =@"　　长按上一页按钮　　　　空白屏幕";
    }
    if(self.nPre_Selected == 4)
    {
        sTitle =@"　　长按上一页按钮　　　　音量控制";
    }
    if(self.nPre_Selected == 5)
    {
        sTitle =@"　　长按上一页按钮　　　自定义按键";
    }
    self.Button4.title = sTitle;
    
}

- (IBAction)Timer_Radio_Click:(id)sender {
    
    if(sender == _Timer_Radio1 )
    {
        self.nTimer_Selected = 0;
    }
    if(sender == _Timer_Radio2 )
    {
        self.nTimer_Selected = 1;
    }
    if(sender == _Timer_Radio3 )
    {
        self.nTimer_Selected = 2;
    }
    if(sender == _Timer_Radio4 )
    {
        self.nTimer_Selected = 3;
    }
    if(sender == _Timer_Radio5 )
    {
        self.nTimer_Selected = 4;
    }
    
    if(self.nNorMal_Selected==3)
    {
        if(sender == _Next_Radio1 )
        {
            self.nNext_Selected = 0;
        }
        if(sender == _Next_Radio2 )
        {
            self.nNext_Selected = 1;
        }
        if(sender == _Next_Radio3 )
        {
            self.nNext_Selected = 2;
        }
        if(sender == _Next_Radio4 )
        {
            self.nNext_Selected = 3;
        }
        if(sender == _Next_Radio5 )
        {
            self.nNext_Selected = 4;
        }
        if(sender == _Next_Radio6 )
        {
            self.nNext_Selected = 5;
        }
    }
    
    if(self.nNorMal_Selected==4)
    {
        if(sender == _Next_Radio1 )
        {
            self.nPre_Selected = 0;
        }
        if(sender == _Next_Radio2 )
        {
            self.nPre_Selected = 1;
        }
        if(sender == _Next_Radio3 )
        {
            self.nPre_Selected = 2;
        }
        if(sender == _Next_Radio4 )
        {
            self.nPre_Selected = 3;
        }
        if(sender == _Next_Radio5 )
        {
            self.nPre_Selected = 4;
        }
        if(sender == _Next_Radio6 )
        {
            self.nPre_Selected = 5;
        }
    }
    
    //NSLog(@"Select %d",nSelect);
    [self F_DispTimer_Next_Selected];
}

- (IBAction)MainMenu_Click:(id)sender {
    if(sender == self.Menu_Button1)
    {
        _nMain_Selected = 1;
    }
    if(sender == self.Menu_Button2)
    {
        _nMain_Selected = 2;
        /*
        NSPoint p=[NSEvent mouseLocation];
        CGImageRef screenShot = CGWindowListCreateImage(CGRectInfinite, kCGWindowListOptionOnScreenOnly, kCGNullWindowID, kCGWindowImageDefault);
        NSImage *img2 = [[NSImage alloc] initWithCGImage:screenShot size:NSZeroSize];
        int w=(int)img2.size.width;
        int h=(int)img2.size.height;
        
        CGImageRelease(screenShot);
         */
        
    }
    if(sender == self.Menu_Button3)
    {
        _nMain_Selected = 3;
    }
    if(sender == self.Menu_Button4)
    {
        _nMain_Selected = 4;
    }
    if(sender == self.Menu_Button5)
    {
        _nMain_Selected = 5;
    }
    [self F_SetMainMenu:self.nMain_Selected];
}
- (IBAction)Link_New_Click:(id)sender {
    /*
     _Linker_View1.hidden = YES;
     _Linker_View2.hidden = NO;
     
     HidDevice *hidtool =[HidDevice shareinstance];
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
     int ix=0;
     int64_t T1 =  (int64_t)([[NSDate date] timeIntervalSince1970] * 1000);
     while(true)
     {
     [hidtool F_FindDevice];
     usleep(200);
     if(hidtool.bFindDevice)
     {
     break;
     }
     int64_t T2 = (int64_t)( [[NSDate date] timeIntervalSince1970] * 1000);
     if(T2-T1>=1000*10)
     {
     break;
     }
     
     
     }
     dispatch_async(dispatch_get_main_queue(), ^{
     _Linker_View1.hidden = NO;
     _Linker_View2.hidden = YES;
     });
     
     });
     */
}


@end
