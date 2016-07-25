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

@property (copy, nonatomic, readonly) dispatch_block_t block;

- (void) performAction;

- (instancetype) initWithIdentifier:(NSString*)identifer block:(dispatch_block_t)block;

@end
