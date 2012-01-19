//
//  DamoObject.m
//  MissingSelectorDemo
//
//  Created by Damien Glancy on 19/01/2012.
//  Copyright (c) 2012 Damien Glancy. All rights reserved.
//

#import "CrashingGreetingsObject.h"

@implementation CrashingGreetingsObject

- (void)sayHello {
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Hello"
                                                        message:nil delegate:nil 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
