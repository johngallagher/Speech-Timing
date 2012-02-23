//
//  JGDrawingTestView.m
//  DrawLineTest1
//
//  Created by John Gallagher on 04/01/2012.
//  Copyright 2012 Synaptic Mishap. All rights reserved.
//

#import "JGTimerRunningView.h"
#import <QuartzCore/QuartzCore.h>
#import "JGPieChartLayer.h"
#import "JGPieChartAnimation.h"

@interface JGTimerRunningView ()

-(CABasicAnimation *)_animationForKeyPath:(NSString *)keyPath
                                fromValue:(NSNumber *)fromValue
                                  toValue:(NSNumber *)toValue;

-(void)_animateToAngle:(CGFloat)angle;


@end


@implementation JGTimerRunningView

@synthesize animationDuration;
//@synthesize pieChartAnimation = _pieChartAnimation;


//-(id)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    return self;
//}

-(void)setPieChartAnimation:(JGPieChartAnimation *)pieChartAnimation {
    animationDuration = [pieChartAnimation duration];

    JGPieChartLayer *layer = [[JGPieChartLayer alloc] initWithPieChartAnimation:pieChartAnimation];
    pieChartLayer = [layer retain];

    [layer release];

    [[self layer] addSublayer:pieChartLayer];
}

-(CABasicAnimation *)_animationForKeyPath:(NSString *)keyPath
                                fromValue:(NSNumber *)fromValue
                                  toValue:(NSNumber *)toValue {

    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:keyPath];
    anim.fromValue      = fromValue;
    anim.toValue        = toValue;
    anim.timingFunction = timingFunction;
    return anim;
}

-(void)_animateToAngle:(CGFloat)angle {
    NSNumber *eAngle = [pieChartLayer pieChartTimeLayerValueForKey:@"endAngle"];

    // Create animations
    CABasicAnimation *animEndAngle = [self _animationForKeyPath:@"endAngle" fromValue:eAngle toValue:[NSNumber numberWithFloat:angle]];

    // Start animations
    [pieChartLayer addAnimation:animEndAngle forKey:@"animateEndAngle"];
}

-(void)startCountdownAnimation {
    [CATransaction begin];
    [CATransaction setAnimationDuration:[self animationDuration]];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [self _animateToAngle:270];
    [CATransaction commit];
}

-(void)dealloc {
    [pieChartLayer release];
    [super dealloc];
}
@end

