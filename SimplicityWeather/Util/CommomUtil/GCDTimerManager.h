//
//  GCDTimerManager.h
//  Xiaojs-XMI
//
//  Created by Liaoyuhan on 2016/11/29.
//  Copyright © 2016年 xiaojs. All rights reserved.
//


@interface GCDTimerManager : NSObject

+(instancetype) sharedInstance;

/**
 *  @author Liaoyh
 *
 *  @brief 添加Timer
 *
 *  @param timerName    timer名称
 *  @param interval     周期：秒
 *  @param queue        GCD队列，nil会默认添加至GlobalQueue
 *  @param repeats      是否重复
 *  @param action       回调Block
 */
-(void)scheduleDispachTimerWithName:(NSString*)timerName
                      timerInterval:(double)interval
                              queue:(dispatch_queue_t)queue
                            repeats:(BOOL)repeats
                             action:(dispatch_block_t)action;


/**
 @author Liaoyh
 
 @brief 添加Timer

 @param timerName       timer名称
 @param target          target
 @param interval        周期：秒
 @param queue           GCD队列，nil会默认添加至GlobalQueue
 @param repeats         是否重复
 @param action          Selector
 */
-(void)scheduleDispachTimerWithName:(NSString*)timerName
                             target:(id)target
                      timerInterval:(double)interval
                              queue:(dispatch_queue_t)queue
                            repeats:(BOOL)repeats
                             action:(SEL)action;
/**
 *  @author Liaoyh
 *
 *  @brief 移除Timer
 *
 *  @param timerName timer名称
 */
-(void)cancelTimerWithName:(NSString*)timerName;

/**
 移除所有Timer
 */
-(void)cancelAllTimer;

@end
