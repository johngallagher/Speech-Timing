//
//  JGGreenInsetGradientButton.m
//  DrawLineTest1
//
//  Created by John Gallagher on 06/01/2012.
//  Copyright 2012 Synaptic Mishap. All rights reserved.
//

#import "JGGreenInsetGradientButton.h"


@implementation JGGreenInsetGradientButton
-(void)fillWithNormalGradientColours {
    // Green
    [self setLowColor:RGBCOLOR(0, 129, 0)];
    [self setMiddleLowColor:RGBCOLOR(8, 138, 9)];
    [self setMiddleHighColor:RGBCOLOR(0, 148, 0)];
    [self setHighColor:RGBCOLOR(107, 175, 107)];
    
}

-(void)fillWithHighlightedGradientColours {
    // Green
    [self setLowColor:RGBCOLOR(0, 54, 0)];
    [self setMiddleLowColor:RGBCOLOR(5, 87, 5)];
    [self setMiddleHighColor:RGBCOLOR(0, 97, 0)];
    [self setHighColor:RGBCOLOR(76, 125, 76)];    
}

@end
