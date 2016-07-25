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
    }
}

- (instancetype) initWithIdentifier:(NSString*)identifer block:(dispatch_block_t)block {
    self= [super init];
    if(self) {
        _identifier = identifer;
        _block = block;
    }
    return self;
}

@end
