//
//  PacmanLayer.m
//  Pacman
//
//  Created by Romain Vincens on 08/03/2011.
//  Copyright 2011 Nomad Planet. All rights reserved.
//

#import "JGPieChartLayer.h"
#import "JGPieChartAnimationParameters.h"


static inline double radians(double degrees) {
    return degrees * M_PI / 180;
}


@implementation JGPieChartLayer

@synthesize startAngle;
@synthesize endAngle;
@synthesize pieChartAnimation;


#pragma mark -
#pragma mark CALayer


-(id)initWithPieChartAnimation:(JGPieChartAnimationParameters *)aPieChartAnimation andFrame:(CGRect)frame_ {
    self = [super init];
    if (self) {
        pieChartAnimation = [aPieChartAnimation retain];
        self.needsDisplayOnBoundsChange = YES;
        self.frame                      = frame_;
        startAngle = [aPieChartAnimation startAngle];
        endAngle = [aPieChartAnimation endAngle];
//        [self setValue:[NSNumber numberWithFloat:[aPieChartAnimation startAngle]] forKey:@"startAngle"];
//        [self setValue:[NSNumber numberWithFloat:[aPieChartAnimation endAngle]] forKey:@"endAngle"];
    }

    return self;
}

//-(id)initWithLayer:(id)layer {
//    if ((self = [super initWithLayer:layer])) {
//        if ([layer isKindOfClass:[JGPieChartTimeLayer class]]) {
//            JGPieChartTimeLayer *pieChartTimeLayer = (JGPieChartTimeLayer *)layer;
//            self.startAngle = pieChartTimeLayer.startAngle;
//            self.endAngle   = pieChartTimeLayer.endAngle;
//        }
//    }
//    return self;
//}

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
    NSLog(@"Drew the pie chart layer");
}

#pragma mark -
#pragma mark Public API

-(id)lastValueForKey:(NSString *)key {
    JGPieChartLayer *last = (JGPieChartLayer *)self.presentationLayer;
    return [last valueForKey:key];
}

-(void)dealloc {
    [pieChartAnimation release];
    [super dealloc];
}

@end
