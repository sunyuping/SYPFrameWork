//
//  YPCTableViewDataSource.m
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import "YPTableViewDataSource.h"
#import "YPTableViewItem.h"
#import "YPTableViewCell.h"
#import "YPBaseTableView.h"
#import "YPTableViewLoadMoreCell.h"
#import "YPTableViewLoadMoreItem.h"

@implementation YPTableViewDataSource
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class public


///////////////////////////////////////////////////////////////////////////////////////////////////
// 似乎没什么用，搜索图标是UITableViewIndexSearch
+ (NSArray*)lettersForSectionsWithSearch:(BOOL)search summary:(BOOL)summary {
    NSMutableArray* titles = [NSMutableArray array];
    if (search) {
        [titles addObject:UITableViewIndexSearch];
    }
    
    for (unichar c = 'A'; c <= 'Z'; ++c) {
        NSString* letter = [NSString stringWithFormat:@"%c", c];
        [titles addObject:letter];
    }
    
    if (summary) {
        [titles addObject:@"#"];
    }
    
    return titles;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UITableViewDataSource


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = [self tableView:tableView objectForRowAtIndexPath:indexPath];
    
    Class cellClass = [self tableView:tableView cellClassForObject:object];
    NSString *className = [cellClass className];
    
    UITableViewCell* cell =
    (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:className];
    if (cell == nil) {
        cell = [[[cellClass alloc] initWithStyle:UITableViewCellStyleDefault
                                 reuseIdentifier:className] autorelease];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    if ([cell isKindOfClass:[YPTableViewCell class]]) {
        [(YPTableViewCell*)cell setObject:object];
        [(YPTableViewCell*)cell setIndexPath:indexPath];
    }    
    [self tableView:tableView cell:cell willAppearAtIndexPath:indexPath];
    
    return cell;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSArray*)sectionIndexTitlesForTableView:(UITableView*)tableView {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView*)tableView sectionForSectionIndexTitle:(NSString*)title
               atIndex:(NSInteger)sectionIndex {
    if (tableView.tableHeaderView) {
        if (sectionIndex == 0)  {
            // This is a hack to get the table header to appear when the user touches the
            // first row in the section index.  By default, it shows the first row, which is
            // not usually what you want.
            [tableView scrollRectToVisible:tableView.tableHeaderView.bounds animated:NO];
            return -1;
        }
    }
    
    NSString* letter = [title substringToIndex:1];
    NSInteger sectionCount = [tableView numberOfSections];
    for (NSInteger i = 0; i < sectionCount; ++i) {
        NSString* section  = [tableView.dataSource tableView:tableView titleForHeaderInSection:i];
        if ([section hasPrefix:letter]) {
            return i;
        }
    }
    if (sectionIndex >= sectionCount) {
        return sectionCount-1;
        
    } else {
        return sectionIndex;
    }
}

#pragma mark -
#pragma mark TTTableViewDataSource


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)tableView:(UITableView*)tableView objectForRowAtIndexPath:(NSIndexPath*)indexPath {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (Class)tableView:(UITableView*)tableView cellClassForObject:(id)object {

	if ([object isKindOfClass:[YPTableViewLoadMoreItem class]]) {
		return [YPTableViewLoadMoreCell class];
	}
    else if ([object isKindOfClass:[YPTableViewItem class]]) {
        return [YPTableViewCell class];
    } 
     
    return [YPTableViewCell class];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)tableView:(UITableView*)tableView labelForObject:(id)object {
    return @"";
    //    if ([object isKindOfClass:[TTTableTextItem class]]) {
    //        TTTableTextItem* item = object;
    //        return item.text;
    //        
    //    } else {
    //        return [NSString stringWithFormat:@"%@", object];
    //    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSIndexPath*)tableView:(UITableView*)tableView indexPathForObject:(id)object {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView*)tableView cell:(UITableViewCell*)cell 
willAppearAtIndexPath:(NSIndexPath*)indexPath {
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)search:(NSString*)text {
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
    if (reloading) {
        return NSLocalizedString(@"Updating...", @"");
        
    } else {
        return NSLocalizedString(@"Loading...", @"");
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage*)imageForEmpty {
    return [self imageForError:nil];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage*)titleImageForEmpty{
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForEmpty {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage*)imageForError:(NSError*)error {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForError:(NSError*)error {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
   return error.localizedDescription;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)empty
{
    return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)buttonExecutable
{
    return NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIEdgeInsets)emptyViewEdgeInsets
{
    return UIEdgeInsetsZero;
}
@end
