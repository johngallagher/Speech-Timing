//
//  JGDrawingTestView.m
//  DrawLineTest1
//
//  Created by John Gallagher on 04/01/2012.
//  Copyright 2012 Synaptic Mishap. All rights reserved.
//

#import "JGDrawingTestView.h"
#import <QuartzCore/QuartzCore.h>
#import "PieChartLayer.h"

@interface JGDrawingTestView ()

-(CABasicAnimation *)_animationForKeyPath:(NSString*)keyPath 
                                fromValue:(NSNumber*)fromValue 
                                  toValue:(NSNumber*)toValue;

-(void)_animateToAngle:(CGFloat)angle;


@end


@implementation JGDrawingTestView

@synthesize animationDuration;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

-(void)awakeFromNib {
    PieChartLayer *pcl = [[PieChartLayer alloc] init];
	pcl.needsDisplayOnBoundsChange = YES;
	pcl.frame = self.bounds;
	pcl.startAngle = -90;
	pcl.endAngle = -90;
	pieChartLayer = [pcl retain];
	[pcl release];
	
    [pieChartLayer setValue:[NSNumber numberWithFloat:-90.0] forKey:@"startAngle"];
	[pieChartLayer setValue:[NSNumber numberWithFloat:-90.0] forKey:@"endAngle"];
	[self.layer addSublayer:pieChartLayer];
}

//-(void)drawRect:(CGRect)rect {
//    [super drawRect:rect];
//    [pieChartLayer setValue:[NSNumber numberWithFloat:-90.0] forKey:@"startAngle"];
//	[pieChartLayer setValue:[NSNumber numberWithFloat:-90.0] forKey:@"endAngle"];
//}

-(CABasicAnimation *)_animationForKeyPath:(NSString*)keyPath 
                                fromValue:(NSNumber*)fromValue 
                                  toValue:(NSNumber*)toValue {
	
	CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:keyPath];
	anim.fromValue = fromValue;
	anim.toValue = toValue;
	anim.timingFunction = timingFunction;
	return anim;
}

-(void)_animateToAngle:(CGFloat)angle {
	NSNumber *eAngle = [pieChartLayer lastValueForKey:@"endAngle"];
	
	// Create animations
	CABasicAnimation *animEndAngle = [self _animationForKeyPath:@"endAngle" fromValue:eAngle toValue:[NSNumber numberWithFloat:angle]];
    
	// Start animations
	[pieChartLayer addAnimation:animEndAngle forKey:@"animateEndAngle"];	
}

-(void)animateCountdownOverDuration:(NSUInteger)duration_ {
	[CATransaction begin];
	[CATransaction setAnimationDuration:duration_];
	[CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	[self _animateToAngle:270];
	
	[CATransaction commit];
}

@end

