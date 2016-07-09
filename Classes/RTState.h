//
//  RTState.h
//  StateMachine
//
//  Created by lzhu on 7/9/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RTEvent;
@class RTAction;


@protocol RTState <NSObject>

@property (strong, nonatomic, readonly) NSString *identifier;

- (RTAction*) actionForEvent:(RTEvent*)event;

- (void) registerAction:(RTAction*)action forEvent:(RTEvent*)event;

- (id<RTState>) nextStateForEvent:(RTEvent*)event;

- (void) registerNextState:(id<RTState>)state forEvent:(RTEvent*)event;

@end


@interface RTState : NSObject <RTState>

@property (weak, nonatomic) id<RTState> proxy;

@property (strong, nonatomic, readonly) NSString *identifier;

- (instancetype) initWithIdentifier:(NSString*)identifier;

@end

@interface RTStateProxy : NSObject <RTState>

@property (strong, nonatomic, readonly) RTState *state;

@property (strong, nonatomic, readonly) NSString *identifier;

- (instancetype) initWithState:(RTState*)state;

@end
