//
//  RTMeeleyStateMachine.m
//  StateMachine
//
//  Created by lzhu on 7/9/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import "RTMeeleyStateMachine.h"
#import "RTAction.h"

@interface RTMeeleyStateMachine()

@property (strong, nonatomic) NSMutableDictionary *map;

@property (strong, nonatomic) NSArray *events;
@property (strong, nonatomic) NSArray *states;

@end

static NSString * const kAction = @"action";
static NSString * const kState = @"state";

@implementation RTMeeleyStateMachine

- (instancetype) init {
    if(self = [super init]) {
        self.map = [NSMutableDictionary dictionaryWithCapacity:8];
    }
    return self;
}

- (void) registerStates:(NSArray<RTState*>*)states events:(NSArray<RTEvent*>*)events {
    self.states = [states copy];
    self.events = [events copy];
}

- (void) addNextState:(RTState*)nextState action:(RTAction*)action toState:(RTState*)previousState forEvent:(RTEvent*)event {
    NSAssert([self.states containsObject:previousState], nil);
    NSAssert([self.states containsObject:nextState], nil);
    NSAssert([self.events containsObject:event], nil);
    NSMutableDictionary *dict1 = [self.map objectForKey:previousState];
    if(dict1 == nil) {
        dict1 = [NSMutableDictionary dictionaryWithCapacity:8];
        [self.map setObject:dict1 forKey:previousState];
    }
    NSMutableDictionary *dict2 = [dict1 objectForKey:event];
    if(dict2 == nil) {
        dict2 = [NSMutableDictionary dictionaryWithCapacity:8];
        [dict1 setObject:dict2 forKey:event];
    }
    [dict2 setObject:nextState forKey:kState];
    [dict2 setObject:action forKey:kAction];
}

- (void) performEvent:(RTEvent*)event {
    NSAssert([self.events containsObject:event], nil);
    NSMutableDictionary *dict = self.map[self.currentState][event];
    RTState *nextState = dict[kState];
    RTAction *action = dict[kAction];
    if(nextState == nil || action == nil) {
        return;
    }
    printf("switch from %s to %s, triggered by %s, execute %s\n",
           self.currentState.UTF8String,
           nextState.UTF8String,
           event.UTF8String,
           action.identifier.UTF8String);
    [action performAction];
    self.currentState = nextState;
}


@end
