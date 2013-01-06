//
//  MKNetworkEngine.m
//  MKNetworkKit
//
//  Created by Mugunth Kumar (@mugunthkumar) on 11/11/11.
//  Copyright (C) 2011-2020 by Steinlogic

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "MKNetworkKit.h"
#define kFreezableOperationExtension @"mknetworkkitfrozenoperation"

#ifdef __OBJC_GC__
#error MKNetworkKit does not support Objective-C Garbage Collection
#endif

#if ! __has_feature(objc_arc)
#error MKNetworkKit is ARC only. Either turn on ARC for the project or use -fobjc-arc flag
#endif

@interface MKNetworkEngine (/*Private Methods*/)

@property (strong, nonatomic) NSString *hostName;
@property (strong, nonatomic) Reachability *reachability;
@property (strong, nonatomic) NSDictionary *customHeaders;
@property (assign, nonatomic) Class customOperationSubclass;

@end

static NSOperationQueue *_sharedNetworkQueue;

@implementation MKNetworkEngine
@synthesize hostName = _hostName;
@synthesize reachability = _reachability;
@synthesize customHeaders = _customHeaders;
@synthesize customOperationSubclass = _customOperationSubclass;

@synthesize reachabilityChangedHandler = _reachabilityChangedHandler;
@synthesize portNumber = _portNumber;
@synthesize apiPath = _apiPath;

// Network Queue is a shared singleton object.
// no matter how many instances of MKNetworkEngine is created, there is one and only one network queue
// In theory an app should contain as many network engines as the number of domains it talks to

#pragma mark -
#pragma mark Initialization

+(void) initialize {
    
    if(!_sharedNetworkQueue) {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            _sharedNetworkQueue = [[NSOperationQueue alloc] init];
            [_sharedNetworkQueue addObserver:[self self] forKeyPath:@"operationCount" options:0 context:NULL];
            [_sharedNetworkQueue setMaxConcurrentOperationCount:6];
            
        });
    }            
}

- (id) initWithHostName:(NSString*) hostName {
    
    return [self initWithHostName:hostName apiPath:nil customHeaderFields:nil];
}

- (id) initWithHostName:(NSString*) hostName apiPath:(NSString*) apiPath customHeaderFields:(NSDictionary*) headers {
    
    if((self = [super init])) {        
        
        self.apiPath = apiPath;
        
        if(hostName) {
            [[NSNotificationCenter defaultCenter] addObserver:self 
                                                     selector:@selector(reachabilityChanged:) 
                                                         name:kReachabilityChangedNotification 
                                                       object:nil];
            
            self.hostName = hostName;  
            self.reachability = [Reachability reachabilityWithHostname:self.hostName];
            [self.reachability startNotifier];            
        }
        
        if([headers objectForKey:@"User-Agent"] == nil) {
            
            NSMutableDictionary *newHeadersDict = [headers mutableCopy];
            NSString *userAgentString = [NSString stringWithFormat:@"%@/%@", 
                                         [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey], 
                                         [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]];
            [newHeadersDict setObject:userAgentString forKey:@"User-Agent"];
            self.customHeaders = newHeadersDict;
        } else {
            self.customHeaders = headers;
        }    
        
        self.customOperationSubclass = [MKNetworkOperation class];
    }
    
    return self;  
}

- (id) initWithHostName:(NSString*) hostName customHeaderFields:(NSDictionary*) headers {
    
    return [self initWithHostName:hostName apiPath:nil customHeaderFields:headers];
}

#pragma mark -
#pragma mark Memory Mangement

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+(void) dealloc {
    
    [_sharedNetworkQueue removeObserver:[self self] forKeyPath:@"operationCount"];
}

#pragma mark -
#pragma mark KVO for network Queue

+ (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object 
                         change:(NSDictionary *)change context:(void *)context
{
    if (object == _sharedNetworkQueue && [keyPath isEqualToString:@"operationCount"]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kMKNetworkEngineOperationCountChanged 
                                                            object:[NSNumber numberWithInteger:[_sharedNetworkQueue operationCount]]];
#if TARGET_OS_IPHONE
        [UIApplication sharedApplication].networkActivityIndicatorVisible = 
        ([_sharedNetworkQueue.operations count] > 0);        
#endif
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object 
                               change:change context:context];
    }
}

#pragma mark -
#pragma mark Reachability related

-(void) reachabilityChanged:(NSNotification*) notification
{
    if([self.reachability currentReachabilityStatus] == ReachableViaWiFi)
    {
      //  DLog(@"Server [%@] is reachable via Wifi", self.hostName);
        [_sharedNetworkQueue setMaxConcurrentOperationCount:6];
    }
    else if([self.reachability currentReachabilityStatus] == ReachableViaWWAN)
    {
       // DLog(@"Server [%@] is reachable only via cellular data", self.hostName);
        [_sharedNetworkQueue setMaxConcurrentOperationCount:2];
    }
//    else if([self.reachability currentReachabilityStatus] == NotReachable)
//    {
//        DLog(@"Server [%@] is not reachable", self.hostName);        
//    }
    
    if(self.reachabilityChangedHandler) {
        self.reachabilityChangedHandler([self.reachability currentReachabilityStatus]);
    }
}

-(NSString*) readonlyHostName {
    
    return [_hostName copy];
}

-(BOOL) isReachable {
    
    return ([self.reachability currentReachabilityStatus] != NotReachable);
}

#pragma mark -
#pragma mark Create methods

-(void) registerOperationSubclass:(Class) aClass {
    
    self.customOperationSubclass = aClass;
}

-(MKNetworkOperation*) operationWithPath:(NSString*) path {
    
    return [self operationWithPath:path params:nil];
}

-(MKNetworkOperation*) operationWithPath:(NSString*) path
                                  params:(NSMutableDictionary*) body {
    
    return [self operationWithPath:path 
                            params:body 
                        httpMethod:@"GET"];
}

-(MKNetworkOperation*) operationWithPath:(NSString*) path
                                  params:(NSMutableDictionary*) body
                              httpMethod:(NSString*)method  {
    
    return [self operationWithPath:path params:body httpMethod:method ssl:NO];
}

-(MKNetworkOperation*) operationWithPath:(NSString*) path
                                  params:(NSMutableDictionary*) body
                              httpMethod:(NSString*)method 
                                     ssl:(BOOL) useSSL {
    
    if(self.hostName == nil) {
        
        DLog(@"Hostname is nil, use operationWithURLString: method to create absolute URL operations");
        return nil;
    }
    
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@://%@", useSSL ? @"https" : @"http", self.hostName];
    
    if(self.portNumber != 0)
        [urlString appendFormat:@":%d", self.portNumber];
    
    if(self.apiPath) 
        [urlString appendFormat:@"/%@", self.apiPath];
    
    [urlString appendFormat:@"/%@", path];
    
    return [self operationWithURLString:urlString params:body httpMethod:method];
}

-(MKNetworkOperation*) operationWithURLString:(NSString*) urlString {
    
    return [self operationWithURLString:urlString params:nil httpMethod:@"GET"];
}

-(MKNetworkOperation*) operationWithURLString:(NSString*) urlString
                                       params:(NSMutableDictionary*) body {
    
    return [self operationWithURLString:urlString params:body httpMethod:@"GET"];
}


-(MKNetworkOperation*) operationWithURLString:(NSString*) urlString
                                       params:(NSMutableDictionary*) body
                                   httpMethod:(NSString*)method {
    
    MKNetworkOperation *operation = [[self.customOperationSubclass alloc] initWithURLString:urlString params:body httpMethod:method];
    
    [self prepareHeaders:operation];
    return operation;
}

-(void) prepareHeaders:(MKNetworkOperation*) operation {
    
    [operation addHeaders:self.customHeaders];
}

-(void) enqueueOperation:(MKNetworkOperation*) operation {
    
    [self enqueueOperation:operation forceReload:NO];
}

-(void) enqueueOperation:(MKNetworkOperation*) operation forceReload:(BOOL) forceReload {
    
    NSParameterAssert(operation != nil);
    // Grab on to the current queue (We need it later)
    dispatch_queue_t originalQueue = dispatch_get_current_queue();
    dispatch_retain(originalQueue);
    // Jump off the main thread, mainly for disk cache reading purposes
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 可以在这里设置operation cache
        
        __block double expiryTimeInSeconds = 0.0f;    
        
        if([operation isCacheable]) {
            
            dispatch_async(originalQueue, ^{
                
                NSUInteger index = [_sharedNetworkQueue.operations indexOfObject:operation];
                if(index == NSNotFound) {
                    
                    if(expiryTimeInSeconds <= 0)
                        [_sharedNetworkQueue addOperation:operation];
                    else if(forceReload)
                        [_sharedNetworkQueue addOperation:operation];
                    // else don't do anything
                }
                else {
                    // This operation is already being processed
                    MKNetworkOperation *queuedOperation = (MKNetworkOperation*) [_sharedNetworkQueue.operations objectAtIndex:index];
                    [queuedOperation updateHandlersFromOperation:operation];
                }
                
                
            });
        } else {
            
            [_sharedNetworkQueue addOperation:operation];
        }
        
        dispatch_release(originalQueue);
    });
}

- (MKNetworkOperation*)imageAtURL:(NSURL *)url onCompletion:(MKNKImageBlock) imageFetchedBlock
{
    if (url == nil) {
        return nil;
    }
    
    MKNetworkOperation *op = [self operationWithURLString:[url absoluteString]];
    
    [op 
     onCompletion:^(MKNetworkOperation *completedOperation)
     {
         imageFetchedBlock([completedOperation responseImage], 
                           url,
                           [completedOperation isCachedResponse]);
         
     }
     onError:^(NSError* error) {
         
         DLog(@"%@", error);
     }];    
    
    [self enqueueOperation:op];
    
    return op;
}

-(NetworkStatus)reachabilityStatus
{
    return [self.reachability currentReachabilityStatus];
}

-(NSUInteger)currentOperationCount
{
    return [_sharedNetworkQueue operationCount];
}

+(void)cancelAllRequest
{
    if(_sharedNetworkQueue)
    {
        [_sharedNetworkQueue cancelAllOperations];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

@end
