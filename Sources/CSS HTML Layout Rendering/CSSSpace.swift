//
//  CSSSpace.swift
//  swift-css-html-layout-render
//

/// Phantom type for the CSS coordinate space.
///
/// Parameterizes the layout algebra (`Layout<W3C_CSS_Values.Length, CSSSpace>`)
/// for CSS/HTML rendering. Carries no storage; used only at the type level.
public enum CSSSpace {}
