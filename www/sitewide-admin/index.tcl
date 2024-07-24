ad_page_contract {
    @author Gustaf Neumann

    @creation-date Aug 6, 2018
} {
}

set version $::fa_icons::version
set resource_info [::fa_icons::resource_info]
set download_url [ad_conn url]/download

set title "[dict get $resource_info resourceName] - Sitewide Admin"
set context [list $title]


# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
