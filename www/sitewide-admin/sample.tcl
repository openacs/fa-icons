ad_page_contract {
    @author Gustaf Neumann

    @creation-date Jan 1, 2020
} {
}

set resource_info [::fa_icons::resource_info]

set title "Sample Font Awesome Icons"
set context [list [list "." "Font Awesome Icons"] $title]

#
# Collect generic names
#
set generic {}
foreach iconset [dict keys $::template::icon::map] {
    lappend generic {*}[dict keys [dict get $::template::icon::map $iconset]]
}
#
# Default iconset
#
set iconset [::template::iconset]

#
# Generic URL for CSS (based on URN)
#
set CSS_URL urn:ad:css:fa-icons

template::head::add_css -href $CSS_URL



append genericHTML \
    {<table class="table">} \n \
    {<tr><th scope="col">Name</th><th scope="col" >fa-icons</th>} \
    [expr {$iconset ne "fa-icons" ? "<th scope='col'>$iconset</th>" : ""}] \
    </tr>\n \
    [join [lmap name [lsort -unique [set generic]] {
        set _ <tr>
        append _ [subst {<td scope="row">$name</td><td><adp:icon iconset="fa-icons" name="$name"></td>}]
        if {$iconset ne "fa-icons"} {
            append _ [subst {<td><adp:icon name="$name" alt="$name"></td>}]
        }
        #append _ [subst {<td><adp:icon iconset="classic" name="$name" alt="$name"></td>}]
        append _ </tr>
    }] \n] \
    </table>\n


#<h3>Using an Font Awesome Icons as SVG image</h3>
#<p>Font Awesome <img src="$URL/bootstrap.svg" alt="Font Awesome" width="32" height="32">

set content [subst {

    <h3>Using Font Awesome Icons as fonts (sample)</h3>

    <blockquote class="mx-4">
    GitHub <i class="fa-brands fa-github"></i><br>

    archive <i class="fa-solid fa-box-archive"></i> solid (regular, light, duotone, thin require pro icons).<br>
    circle-arrow-right <i class="fa-solid fa-circle-arrow-right"></i><br>
    square-up-right <i class="fa-solid fa-square-up-right"></i><br>
    circle-right <i class="fa-solid fa-circle-right"></i> (solid)
    circle-right <i class="fa-regular fa-circle-right"></i> (regular)<br>
    arrow-up-right-from-square <i class="fa-solid fa-arrow-up-right-from-square"></i><br>
    up-right-from-square <i class="fa-solid fa-up-right-from-square"></i></br>

    fa-square-caret-up <i class="fa-solid fa-square-caret-up"></i> (solid)
    <i class="fa-regular fa-square-caret-up"></i> (regular) <br>

    check <i class="fa-solid fa-check"></i><br>
    clock-rotate-left <i class="fa-solid fa-clock-rotate-left"></i> <br>
    cloud <i class="fa-solid fa-cloud"></i><br>
    envelope <i class="fa-solid fa-envelope"></i> (solid) <i class="fa-regular fa-envelope"></i> (regular)<br>
    eye <i class="fa-solid fa-eye"></i> (solid) <i class="fa-regular fa-eye"></i> (regular)<br>

    file <i class="fa-solid fa-file"></i> (solid) <i class="fa-regular fa-file"></i> (regular)<br>

    folder <i class="fa-solid fa-folder"></i> (solid) <i class="fa-regular fa-folder"></i> (regular)<br>
    folder-open <i class="fa-solid fa-folder-open"></i> (solid) <i class="fa-regular fa-folder-open"></i> (regular)<br>
    circle-info<i class="fa-solid fa-circle-info"></i><br>

    pen-to-square <i class="fa-solid fa-pen-to-square"></i> (solid) <i class="fa-regular fa-pen-to-square"></i> (regular)<br>

    trash-can <i class="fa-solid fa-trash-can"></i> (sold) <i class="fa-regular fa-trash-can"></i> (regular)<br>
    upload <i class="fa-solid fa-upload"></i><br>
    </blockquote>

    <h3>Resource info for Font Awesome Icons</h3>

    <p> <table>[join [lmap {k v} $resource_info {string cat <tr><td><i>$k ":</td><td> " $v</td></tr>}]]</table>
}]
