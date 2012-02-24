//
//  PacmanLayer.h
//  Pacman
//
//  Created by Romain Vincens on 08/03/2011.
//  Copyright 2011 Nomad Planet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@class JGPieChartAnimationParameters;


@interface JGPieChartLayer : CALayer {
    CGFloat startAngle;
    CGFloat endAngle;

    JGPieChartAnimationParameters *pieChartAnimation;
}

@property(nonatomic, assign) CGFloat startAngle;
@property(nonatomic, assign) CGFloat endAngle;
@property(nonatomic, retain) JGPieChartAnimationParameters *pieChartAnimation;


-(id)initWithPieChartAnimation:(JGPieChartAnimationParameters *)aPieChartAnimation andFrame:(CGRect)frame_;

-(id)lastValueForKey:(NSString *)key;

@end
