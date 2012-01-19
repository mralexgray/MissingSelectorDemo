//
//  ViewController.m
//  MissingSelectorDemo
//
//  Created by Damien Glancy on 19/01/2012.
//  Copyright (c) 2012 Damien Glancy. All rights reserved.
//

#import "ViewController.h"
#import "CrashingGreetingsObject.h"
#import "NonCrashingGreetingsObject.h"

@implementation ViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)sayHelloBtnPressed:(id)sender {
    CrashingGreetingsObject *crashingGreetings = [[CrashingGreetingsObject alloc] init];
    [crashingGreetings performSelector:@selector(sayHello)];
}

- (IBAction)sayGoodbyeBtnPressed:(id)sender {
    // this will crash as CrashingGreetingsObject does not implement a method called |sayGoodbye|
    CrashingGreetingsObject *crashingGreetings = [[CrashingGreetingsObject alloc] init];
    [crashingGreetings performSelector:@selector(sayGoodbye)];
}

- (IBAction)sayHello2BtnPressed:(id)sender {
    NonCrashingGreetingsObject *nonCrashingGreetings = [[NonCrashingGreetingsObject alloc] init];
    [nonCrashingGreetings performSelector:@selector(sayHello)];
}

- (IBAction)sayGoodbye2BtnPressed:(id)sender {
    // this won't crash even though NonCrashingGreetingsObject down not implement a method called |sayGoodbye|
    NonCrashingGreetingsObject *nonCrashingGreetings = [[NonCrashingGreetingsObject alloc] init];
    [nonCrashingGreetings performSelector:@selector(sayGoodbye)];
}

@end