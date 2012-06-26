//
//  CJException.m
//  CJFramework
//
//  Created by liu ys on 11-11-18.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import "CJException.h"
#import "CJLog.h"
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

CJ_DECLARE_SINGLETON(CJException)

void CJUncaughtExceptionHandler(NSException *exception) ;
void fatal_signal_handler(int sig, siginfo_t *info, void *context);
@implementation CJException

CJ_IMPLETEMENT_SINGLETON(CJException,defaultException)

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
            CJASSERT(0,"Signal registration for %s failed: %s", strsignal(fatal_signals[i]), strerror(err));
        }
    }

}
-(id)init {
    [super init] ;
    _delegate = nil ;
    _oldHandle  = NSGetUncaughtExceptionHandler();
    [self registrySignals];
    NSSetUncaughtExceptionHandler(CJUncaughtExceptionHandler);
    return self;
}

@end

void CJUncaughtExceptionHandler(NSException *exception) {
    BOOL isRaise = YES ;
    if ([[CJException defaultException] delegate] !=nil) {
        isRaise = [[[CJException defaultException] delegate] ExceptionHandle:exception] ;
    }
    CJLogStack();
    if (isRaise == TRUE) {
         NSSetUncaughtExceptionHandler(NULL);
        if ([CJException defaultException].oldHandle) {
            [CJException defaultException].oldHandle(exception);
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
    CJUncaughtExceptionHandler(e);
}
