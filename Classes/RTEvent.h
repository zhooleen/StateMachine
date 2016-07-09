//
//  RTEvent.h
//  StateMachine
//
//  Created by lzhu on 7/9/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTEvent : NSObject <NSCopying>

@property (strong, nonatomic, readonly) NSString *identifier;

- (instancetype) initWithIdentifier:(NSString*)identifier;

@end
