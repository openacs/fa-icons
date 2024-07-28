ad_library {

    Font Awesome icons

    This script defines the following public procs:

    ::fa_icons::resource_info
    ::fa_icons::download

    @author Gustaf Neumann
    @creation-date 1 Apri 2022
}

namespace eval ::fa_icons {

    set package_id [apm_package_id_from_key "fa-icons"]

    #
    # The Font Awesome Icons configuration can be tailored via the OpenACS
    # configuration file:
    #
    # ns_section ns/server/${server}/acs/fa-icons
    #        ns_param FAIconsVersion 6.5.2
    #
    set ::fa_icons::version [parameter::get \
                                        -package_id $package_id \
                                        -parameter FAIconsVersion \
                                        -default 6.5.2]

    ad_proc ::fa_icons::resource_info {
        {-version ""}
    } {

        Get information about available version(s) of Font Awesome Icons,
        from the local filesystem, or from CDN.

    } {
        #
        # If no version is specified, use the namespaced variable.
        #
        if {$version eq ""} {
            set version $::fa_icons::version
        }

        #
        # Setup variables for access via CDN vs. local resources.
        #
        set resourceDir [acs_package_root_dir fa-icons/www/resources]
        set resourceUrl /resources/fa-icons
        set cdnHost     cdnjs.cloudflare.com
        set cdn         //$cdnHost/

        if {[file exists $resourceDir/fontawesome-free-$version-web/css]} {
            #
            # Local version is installed
            #
            set prefix  $resourceUrl/fontawesome-free-$version-web/css
            set cdnHost ""
            set cspMap ""
        } else {
            #
            # Use CDN
            #
            # cloudflare has e.g. the following resources:
            #
            #    https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css
            #
            # We just need the CSS file, which is on the CDN in the
            # "font" directory.
            set prefix $cdn/ajax/libs/font-awesome/$version/css
            set cspMap [subst {
                urn:ad:css:fa-icons {
                    style-src $cdnHost
                    font-src $cdnHost
                }}]
        }

        #
        # Return the dict with at least the required fields
        #
        lappend result \
            resourceName "Font Awesome Icons" \
            resourceDir $resourceDir \
            cdn $cdn \
            cdnHost $cdnHost \
            prefix $prefix \
            cssFiles {} \
            jsFiles  {} \
            extraFiles {} \
            downloadURLs https://github.com/FortAwesome/Font-Awesome/releases/download/${version}/fontawesome-free-${version}-web.zip \
            cspMap $cspMap \
            urnMap {} \
            versionCheckAPI {cdn cdnjs library font-awesome count 5} \
            installedVersion $version

        return $result
    }

    ad_proc -private ::fa_icons::download {
        {-version ""}
    } {
        Download Font Awesome Icons in the specified version and put it
        into a directory structure similar to the CDN to support the
        installation of multiple versions.
    } {

        set resource_info [resource_info -version $version]
        
        #
        # If no version is specified, use the version from resouce_info
        #
        if {$version eq ""} {
            set version [dict get $resource_info installedVersion]
        }

        ::util::resources::download -resource_info $resource_info

        set resourceDir [dict get $resource_info resourceDir]
        ns_log notice " ::fa_icons::download resourceDir $resourceDir"

        #
        # Do we have unzip installed?
        #
        set unzip [::util::which unzip]
        if {$unzip eq ""} {
            error "can't install Font Awesome Icons locally; no unzip program found on PATH"
        }

        #
        # Do we have a writable output directory under resourceDir?
        #
        if {![file isdirectory $resourceDir]} {
            file mkdir $resourceDir
        }
        if {![file writable $resourceDir]} {
            error "directory $resourceDir is not writable"
        }

        #
        # So far, everything is fine, unpack the downloaded zip file.
        #
        foreach url [dict get $resource_info downloadURLs] {
            set fn [file tail $url]
            util::unzip \
                -overwrite \
                -source $resourceDir/$version/$fn \
                -destination $resourceDir
        }
    }
}


# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
