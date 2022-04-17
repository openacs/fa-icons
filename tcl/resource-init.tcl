
set resource_info [::fa_icons::resource_info]

set fn all.min.css

if {[dict exists $resource_info cdnHost] && [dict get $resource_info cdnHost] ne ""} {
    #
    # Add global CSP rules.
    #
    #lappend ::security::csp::default_directives \
    #    style-src [dict get $resource_info cdnHost] \
    #    font-src [dict get $resource_info cdnHost]
    
}

set URN urn:ad:css:fa-icons
template::register_urn \
    -urn $URN \
    -resource [dict get $resource_info prefix]/$fn \
    -csp_list [expr {[dict exists $resource_info cspMap $URN]
                     ? [dict get $resource_info cspMap $URN]
                     : ""}]
