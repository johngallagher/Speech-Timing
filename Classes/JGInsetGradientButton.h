//
//  JGButton.h
//  DrawLineTest1
//
//  Created by John Gallagher on 05/01/2012.
//  Copyright 2012 Synaptic Mishap. All rights reserved.
//

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define HSVCOLOR(h,s,v) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:1]
#define HSVACOLOR(h,s,v,a) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:(a)]

#define RGBA(r,g,b,a) (r)/255.0f, (g)/255.0f, (b)/255.0f, (a)

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface JGInsetGradientButton : UIButton {
    CAGradientLayer *gradientLayer;
    UIColor         *_highColor;
    UIColor         *_middleHighColor;
    UIColor         *_middleLowColor;
    UIColor         *_lowColor;
}

@property(nonatomic, retain) UIColor         *_lowColor;
@property(nonatomic, retain) UIColor         *_middleLowColor;
@property(nonatomic, retain) UIColor         *_middleHighColor;
@property(nonatomic, retain) UIColor         *_highColor;
@property(nonatomic, retain) CAGradientLayer *gradientLayer;


-(void)setHighColor:(UIColor *)color;

-(void)setMiddleHighColor:(UIColor *)color;

-(void)setMiddleLowColor:(UIColor *)color;

-(void)setLowColor:(UIColor *)color;

@end



