//
//  JGRedInsetGradientButton.m
//  DrawLineTest1
//
//  Created by John Gallagher on 06/01/2012.
//  Copyright 2012 Synaptic Mishap. All rights reserved.
//

#import "JGRedInsetGradientButton.h"

@implementation JGRedInsetGradientButton

-(void)fillWithNormalGradientColours {
    // Red
    [self setLowColor:RGBCOLOR(166, 17, 8)];
    [self setMiddleLowColor:RGBCOLOR(157, 7, 19)];
    [self setMiddleHighColor:RGBCOLOR(161, 23, 37)];
    [self setHighColor:RGBCOLOR(181, 107, 117)];
}

-(void)fillWithHighlightedGradientColours {
    // Red
    [self setLowColor:RGBCOLOR(115, 11, 6)];
    [self setMiddleLowColor:RGBCOLOR(107, 4, 13)];
    [self setMiddleHighColor:RGBCOLOR(110, 15, 25)];
    [self setHighColor:RGBCOLOR(130, 77, 84)];
}

@end
