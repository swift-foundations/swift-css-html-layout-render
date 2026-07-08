//
//  Aliases.swift
//  swift-css-html-layout-render
//
//  Top-level source-compatibility spellings (principal ruling Q1) so existing
//  call sites keep compiling unchanged:
//
//      VStack { }
//      HStack(alignment:spacing:) { }
//      Spacer()
//      LazyVGrid(columns:) { }
//
//  This is the principal-authorized exception to the [API-NAME-004a]
//  rename-bridge discouragement, taken deliberately to avoid source breaks
//  while the containers move under `HTML.Layout.*` per [API-NAME-001].
//

public import HTML_Rendering

public typealias VStack = HTML.Layout.VStack
public typealias HStack = HTML.Layout.HStack
public typealias Spacer = HTML.Layout.Spacer
public typealias LazyVGrid = HTML.Layout.Grid.Lazy
