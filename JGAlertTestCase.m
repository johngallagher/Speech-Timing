#import "JGAlertTestCase.h"
#import "JGAlert.h"

#import <UIKit/UIKit.h>
#import <OCMock/OCMock.h>


@implementation JGAlertTestCase

-(void)testGivenOneWordNameThenFilenameShouldGiveNameWithAIFFExtension {
    JGAlert *alert = [JGAlert alertWithStartTime:nil fireTime:nil name:@"Submarine"];
    NSString *alertFilename = [alert filename];
    STAssertTrue([alertFilename isEqualToString:@"Submarine.aiff"], @"String %@ should be equal to %@", alertFilename, @"Submarine.aiff");
}
-(void)testGivenTwoWordNameThenFilenameShouldGiveIntercapsNameWithAIFFExtension {
    JGAlert *alert = [JGAlert alertWithStartTime:nil fireTime:nil name:@"Submarine Sound"];
    NSString *alertFilename = [alert filename];
    STAssertTrue([alertFilename isEqualToString:@"SubmarineSound.aiff"], @"String %@ should be equal to %@", alertFilename, @"Submarine.aiff");
}

@end

