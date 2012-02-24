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
#import "JGPieChartAnimationParameters.h"

@interface JGTimerRunningView ()

-(CABasicAnimation *)_animationForKeyPath:(NSString *)keyPath fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue duration:(NSTimeInterval)duration_;

@end


@implementation JGTimerRunningView

-(CABasicAnimation *)startAngleAnimationFromParameters:(JGPieChartAnimationParameters *)parameters_ {
    // The start angle is always the same - the pie chart always starts at the 12 o'clock position or -90
    CABasicAnimation *startAngleAnimation = [self _animationForKeyPath:@"startAngle" fromValue:-90 toValue:-90 duration:[parameters_ duration]];
    return startAngleAnimation;
}

-(CABasicAnimation *)endAngleAnimationFromParameters:(JGPieChartAnimationParameters *)parameters_ {
    CABasicAnimation *endAngleAnimation = [self _animationForKeyPath:@"endAngle" fromValue:[parameters_ fromAngle] toValue:[parameters_ toAngle] duration:[parameters_ duration]];
    return endAngleAnimation;
}

-(void)startCountdownAnimationWithParameters:(JGPieChartAnimationParameters *)parameters_ {
    if (!parameters_)
        return;

    JGPieChartLayer *layer = [[JGPieChartLayer alloc] initWithFrame:[self bounds]];
    pieChartLayer = [layer retain];
    [[self layer] addSublayer:pieChartLayer];
    [layer release];

    CABasicAnimation *endAngleAnimation = [self endAngleAnimationFromParameters:parameters_];
    CABasicAnimation *startAngleAnimation = [self startAngleAnimationFromParameters:parameters_];

    [pieChartLayer addAnimation:startAngleAnimation forKey:@"animateStartAngle"];
    [pieChartLayer addAnimation:endAngleAnimation forKey:@"animateEndAngle"];
}

-(CABasicAnimation *)_animationForKeyPath:(NSString *)keyPath fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue duration:(NSTimeInterval)duration_ {

    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:keyPath];
    anim.fromValue      = [NSNumber numberWithFloat:fromValue];
    anim.toValue        = [NSNumber numberWithFloat:toValue];
    anim.timingFunction = timingFunction;
    [anim setDuration:duration_];
    return anim;
}

-(void)dealloc {
    [pieChartLayer release];
    [super dealloc];
}
@end

