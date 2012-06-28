//
//  SYPPathManager.h
//  SYPFramework
//
//  Created by 玉平 孙 on 12-6-20.
//  Copyright (c) 2012年 RenRen.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYPSingleton.h"
#import "SYPFileManager.h"

@interface SYPPathManager : NSObject {
    NSString* _rootPath;
    SYPFileManager* _fileManager;
}
+(SYPPathManager*) defaultPathManager;
-(NSMutableString*) getLogPath;
-(NSMutableString*) getDatabasePath;
-(NSMutableString*) getCachePath;
-(NSMutableString*) getDownloadPath;

-(NSMutableString*) getApplicationPath;
-(NSMutableString*) getSystemVideoPath;
-(NSMutableString*) getSystemAudioPath;
-(NSMutableString*) getSystemPhotoPath;
@end
