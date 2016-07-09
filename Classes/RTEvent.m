//
//  RTEvent.m
//  StateMachine
//
//  Created by lzhu on 7/9/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import "RTEvent.h"

@implementation RTEvent

- (instancetype) initWithIdentifier:(NSString*)identifier {
    self = [super init];
    if(self) {
        _identifier = identifier;
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return self;
}

@end
