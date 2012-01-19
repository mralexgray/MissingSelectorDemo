//
//  NonCrashingGreetingsObject.m
//  MissingSelectorDemo
//
//  Created by Damien Glancy on 19/01/2012.
//  Copyright (c) 2012 Damien Glancy. All rights reserved.
//

#import "NonCrashingGreetingsObject.h"

@implementation NonCrashingGreetingsObject

- (void)sayHello {
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Hello 2"
                                                        message:nil delegate:nil 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - Missing selector crash protection

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    SEL doNothingSEL = @selector(doNothing);
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:doNothingSEL];
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)inv {
}

- (void)doNothing {
}

@end