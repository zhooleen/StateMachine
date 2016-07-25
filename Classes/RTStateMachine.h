//
//  RTStateMachine.h
//  StateMachine
//
//  Created by lzhu on 7/9/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RTAction.h"

typedef NSString RTEvent;
typedef NSString RTState;

@protocol RTStateMachine <NSObject>

@required
@property (strong, nonatomic) RTState *currentState;

- (void) registerStates:(NSArray<RTState*>*)states events:(NSArray<RTEvent*>*)evnets;

- (void) addNextState:(RTState*)nextState action:(RTAction*)action toState:(RTState*)previousState forEvent:(RTEvent*)event;

- (void) performEvent:(RTEvent*)event;

@end
