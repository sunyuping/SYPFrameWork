//
//  CJPathManager.h
//  CJFramework
//
//  Created by liu ys on 11-11-14.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJSingleton.h"
#import "CJFileManager.h"

@interface CJPathManager : NSObject {
    NSString* _rootPath;
    CJFileManager* _fileManager;
}
+(CJPathManager*) defaultPathManager;
-(NSMutableString*) getLogPath;
-(NSMutableString*) getDatabasePath;
-(NSMutableString*) getCachePath;
-(NSMutableString*) getDownloadPath;

-(NSMutableString*) getApplicationPath;
-(NSMutableString*) getSystemVideoPath;
-(NSMutableString*) getSystemAudioPath;
-(NSMutableString*) getSystemPhotoPath;
@end
