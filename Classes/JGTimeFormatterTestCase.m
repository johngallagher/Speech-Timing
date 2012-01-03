#import "JGTimeFormatterTestCase.h"
#import "JGTimeFormatter.h"

@implementation JGTimeFormatterTestCase

-(void)testNonNumberClassShouldReturnEmptyString {
    NSString *formattedString = [[JGTimeFormatter defaultFormatterBehavior] stringForObjectValue:0];
    STAssertTrue    ([formattedString isEqualToString:@""], nil);
}

-(void)testZeroShouldShowZeroWithDividers {
    NSString *formattedString = [[JGTimeFormatter defaultFormatterBehavior] stringForObjectValue:[NSNumber numberWithInt:0]];
    STAssertTrue    ([formattedString isEqualToString:@"0:00"], nil);
}

-(void)testOneShouldShowOneWithDividers {
    NSString *formattedString = [[JGTimeFormatter defaultFormatterBehavior] stringForObjectValue:[NSNumber numberWithInt:1]];
    STAssertTrue    ([formattedString isEqualToString:@"0:01"], nil);
}

-(void)testTenShouldShowTenSecondsWithDividers {
    NSString *formattedString = [[JGTimeFormatter defaultFormatterBehavior] stringForObjectValue:[NSNumber numberWithInt:10]];
    STAssertTrue    ([formattedString isEqualToString:@"0:10"], nil);
}

-(void)testSixtyOneShouldShowOneMinuteOneSecond {
    NSString *formattedString = [[JGTimeFormatter defaultFormatterBehavior] stringForObjectValue:[NSNumber numberWithInt:61]];
    STAssertTrue    ([formattedString isEqualToString:@"1:01"], nil);
}

-(void)test120SecondsShouldShow2Minutes {
    NSString *formattedString = [[JGTimeFormatter defaultFormatterBehavior] stringForObjectValue:[NSNumber numberWithInt:120]];
    STAssertTrue    ([formattedString isEqualToString:@"2:00"], nil);
}

-(void)testNegative1ShouldShowNegativeOneWithDividers {
    NSString *formattedString = [[JGTimeFormatter defaultFormatterBehavior] stringForObjectValue:[NSNumber numberWithInt:-1]];
    STAssertTrue    ([formattedString isEqualToString:@"-0:01"], @"String is %@", formattedString);
}

-(void)testNegative60ShouldShowNegative1MinuteWithDividers {
    NSString *formattedString = [[JGTimeFormatter defaultFormatterBehavior] stringForObjectValue:[NSNumber numberWithInt:-60]];
    STAssertTrue    ([formattedString isEqualToString:@"-1:00"], @"String is %@", formattedString);
}

@end
