//
//  PacmanLayer.m
//  Pacman
//
//  Created by Romain Vincens on 08/03/2011.
//  Copyright 2011 Nomad Planet. All rights reserved.
//

#import "JGPieChartTimeLayer.h"


static inline double radians(double degrees) {
    return degrees * M_PI / 180;
}


@implementation JGPieChartTimeLayer

@synthesize startAngle;
@synthesize endAngle;

#pragma mark -
#pragma mark CALayer

-(id)initWithLayer:(id)layer {
    if ((self = [super initWithLayer:layer])) {
        if ([layer isKindOfClass:[JGPieChartTimeLayer class]]) {
            JGPieChartTimeLayer *other = (JGPieChartTimeLayer *)layer;
            self.startAngle = other.startAngle;
            self.endAngle   = other.endAngle;
        }
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

#pragma mark -
#pragma mark Public API

-(id)lastValueForKey:(NSString *)key {
    JGPieChartTimeLayer *last = (JGPieChartTimeLayer *)self.presentationLayer;
    return [last valueForKey:key];
}

@end
