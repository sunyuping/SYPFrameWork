//
//  YPSectionedDataSource.m
//  SYPFrameWork
//
//  Created by sunyuping on 13-1-8.
//  Copyright (c) 2013年 sunyuping. All rights reserved.
//

#import "YPTableViewSectionedDataSource.h"
#import "YPTableViewItem.h"

@interface YPTableViewSectionedDataSource(Pirvate)

- (BOOL)removeItemAtIndexPath:(NSIndexPath *)indexPath andSectionIfEmpty:(BOOL)andSection;

@end
@implementation YPTableViewSectionedDataSource
@synthesize sections			= _sections;
@synthesize firstSectionItems	= _firstSectionItems;

// /////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc
{
	self.sections = nil;
	[super dealloc];
}

- (NSArray *)firstSectionItems
{
	if ((_sections == nil) || (_sections.count <= 0)) {
		return nil;
	}

	YPTableViewSectionObject *firstObj = [_sections objectAtIndex:0];
	return firstObj.items;
}

- (void)setFirstSectionItems:(NSArray *)itemArray
{
    if (!self.sections || self.sections.count <= 0) {
        YPTableViewSectionObject *firstObj = [[YPTableViewSectionObject alloc] init];
        self.sections = [NSArray arrayWithObject:firstObj];
        [firstObj release];
    }
    [[self.sections objectAtIndex:0] setItems:itemArray];
}

- (BOOL)empty
{
    return (self.sections == nil
            || self.sections.count <= 0
            || (self.sections.count == 1 && self.firstSectionItems.count <= 0) );
}

- (BOOL)buttonExecutable
{
    return NO;
}

#pragma mark -
#pragma mark Class public
// should be overrided
- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    return [super tableView:tableView cellClassForObject:object];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return _sections ? _sections.count : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (_sections && _sections.count > section)
    {
		YPTableViewSectionObject *sectionObject = [_sections objectAtIndex:section];
		return sectionObject.items.count;
	}

	return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if (_sections.count)
    {
		YPTableViewSectionObject *sectionObject = [_sections objectAtIndex:section];
		return sectionObject.letter;
	}
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	if (_sections.count)
    {
		YPTableViewSectionObject *sectionObject = [_sections objectAtIndex:section];
        if (sectionObject != nil && sectionObject.footerTitle != nil && ![sectionObject.footerTitle isEqualToString:@""])
        {
            return sectionObject.footerTitle;
        }

	}
    return nil;
}

#pragma mark -
#pragma mark TTTableViewDataSource

- (id)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (_sections.count > 0)
    {
		YPTableViewSectionObject *aSectionObject = [_sections objectAtIndex:indexPath.section];

		if ([aSectionObject.items count] > indexPath.row)
        {
			return [aSectionObject.items objectAtIndex:indexPath.row];
		}
	}

	return nil;
}

- (NSIndexPath *)tableView:(UITableView *)tableView indexPathForObject:(id)object
{
	if (_sections) {
		for (int i = 0; i < _sections.count; ++i)
        {
			YPTableViewSectionObject	*aSectionObject = [_sections objectAtIndex:i];
			NSUInteger					objectIndex		= [aSectionObject.items indexOfObject:object];

			if (objectIndex != NSNotFound) {
				return [NSIndexPath indexPathForRow:objectIndex inSection:i];
			}
		}
	}

	return nil;
}

#pragma mark -
#pragma mark Public

- (NSIndexPath *)indexPathOfItemWithUserInfo:(id)userInfo
{
	if (_sections.count) {
		for (NSInteger i = 0; i < _sections.count; ++i)
        {
			YPTableViewSectionObject *sectionObject = [_sections objectAtIndex:i];
            
			for (NSInteger j = 0; j < sectionObject.items.count; ++j)
            {
				YPTableViewItem *item = [sectionObject.items objectAtIndex:j];
                
				if (item.userInfo == userInfo)
                {
					return [NSIndexPath indexPathForRow:j inSection:i];
				}
			}
		}
	}
    
	return nil;
}

- (BOOL)removeItemAtIndexPath:(NSIndexPath *)indexPath
{
	return [self removeItemAtIndexPath:indexPath andSectionIfEmpty:NO];
}

- (BOOL)removeItemAtIndexPath:(NSIndexPath *)indexPath andSectionIfEmpty:(BOOL)andSection
{
	if (_sections.count)
    {
		YPTableViewSectionObject *sectionObject = [_sections objectAtIndex:indexPath.section];
		[sectionObject.items removeObjectAtIndex:indexPath.row];
        
		if (andSection && sectionObject.items.count == 0)
        {
			[_sections removeObjectAtIndex:indexPath.section];
			return YES;
		}
	}
    
	return NO;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willUpdateObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(object != nil, @"tableview updateObject is nil !!!");
    if (_sections.count > indexPath.section)
    {
        YPTableViewSectionObject *sectionObject = [_sections objectAtIndex:indexPath.section];
        if (sectionObject.items.count > indexPath.row)
        {
            [sectionObject.items replaceObjectAtIndex:indexPath.row withObject:object];
        }
    }
    return indexPath;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willInsertObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(object != nil, @"tableview insertObject is nil !!!");
    YPTableViewSectionObject *sectionObject = nil;
    if (_sections.count <= indexPath.section)
    {
        // ADD section
        sectionObject = [[YPTableViewSectionObject alloc] init];
        sectionObject.items = [NSMutableArray arrayWithObject:object];
        [_sections insertObject:sectionObject atIndex:indexPath.section];
    }
    else
    {
        NSAssert(indexPath != nil , @"indexPath is nil !!!");
        sectionObject = [[_sections objectAtIndex:indexPath.section] retain];
        [sectionObject.items insertObject:object atIndex:indexPath.row];
        [_sections replaceObjectAtIndex:indexPath.section withObject:sectionObject];
    }
    [sectionObject release];
    
    return indexPath;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willRemoveObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath != nil)
    {
        [self removeItemAtIndexPath:indexPath andSectionIfEmpty:YES];
    }
    else if(object != nil)
    {
        indexPath = [self tableView:tableView indexPathForObject:object];
        if (indexPath != nil)
        {
            [self removeItemAtIndexPath:indexPath andSectionIfEmpty:YES];
        }
    }
    else
    {
        NSAssert(indexPath == nil && object == nil, @"object and indexPath are nil !!!");
    }
    // If Object Not Founded ==> return nil
    return indexPath;
}
@end