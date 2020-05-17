//
//  JuegodeVidaView.m
//  JuegodeVida
//
//  Created by Tejas Thiyagarajan on 5/16/20.
//  Copyright © 2020 Tejas Thiyagarajan. All rights reserved.
//

#import "JuegodeVidaView.h"

@implementation JuegodeVidaView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
