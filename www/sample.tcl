ad_page_contract {
    @author Gustaf Neumann

    @creation-date Jan 1, 2020
} {
}

set resource_info [::fa_icons::resource_info]

set title "[dict get $resource_info resourceName] - Sample page"
set context [list $title]

set URL1 /resources/fa-icons/fa-icons-1.8.1//bootstrap.svg

set content [subst {
    <p> As image <img src="/assets/img/bootstrap.svg" alt="Bootstrap" width="32" height="32">

}]
