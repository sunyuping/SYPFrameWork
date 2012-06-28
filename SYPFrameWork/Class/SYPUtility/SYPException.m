//
//  SYPException.m
//  SYPFramework
//
//  Created by 玉平 孙 on 12-6-20.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#import "SYPException.h"
#import "SYPLog.h"
#include <execinfo.h>

static int fatal_signals[] = {
    SIGQUIT,
    SIGABRT,
    SIGBUS,
    SIGFPE,
    SIGILL,
    SIGSEGV,
    SIGTRAP,
    SIGEMT,
    SIGFPE,
    SIGSYS,
    SIGPIPE,
    SIGALRM,
    SIGXCPU,
    SIGXFSZ
};

static int n_fatal_signals = (sizeof(fatal_signals) / sizeof(fatal_signals[0]));

SYP_DECLARE_SINGLETON(SYPException)

void SYPUncaughtExceptionHandler(NSException *exception) ;
void fatal_signal_handler(int sig, siginfo_t *info, void *context);
@implementation SYPException

SYP_IMPLETEMENT_SINGLETON(SYPException,defaultException)

@synthesize delegate = _delegate; 
@synthesize oldHandle= _oldHandle;

-(void)registrySignals {
    struct sigaction sa;
    /* Configure action */
    memset(&sa, 0, sizeof(sa));
    sa.sa_flags =  SA_SIGINFO | SA_ONSTACK;
    sa.sa_sigaction = &fatal_signal_handler;
    sigemptyset(&sa.sa_mask);
    /* Set new sigaction */
    for (int i =0 ;i<n_fatal_signals; i++) {
        if (sigaction(fatal_signals[i], &sa, NULL) != 0) {
            int err = errno;
            NSAssert2(0,@"Signal registration for %s failed: %s", strsignal(fatal_signals[i]), strerror(err));
        }
    }

}
-(id)init {
    [super init] ;
    _delegate = nil ;
    _oldHandle  = NSGetUncaughtExceptionHandler();
    [self registrySignals];
    NSSetUncaughtExceptionHandler(SYPUncaughtExceptionHandler);
    return self;
}

@end

void SYPUncaughtExceptionHandler(NSException *exception) {
    BOOL isRaise = YES ;
    if ([[SYPException defaultException] delegate] !=nil) {
        isRaise = [[[SYPException defaultException] delegate] ExceptionHandle:exception] ;
    }
    SYPLogStack();
    if (isRaise == TRUE) {
         NSSetUncaughtExceptionHandler(NULL);
        if ([SYPException defaultException].oldHandle) {
            [SYPException defaultException].oldHandle(exception);
        }

    }
}
void fatal_signal_handler(int sig, siginfo_t *info, void *context) {
    struct sigaction sa;
    memset(&sa, 0, sizeof(sa));
    sa.sa_handler = SIG_DFL;
    sigemptyset(&sa.sa_mask);
    for (int i = 0; i < n_fatal_signals; i++) {
        sigaction(fatal_signals[i], &sa, NULL);
    }
    NSException *e = [NSException exceptionWithName:@"signal exception"
                            reason:[NSString stringWithFormat:@"signal %d", sig] userInfo:nil];
    SYPUncaughtExceptionHandler(e);
}
