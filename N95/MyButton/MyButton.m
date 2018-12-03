//
//  MyButton.m
//  N95
//
//  Created by AivenLau on 2018/10/29.
//  Copyright © 2018 AivenLau. All rights reserved.
//

#import "MyButton.h"
@interface   MyButton()

@end

@implementation MyButton

- (instancetype)initWithFrame:(NSRect)frameRect
{
    if ((self = [super initWithFrame:frameRect]))
    {
        [self F_Init];
    }
    return self;
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)coder
{
    if ((self = [super initWithCoder:coder]))
    {
        [self F_Init];
    }
    return self;
}

-(void)F_Init
{
    _title1 = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 1, 10)];
    _title2 = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 1, 10)];
    
    [self addSubview:_title2];
    [self addSubview:_title1];
    
    _title1.translatesAutoresizingMaskIntoConstraints = NO;
    _title2.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint;
    /*
    constraint =[
                 NSLayoutConstraint
                 constraintWithItem:_title1
                 attribute:NSLayoutAttributeTop
                 relatedBy:NSLayoutRelationEqual
                 toItem:self
                 attribute:NSLayoutAttributeTop
                 multiplier:1
                 constant:0.0f
                 ];
    [self addConstraint:constraint];
    constraint =[
                 NSLayoutConstraint
                 constraintWithItem:_title1
                 attribute:NSLayoutAttributeBottom
                 relatedBy:NSLayoutRelationEqual
                 toItem:self
                 attribute:NSLayoutAttributeBottom
                 multiplier:1
                 constant:0.0f
                 ];
     */
    constraint = [NSLayoutConstraint
                  constraintWithItem:_title1
                  attribute:NSLayoutAttributeHeight
                  relatedBy:NSLayoutRelationEqual
                  toItem:nil
                  attribute:NSLayoutAttributeHeight
                  multiplier:1.0f
                  constant:20];
    
    [_title1 addConstraint:constraint];
    
    constraint = [NSLayoutConstraint
                  constraintWithItem:_title1
                  attribute:NSLayoutAttributeCenterY
                  relatedBy:NSLayoutRelationEqual
                  toItem:self
                  attribute:NSLayoutAttributeCenterY
                  multiplier:1.0f
                  constant:0];
    
    [self addConstraint:constraint];
    
    constraint =[
                 NSLayoutConstraint
                 constraintWithItem:_title1
                 attribute:NSLayoutAttributeWidth
                 relatedBy:NSLayoutRelationEqual
                 toItem:self
                 attribute:NSLayoutAttributeWidth
                 multiplier:2/3.0f
                 constant:-20.0f
                 ];
    [self addConstraint:constraint];
    constraint =[
                 NSLayoutConstraint
                 constraintWithItem:_title1
                 attribute:NSLayoutAttributeLeading
                 relatedBy:NSLayoutRelationEqual
                 toItem:self
                 attribute:NSLayoutAttributeLeading
                 multiplier:1
                 constant:10.0f
                 ];
    
    [self addConstraint:constraint];
    
    //////////
    /*
    constraint =[
                 NSLayoutConstraint
                 constraintWithItem:_title2
                 attribute:NSLayoutAttributeTop
                 relatedBy:NSLayoutRelationEqual
                 toItem:self
                 attribute:NSLayoutAttributeTop
                 multiplier:1
                 constant:0.0f
                 ];
    [self addConstraint:constraint];
    constraint =[
                 NSLayoutConstraint
                 constraintWithItem:_title2
                 attribute:NSLayoutAttributeBottom
                 relatedBy:NSLayoutRelationEqual
                 toItem:self
                 attribute:NSLayoutAttributeBottom
                 multiplier:1
                 constant:0.0f
                 ];
     */
    constraint = [NSLayoutConstraint
                  constraintWithItem:_title2
                  attribute:NSLayoutAttributeHeight
                  relatedBy:NSLayoutRelationEqual
                  toItem:nil
                  attribute:NSLayoutAttributeHeight
                  multiplier:1.0f
                  constant:20];
    
    [_title2 addConstraint:constraint];
    
    constraint = [NSLayoutConstraint
                  constraintWithItem:_title2
                  attribute:NSLayoutAttributeCenterY
                  relatedBy:NSLayoutRelationEqual
                  toItem:self
                  attribute:NSLayoutAttributeCenterY
                  multiplier:1.0f
                  constant:0];
    
    [self addConstraint:constraint];
    
    constraint =[
                 NSLayoutConstraint
                 constraintWithItem:_title2
                 attribute:NSLayoutAttributeLeading
                 relatedBy:NSLayoutRelationEqual
                 toItem:_title1
                 attribute:NSLayoutAttributeTrailing
                 multiplier:1
                 constant:-10.0f
                 ];
    [self addConstraint:constraint];
    constraint =[
                 NSLayoutConstraint
                 constraintWithItem:_title2
                 attribute:NSLayoutAttributeTrailing
                 relatedBy:NSLayoutRelationEqual
                 toItem:self
                 attribute:NSLayoutAttributeTrailing
                 multiplier:1
                 constant:-20.0f
                 ];
    
    [self addConstraint:constraint];
    _title1.alignment = NSTextAlignmentLeft;
    _title1.editable = NO;
    _title1.focusRingType = NSFocusRingTypeNone;
    _title1.stringValue=@"Title1";
    _title1.bordered = NO;
    _title1.selectable=NO;
    _title1.backgroundColor=[NSColor clearColor];
    _title1.wantsLayer = true;///设置背景颜色
    _title1.layer.backgroundColor = [NSColor clearColor].CGColor;
    

    _title2.alignment = NSTextAlignmentRight;
    _title2.editable = NO;
    _title2.focusRingType = NSFocusRingTypeNone;
    _title2.stringValue=@"Title2";
    _title2.bordered = NO;
    _title1.selectable=NO;
    _title2.backgroundColor=[NSColor clearColor];
    _title2.wantsLayer = true;///设置背景颜色
    _title2.layer.backgroundColor = [NSColor clearColor].CGColor;
    
}

-(void)setTitle:(NSString *)title
{
    [super setTitle:@""];
}
@end
