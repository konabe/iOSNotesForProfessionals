//
//  CustomObject.m
//  Chapter91_SwiftAndObjectiveCInteroperability
//
//  Created by 小鍋涼太 on 2021/10/10.
//

#import "CustomObject.h"
#import "Chapter91_SwiftAndObjectiveCInteroperability-Swift.h"

@implementation CustomObject
- (void) someMethod {
    MySwiftObject * myObj = [[MySwiftObject alloc] init];
    NSLog(@"%@", myObj.someProperty);
    NSString *retString = [myObj someFunctionWithSomeArg:(@"abe")];
    NSLog(@"%@", retString);
}
@end
