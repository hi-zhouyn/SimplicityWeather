//
//  GCDTimerManager.m
//  Xiaojs-XMI
//
//  Created by Liaoyuhan on 2016/11/29.
//  Copyright © 2016年 xiaojs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GCDTimerManager.h"

@interface GCDTimerManager ()

@property (nonatomic,strong) NSMutableDictionary * timerContainer;

@end

@implementation GCDTimerManager

+(instancetype)sharedInstance{
    
    static GCDTimerManager * _manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _manager = [[GCDTimerManager alloc]init];
        
    });
    return _manager;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _timerContainer = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void)scheduleDispachTimerWithName:(NSString *)timerName timerInterval:(double)interval queue:(dispatch_queue_t)queue repeats:(BOOL)repeats action:(dispatch_block_t)action{
    
    if (!timerName) {
        return;
    }
    if (!queue) {
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
    
    if (!timer) {
        
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_resume(timer);
        [self.timerContainer setObject:timer forKey:timerName];
        
    }
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC,0.1*NSEC_PER_SEC);
    
    WS(weakSelf);
    
    dispatch_source_set_event_handler(timer, ^{
        
        action();
        if (!repeats) {
            [weakSelf cancelTimerWithName:timerName];
        }
        
    });
    
}


-(void)scheduleDispachTimerWithName:(NSString *)timerName target:(id)target timerInterval:(double)interval queue:(dispatch_queue_t)queue repeats:(BOOL)repeats action:(SEL)action{
    
    if (!timerName) {
        return;
    }
    if (!queue) {
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
    
    if (!timer) {
        
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_resume(timer);
        [self.timerContainer setObject:timer forKey:timerName];
        
    }
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC,0.1*NSEC_PER_SEC);
    
    WS(weakSelf);
    
    dispatch_source_set_event_handler(timer, ^{
        
        if ([target respondsToSelector:action]) {
            
            ((void (*)(id, SEL))[target methodForSelector:action])(target, action);
        }
        
        if (!repeats) {
            
            [weakSelf cancelTimerWithName:timerName];
        }
        
    });
}

-(void)cancelTimerWithName:(NSString*)timerName{
    dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
    
    if (!timer) {
        return;
    }
    [self.timerContainer removeObjectForKey:timerName];
    dispatch_source_cancel(timer);
}

-(void)cancelAllTimer{
    
    [self.timerContainer enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        dispatch_source_cancel(obj);
        
    }];
    [self.timerContainer removeAllObjects];
}

@end
