//
//  RTMeeleyStateMachine.h
//  StateMachine
//
//  Created by lzhu on 7/9/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTStateMachine.h"


/**
                Event->
 State1 --------------------> State2
                ->Action
 */


@interface RTMeeleyStateMachine : NSObject<RTStateMachine>

@property (strong, nonatomic) RTState *currentState;

@end
