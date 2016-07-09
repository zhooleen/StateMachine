//
//  RTAction.m
//  StateMachine
//
//  Created by lzhu on 7/9/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import "RTAction.h"

@implementation RTAction

- (void) performAction {
    if(_block) {
        _block();
    } else if(_target && _action) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
        [_target performSelector:_action];
#pragma clang diagnostic pop
    } else if(_invocation) {
        [_invocation invoke];
    }
}

- (instancetype) initWithTarget:(id)target action:(SEL)action {
    self= [super init];
    if(self) {
        _target = target;
        _action = action;
    }
    return self;
}
- (instancetype) initWithInvocation:(NSInvocation*)invocation {
    self = [super init];
    if(self) {
        _invocation = invocation;
    }
    return self;
}
- (instancetype) initWithBlock:(dispatch_block_t)block {
    self = [super init];
    if(self) {
        _block = block;
    }
    return self;
}

@end
