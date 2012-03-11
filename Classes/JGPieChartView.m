//
//  PacmanLayer.m
//  Pacman
//
//  Created by Romain Vincens on 08/03/2011.
//  Copyright 2011 Nomad Planet. All rights reserved.
//

#import "JGPieChartView.h"

static inline double radians(double degrees) {
    return degrees * M_PI / 180;
}

@implementation JGPieChartView

@synthesize startAngle;
@synthesize endAngle;

#pragma mark -
#pragma mark CALayer

-(id)initWithFrame:(CGRect)frame_ {
    self = [super init];
    if (self) {
        self.needsDisplayOnBoundsChange = YES;
        self.frame                      = frame_;
    }

    return self;
}

+(BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"startAngle"]
        || [key isEqualToString:@"endAngle"]) {
        return YES;
    }
    else {
        return [super needsDisplayForKey:key];
    }
}

-(void)drawInContext:(CGContextRef)ctx {
    /* Getting some values */
    CGFloat radius      = (CGFloat)(fmin(self.bounds.size.width, self.bounds.size.height) / 4);
    CGPoint centerPoint = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 3);
    CGFloat sAngle      = (CGFloat)radians(self.startAngle);
    CGFloat eAngle      = (CGFloat)radians(self.endAngle);

    /* Drawing arc */
    CGContextMoveToPoint(ctx, centerPoint.x, centerPoint.y);
    CGContextAddArc(ctx, centerPoint.x, centerPoint.y, radius, sAngle, eAngle, 1);
    CGContextClosePath(ctx);

    /* Filling it */
    CGContextSetFillColorWithColor(ctx, [[[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.3] autorelease] CGColor]);
    CGContextFillPath(ctx);
}

@end
