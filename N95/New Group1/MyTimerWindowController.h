//
//  MyTimerWindowController.h
//  N95
//
//  Created by AivenLau on 2018/6/15.
//  Copyright © 2018年 AivenLau. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyTimerWindowController : NSWindowController

@property(assign,nonatomic) int nType;
@property(assign,nonatomic) int nDownTimer;
@property(assign,nonatomic) BOOL bChanged;

@end
