//
//  RTState.m
//  StateMachine
//
//  Created by lzhu on 7/9/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import "RTState.h"
#import "RTEvent.h"
#import "RTAction.h"

@interface RTState()

@property (strong, nonatomic) NSMutableDictionary *actions;

@end

@implementation RTState

- (instancetype) initWithIdentifier:(NSString*)identifier {
    self = [super init];
    if(self) {
        _identifier = identifier;
        _actions = [NSMutableDictionary dictionary];
    }
    return self;
}

- (RTAction*) actionForEvent:(RTEvent*)event {
    return _actions[event];
}

- (void) registerAction:(RTAction*)action forEvent:(RTEvent*)event {
    _actions[event] = action;
}

- (id<RTState>) nextStateForEvent:(RTEvent*)event {
    return self.proxy? [self.proxy nextStateForEvent:event] : nil;
}

- (void) registerNextState:(id<RTState>)state forEvent:(RTEvent*)event {
    if(self.proxy) [self.proxy registerNextState:state forEvent:event];
}

- (void) dealloc {
    printf("RTState %s dealloc\n", [self.identifier UTF8String]);
}

@end



@interface RTStateProxy()

@property (strong, nonatomic) NSMutableDictionary *nextStates;

@end


@implementation RTStateProxy

- (instancetype) initWithState:(RTState*)state {
    if(self = [super init]) {
        _state = state;
        _state.proxy = self;
        _nextStates = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSString*) identifier {
    return _state.identifier;
}

- (RTAction*) actionForEvent:(RTEvent*)event {
    return [_state actionForEvent:event];
}

- (void) registerAction:(RTAction*)action forEvent:(RTEvent*)event {
    [_state registerAction:action forEvent:event];
}

- (id<RTState>) nextStateForEvent:(RTEvent*)event {
    RTState *state = _nextStates[event];
    return state.proxy;
}

- (void) registerNextState:(id<RTState>)state forEvent:(RTEvent*)event {
    _nextStates[event] = state;
}

- (void) dealloc {
    printf("RTStateProxy %s dealloc\n", [self.identifier UTF8String]);
}

@end
