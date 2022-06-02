---
name: Epic
about: A task large enough that it needs to be divided into smaller tasks. It will usually be labeled as `enhancement`, also know as feature.
---

<!-- Issue title should mirror the Epic/Feature Title -->

# Epic Title

Feature: Some Task title

## Feature Description

This Feature will...

## List of Tasks (Complete in order) with experience Notes

<!-- The linik below should link to its Epic parent -->

- [ ] #1 
 - Defines the section and item nested structures first; Then think about the navigation, which is the function (or the feature you want to apply when selecting on the item), and expand the properties based on that.
 - There is a defect for the section header, the fonts is blocked on the top of the table view.
 - Better readability, when there is duplicate codes, there should be a better way of doing this.
- [ ] #3 
 - This part should be better modulated into an engine part for filtering
 - When dataSource is changed, it will cause many issues by simply change the dataSource. like assigning filtered results to original sections. This will cause the original data lost. Ideally the sections/dataSource should be considered as a computed variable. So for the UI part, the logics is consistent, and the switching between dataSource is done in the computed variable. But again, this logics could be done better in a presenter component.