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
    
    __weak typeof(self) wself = self;
    RTAction *action1 = [[RTAction alloc] initWithBlock:^{
        wself.colorView.backgroundColor = [UIColor cyanColor];
        wself.label.text = @"State1-->Event1-->State2";
    }];
    
    RTAction *action2 = [[RTAction alloc] initWithBlock:^{
        wself.colorView.backgroundColor = [UIColor grayColor];
        wself.label.text = @"State1-->Event2-->State3";
    }];
    
    RTAction *action3 = [[RTAction alloc] initWithBlock:^{
        wself.colorView.backgroundColor = [UIColor lightGrayColor];
        wself.label.text = @"State2-->Event1-->State4";
    }];
    
    RTAction *action4 = [[RTAction alloc] initWithBlock:^{
        wself.colorView.backgroundColor = [UIColor redColor];
        wself.label.text = @"State3-->Event1-->State4";
    }];
    
    RTAction *action5 = [[RTAction alloc] initWithBlock:^{
        wself.colorView.backgroundColor = [UIColor redColor];
        wself.label.text = @"State4-->Event1-->State1";
    }];
    
    [self.machine registerStates:@[s1, s2, s3, s4] andEvents:@[self.event1, self.event2]];
    
    [self.machine linkState:s1 toState:s2 forEvent:self.event1];
    [self.machine linkState:s1 toState:s3 forEvent:self.event2];
    [self.machine linkState:s2 toState:s4 forEvent:self.event1];
    [self.machine linkState:s3 toState:s4 forEvent:self.event1];
    [self.machine linkState:s4 toState:s1 forEvent:self.event1];
    
    [self.machine registerAction:action1 toState:s1 forEvent:self.event1];
    [self.machine registerAction:action2 toState:s1 forEvent:self.event2];
    [self.machine registerAction:action3 toState:s2 forEvent:self.event1];
    [self.machine registerAction:action4 toState:s3 forEvent:self.event1];
    [self.machine registerAction:action5 toState:s4 forEvent:self.event1];
    
    self.machine.currentState = s1;
}



@end
