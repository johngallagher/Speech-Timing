//
//  Created by John on 23/02/2012.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "JGPieChartAnimationParameters.h"


@implementation JGPieChartAnimationParameters

@synthesize startAngle = _startAngle;
@synthesize endAngle = _endAngle;
@synthesize duration = _duration;


+(id)animationWithStartAngle:(CGFloat)startAngle_ endAngle:(CGFloat)endAngle_ duration:(NSTimeInterval)duration_ {
    return [[[[self class] alloc] initWithStartAngle:startAngle_ endAngle:endAngle_ duration:duration_] autorelease];
}

-(id)initWithStartAngle:(CGFloat)startAngle_ endAngle:(CGFloat)endAngle_ duration:(NSTimeInterval)duration_ {
    self = [super init];
    if (self) {
        _startAngle = startAngle_;
        _endAngle   = endAngle_;
        _duration   = duration_;
    }

    return self;
}


@end