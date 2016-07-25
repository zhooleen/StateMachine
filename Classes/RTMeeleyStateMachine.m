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

@property (strong, nonatomic) NSMutableDictionary *proxyMap;

@property (strong, nonatomic) NSArray *events;

@end

@implementation RTMeeleyStateMachine

- (instancetype) init {
    if(self = [super init]) {
        _proxyMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void) performEvent:(RTEvent *)event {
    if(![self.events containsObject:event]) {
        return;
    }
    id<RTState> state = [self.currentState nextStateForEvent:event];
    if(state == nil) {
        return;
    }
    RTAction *action = [self.currentState actionForEvent:event];
    if(action) {
        [action performAction];
    }
    self.currentState = state;
}

- (id<RTState>) proxyForState:(RTState*)state {
    if(state.proxy) {
        return state.proxy;
    }
    RTStateProxy *proxy = [[RTStateProxy alloc] initWithState:state];
    _proxyMap[state.identifier] = proxy;
    return proxy;
}

- (void) setProxyForState:(RTState*)state {
    if(state.proxy == nil) {
        RTStateProxy *proxy = [[RTStateProxy alloc] initWithState:state];
        _proxyMap[state.identifier] = proxy;
    }
}

- (void) linkState:(RTState*)state toState:(RTState*)toState forEvent:(RTEvent*)event {
    RTStateProxy *proxy = [self proxyForState:state];
    [proxy registerNextState:toState forEvent:event];
}

- (void) registerAction:(RTAction*)action toState:(RTState*)state forEvent:(RTEvent*)event {
    [state registerAction:action forEvent:event];
}

- (void) registerStates:(NSArray*)states andEvents:(NSArray*)events{
    for(RTState* state in states) {
        [self setProxyForState:state];
    }
    self.events = [events copy];
}

@end
