//
//  RTAction.h
//  StateMachine
//
//  Created by lzhu on 7/9/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTAction : NSObject

@property (strong, nonatomic, readonly) NSString *identifier;

@property (weak,   nonatomic, readonly) id target;
@property (assign, nonatomic, readonly) SEL action;

@property (strong, nonatomic, readonly) NSInvocation *invocation;

@property (copy, nonatomic, readonly) dispatch_block_t block;

- (void) performAction;

- (instancetype) initWithTarget:(id)target action:(SEL)action;
- (instancetype) initWithInvocation:(NSInvocation*)invocation;
- (instancetype) initWithBlock:(dispatch_block_t)block;

@end
