//
//  RTStateMachine.h
//  StateMachine
//
//  Created by lzhu on 7/9/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RTEvent.h"
#import "RTState.h"
#import "RTAction.h"

@protocol RTStateMachine <NSObject>

@required
@property (strong, nonatomic) id<RTState> currentState;

//当一个事件到来的时候，处理状态转换和执行相关操作
- (void) performEvent:(RTEvent*)event;

/**
 *                Event
 *  state --------------------> switch to toState
 */
- (void) linkState:(RTState*)state toState:(RTState*)toState forEvent:(RTEvent*)event;

/**
 *                Event
 *  state --------------------> perform action
 */
- (void) registerAction:(RTAction*)action toState:(RTState*)toState forEvent:(RTEvent*)event;

/**
 * register states & events before other operations to make sure validation.
 */
- (void) registerStates:(NSArray*)states andEvents:(NSArray*)events;

@end
