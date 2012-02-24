//
//  Created by John on 23/02/2012.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "JGPieChartAnimationParameters.h"


@implementation JGPieChartAnimationParameters

@synthesize fromAngle = _fromAngle;
@synthesize toAngle = _toAngle;
@synthesize duration = _duration;


+(id)animationFromAngle:(CGFloat)fromAngle_ toAngle:(CGFloat)toAngle_ duration:(NSTimeInterval)duration_ {
    return [[[[self class] alloc] initFromAngle:fromAngle_ toAngle:toAngle_ duration:duration_] autorelease];
}

-(id)initFromAngle:(CGFloat)fromAngle_ toAngle:(CGFloat)toAngle_ duration:(NSTimeInterval)duration_ {
    self = [super init];
    if (self) {
        _fromAngle = fromAngle_;
        _toAngle = toAngle_;
        _duration   = duration_;
    }

    return self;
}


@end