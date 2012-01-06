//
//  JGButton.m
//  DrawLineTest1
//
//  Created by John Gallagher on 05/01/2012.
//  Copyright 2012 Synaptic Mishap. All rights reserved.
//

#import "JGInsetGradientButton.h"


@interface JGInsetGradientButton ()

-(void)fillWithNormalGradientColours;
-(void)fillWithHighlightedGradientColours;

@end


@implementation JGInsetGradientButton

@synthesize _lowColor;
@synthesize _middleLowColor;
@synthesize _middleHighColor;
@synthesize _highColor;
@synthesize gradientLayer;

-(void)fillWithNormalGradientColours {
    [NSException exceptionWithName:NSInternalInconsistencyException reason:@"You must subclass JGInsetGradientButton for use." userInfo:nil];
}

-(void)fillWithHighlightedGradientColours {
    [NSException exceptionWithName:NSInternalInconsistencyException reason:@"You must subclass JGInsetGradientButton for use." userInfo:nil];
}

-(void)awakeFromNib {
    [[self layer] setCornerRadius:8.0f];
    [[self layer] setMasksToBounds:YES];
    [[self layer] setBorderWidth:1.5f];     // With 1.5 cf 1.0 it removes some jaggies on rounded corners
    [[self layer] setBorderColor:[[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1] CGColor]];
    
    gradientLayer = [[CAGradientLayer alloc] init];
    [gradientLayer setBounds:
     CGRectMake([self bounds].origin.x + 3, 
                [self bounds].origin.y + 3, 
                [self bounds].size.width - 6, 
                [self bounds].size.height - 6)];
    [gradientLayer setPosition:
     CGPointMake([self bounds].size.width/2,
                 [self bounds].size.height/2)];

    [gradientLayer setCornerRadius:5.0f];
    [gradientLayer setMasksToBounds:YES];
    
    [[self layer] insertSublayer:gradientLayer atIndex:0];
    
    [self fillWithNormalGradientColours];
}

-(void)drawRect:(CGRect)rect {
    if (_highColor && _lowColor) {
        // Set the colors for the gradient to the 
        // two colors specified for high and low
        [gradientLayer setColors:
         [NSArray arrayWithObjects:
          (id)[_highColor CGColor],
          (id)[_middleHighColor CGColor],
          (id)[_middleLowColor CGColor],
          (id)[_lowColor CGColor], nil]];
        [gradientLayer setLocations:
         [NSArray arrayWithObjects:
          [NSNumber numberWithFloat:0.0],
          [NSNumber numberWithFloat:0.5],
          [NSNumber numberWithFloat:0.51],
          [NSNumber numberWithFloat:1.0], nil]];
    }
    [super drawRect:rect];
}

-(void)setHighColor:(UIColor*)color {
    [self set_highColor:color];
    [[self layer] setNeedsDisplay];
}

-(void)setMiddleHighColor:(UIColor*)color {
    [self set_middleHighColor:color];
    [[self layer] setNeedsDisplay];
}

-(void)setMiddleLowColor:(UIColor*)color {
    [self set_middleLowColor:color];
    [[self layer] setNeedsDisplay];
}

-(void)setLowColor:(UIColor*)color {
    [self set_lowColor:color];
    [[self layer] setNeedsDisplay];
}

-(void)dealloc {
    [gradientLayer release];
    [super dealloc];
}

// To highlight button on press
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self fillWithHighlightedGradientColours];
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self fillWithNormalGradientColours];
    [super touchesEnded:touches withEvent:event];
}

@end



