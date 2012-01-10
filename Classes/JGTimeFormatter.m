#import "JGTimeFormatter.h"


@implementation JGTimeFormatter

+(JGTimeFormatter *)defaultFormatterBehavior {
    return [[[JGTimeFormatter alloc] init] autorelease];
}

-(void)convertSecondsIntoTimeUnits:(NSNumber *)durationObjectInSeconds
                         minutes_p:(NSInteger *)minutes_p
                         seconds_p:(NSInteger *)seconds_p {

    // find minutes
    *minutes_p = [durationObjectInSeconds intValue] / 60;

    // find seconds
    *seconds_p = [durationObjectInSeconds intValue] - (*minutes_p * 60);
}

-(NSString *)stringForObjectValue:(id)anObject {
    if (![anObject isKindOfClass:[NSNumber class]])
        return @"";

    BOOL numberIsNegative = ([anObject intValue] < 0);
    NSString *sign = @"";
    if (numberIsNegative) {
        anObject = [NSNumber numberWithInt:([anObject intValue] * -1)];
        sign     = @"-";
    }

    NSInteger minutes = 0;
    NSInteger seconds = 0;
    [self convertSecondsIntoTimeUnits:anObject minutes_p:&minutes seconds_p:&seconds];

    NSString *secondsString = @"00";;
    if (seconds > 0 && seconds < 10) {
        secondsString = [NSString stringWithFormat:@"0%d", seconds];
    } else
        if (seconds >= 10) {
            secondsString = [NSString stringWithFormat:@"%d", seconds];
        }

    return [NSString stringWithFormat:@"%@%d:%@", sign, minutes, secondsString];
}

-(BOOL)getObjectValue:(id *)anObject forString:(NSString *)string errorDescription:(NSString **)error {
    return YES;
}

@end
