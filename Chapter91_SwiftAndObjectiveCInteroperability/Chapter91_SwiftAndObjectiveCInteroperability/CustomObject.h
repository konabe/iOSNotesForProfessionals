//
//  CustomObject.h
//  Chapter91_SwiftAndObjectiveCInteroperability
//
//  Created by 小鍋涼太 on 2021/10/10.
//

#import <Foundation/Foundation.h>

@interface CustomObject : NSObject
@property (strong, nonatomic) id someProperty;
- (void) someMethod;
@end
