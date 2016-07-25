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
    [self.machine performEvent:self.event3]; //error, event3 not registered.
}

- (void) buildup {
    self.machine = [[RTMeeleyStateMachine alloc] init];
    
    RTState *s1 = @"State1";
    RTState *s2 = @"State2";
    RTState *s3 = @"State3";
    RTState *s4 = @"State4";
    
    self.event1 = @"Event1";
    self.event2 = @"Event2";
    self.event3 = @"Event3";
    
    __weak typeof(self) wself = self;
    RTAction *action1 = [[RTAction alloc] initWithIdentifier:@"action1" block:^{
        wself.colorView.backgroundColor = [UIColor cyanColor];
        wself.label.text = @"State1-->Event1-->State2";
    }];
    
    RTAction *action2 = [[RTAction alloc] initWithIdentifier:@"action2" block:^{
        wself.colorView.backgroundColor = [UIColor grayColor];
        wself.label.text = @"State1-->Event2-->State3";
    }];
    
    RTAction *action3 = [[RTAction alloc] initWithIdentifier:@"action3" block:^{
        wself.colorView.backgroundColor = [UIColor lightGrayColor];
        wself.label.text = @"State2-->Event1-->State4";
    }];
    
    RTAction *action4 = [[RTAction alloc] initWithIdentifier:@"action4" block:^{
        wself.colorView.backgroundColor = [UIColor blueColor];
        wself.label.text = @"State3-->Event1-->State4";
    }];
    
    RTAction *action5 = [[RTAction alloc] initWithIdentifier:@"action5" block:^{
        wself.colorView.backgroundColor = [UIColor redColor];
        wself.label.text = @"State4-->Event1-->State1";
    }];
    
    [self.machine registerStates:@[s1, s2, s3, s4] events:@[self.event1, self.event2]];
    
    [self.machine addNextState:s2 action:action1 toState:s1 forEvent:self.event1];
    [self.machine addNextState:s3 action:action2 toState:s1 forEvent:self.event2];
    [self.machine addNextState:s4 action:action3 toState:s2 forEvent:self.event1];
    [self.machine addNextState:s4 action:action4 toState:s3 forEvent:self.event1];
    [self.machine addNextState:s1 action:action5 toState:s4 forEvent:self.event1];
    
    self.machine.currentState = s1;
}



@end
