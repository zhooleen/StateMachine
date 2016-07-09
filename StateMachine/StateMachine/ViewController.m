//
//  ViewController.m
//  StateMachine
//
//  Created by lzhu on 7/4/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import "ViewController.h"

#import "RTMeeleyStateMachine.h"

@interface ViewController ()

@property (strong, nonatomic) RTMeeleyStateMachine *machine;

@property (strong, nonatomic) RTEvent *event1;

@property (strong, nonatomic) RTEvent *event2;

@property (strong, nonatomic) RTEvent *event3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildup];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)triggerEvent1:(id)sender {
    [self.machine performEvent:self.event1];
}

- (IBAction)triggerEvent2:(id)sender {
    [self.machine performEvent:self.event2];
}

- (IBAction)triggerEvent3:(id)sender {
//    [self.machine performEvent:self.event3];
    self.machine = nil;
}

- (void) buildup {
    self.machine = [[RTMeeleyStateMachine alloc] init];
    
    RTState *s1 = [[RTState alloc] initWithIdentifier:@"State1"];
    RTState *s2 = [[RTState alloc] initWithIdentifier:@"State2"];
    RTState *s3 = [[RTState alloc] initWithIdentifier:@"State3"];
    RTState *s4 = [[RTState alloc] initWithIdentifier:@"State4"];
    
    self.event1 = [[RTEvent alloc] initWithIdentifier:@"Event1"];
    self.event2 = [[RTEvent alloc] initWithIdentifier:@"Event2"];
    
    [self.machine linkState:s1 toState:s2 forEvent:self.event1];
    [self.machine linkState:s1 toState:s3 forEvent:self.event2];
    [self.machine linkState:s2 toState:s4 forEvent:self.event1];
    [self.machine linkState:s3 toState:s4 forEvent:self.event1];
    [self.machine linkState:s4 toState:s1 forEvent:self.event1];
    
    self.machine.currentState = s1;
    
    __weak typeof(self) wself = self;
    [s1 registerAction:[[RTAction alloc] initWithBlock:^{
        wself.colorView.backgroundColor = [UIColor cyanColor];
        wself.label.text = @"State1-->Event1-->State2";
    }] forEvent:self.event1];
    
    [s1 registerAction:[[RTAction alloc] initWithBlock:^{
        wself.colorView.backgroundColor = [UIColor grayColor];
        wself.label.text = @"State1-->Event2-->State3";
    }] forEvent:self.event2];
    
    [s2 registerAction:[[RTAction alloc] initWithBlock:^{
        wself.colorView.backgroundColor = [UIColor lightGrayColor];
        wself.label.text = @"State2-->Event1-->State4";
    }] forEvent:self.event1];
    
    [s3 registerAction:[[RTAction alloc] initWithBlock:^{
        wself.colorView.backgroundColor = [UIColor redColor];
        wself.label.text = @"State3-->Event1-->State4";
    }] forEvent:self.event1];
    
    [s4 registerAction:[[RTAction alloc] initWithBlock:^{
        wself.colorView.backgroundColor = [UIColor redColor];
        wself.label.text = @"State4-->Event1-->State1";
    }] forEvent:self.event1];
    
}



@end
