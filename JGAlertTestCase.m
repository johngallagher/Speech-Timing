#import "JGAlertTestCase.h"
#import "JGAlert.h"

#import <UIKit/UIKit.h>
#import <OCMock/OCMock.h>


@implementation JGAlertTestCase

#pragma mark Filename
-(void)testGivenOneWordNameThenFilenameShouldGiveNameWithAIFFExtension {
    JGAlert *alert = [JGAlert alertWithStartTime:nil fireTime:nil name:@"Submarine"];
    NSString *alertFilename = [alert filenameWithoutExtension];
    STAssertTrue([alertFilename isEqualToString:@"Submarine"], @"String %@ should be equal to %@", alertFilename, @"Submarine");
}

-(void)testGivenTwoWordNameThenFilenameShouldGiveIntercapsNameWithAIFFExtension {
    JGAlert *alert = [JGAlert alertWithStartTime:nil fireTime:nil name:@"Submarine Sound"];
    NSString *alertFilename = [alert filenameWithoutExtension];
    STAssertTrue([alertFilename isEqualToString:@"SubmarineSound"], @"String %@ should be equal to %@", alertFilename, @"SubmarineSound");
}

#pragma mark Default Name
-(void)testGivenNilNameAtInitNameShouldBeDigitalAlarm1 {
    JGAlert *alert = [[JGAlert alloc] init];
    STAssertTrue([[alert name] isEqualToString:@"Digital Alarm 1"], @"String %@ should be equal to %@", [alert name], @"Digital Alarm 1");
    [alert release];
}

-(void)testGivenNilNameInConstructorNameShouldBeSetToDigitalAlarm1BecauseThisIsTheDefault {
    JGAlert *alert = [JGAlert alertWithName:nil];
    STAssertTrue([[alert name] isEqualToString:@"Digital Alarm 1"], @"String %@ should be equal to %@", [alert name], @"Digital Alarm 1");
}

-(void)testGivenNameInConstructorNameShouldBeSetToName {
    JGAlert *alert = [JGAlert alertWithName:@"Submarine"];
    STAssertTrue([[alert name] isEqualToString:@"Submarine"], @"String %@ should be equal to %@", [alert name], @"Submarine");
}

@end

