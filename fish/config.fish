# from /etc/profile
if status --is-login
    set MSYS2_PATH /usr/local/bin /usr/bin /bin
    set MANPATH /usr/local/man /usr/share/fish/man /usr/share/man /usr/man /share/man $MANPATH
    set -gx INFOPATH /usr/local/info /usr/share/info /usr/info /share/info $INFOPATH

    if test -z $MSYS2_PATH_TYPE
        set MSYS2_PATH_TYPE inherit
    end

    switch $MSYS2_PATH_TYPE
        case strict
            # Do not inherit any path configuration, and allow for full customization
            # of external path. This is supposed to be used in special cases such as
            # debugging without need to change this file, but not daily usage.
            set -e ORIGINAL_PATH
        case inherit
            # Inherit previous path. Note that this will make all of the Windows path
            # available in current shell, with possible interference in project builds.
            set ORIGINAL_PATH "$ORIGINAL_PATH $PATH"
        case '*'
            # Do not inherit any path configuration but configure a default Windows path
            # suitable for normal usage with minimal external interference.
            set WIN_ROOT (/usr/bin/env PATH=$MSYS2_PATH cygpath -Wu)
            set ORIGINAL_PATH $WIN_ROOT/System32 $WIN_ROOT $WIN_ROOT/System32/Wbem $WIN_ROOT/System32/WindowsPowerShell/v1.0
    end

    # from /etc/msystem
    if test -z MSYSTEM
        set -x MSYSTEM MSYS
    end

    switch $MSYSTEM
        case MINGW32
            set -gx MSYSTEM_PREFIX /mingw32
            set -gx MSYSTEM_CARCH i686
            set -gx MSYSTEM_CHOST i686-w64-mingw32
            set -gx MINGW_CHOST $MSYSTEM_CHOST
            set -gx MINGW_PREFIX $MSYSTEM_PREFIX
            set -gx MINGW_PACKAGE_PREFIX mingw-w64-$MSYSTEM_CARCH
        case MINGW64
            set -gx MSYSTEM_PREFIX /mingw64
            set -gx MSYSTEM_CARCH x86_64
            set -gx MSYSTEM_CHOST x86_64-w64-mingw32
            set -gx MINGW_CHOST $MSYSTEM_CHOST
            set -gx MINGW_PREFIX $MSYSTEM_PREFIX
            set -gx MINGW_PACKAGE_PREFIX mingw-w64-$MSYSTEM_CARCH
        case 'CLANG32'
            set -gx MSYSTEM_PREFIX /clang32
            set -gx MSYSTEM_CARCH i686
            set -gx MSYSTEM_CHOST i686-w64-mingw32
            set -gx MINGW_CHOST $MSYSTEM_CHOST
            set -gx MINGW_PREFIX $MSYSTEM_PREFIX
            set -gx MINGW_PACKAGE_PREFIX mingw-w64-clang-$MSYSTEM_CARCH
        case 'CLANG64'
            set -gx MSYSTEM_PREFIX /clang64
            set -gx MSYSTEM_CARCH x86_64
            set -gx MSYSTEM_CHOST x86_64-w64-mingw32
            set -gx MINGW_CHOST $MSYSTEM_CHOST
            set -gx MINGW_PREFIX $MSYSTEM_PREFIX
            set -gx MINGW_PACKAGE_PREFIX mingw-w64-clang-$MSYSTEM_CARCH
        case 'CLANGARM64'
            set -gx MSYSTEM_PREFIX /clangarm64
            set -gx MSYSTEM_CARCH aarch64
            set -gx MSYSTEM_CHOST aarch64-w64-mingw32
            set -gx MINGW_CHOST $MSYSTEM_CHOST
            set -gx MINGW_PREFIX $MSYSTEM_PREFIX
            set -gx MINGW_PACKAGE_PREFIX mingw-w64-clang-$MSYSTEM_CARCH
        case 'UCRT64'
            set -gx MSYSTEM_PREFIX /ucrt64
            set -gx MSYSTEM_CARCH x86_64
            set -gx MSYSTEM_CHOST x86_64-w64-mingw32
            set -gx MINGW_CHOST $MSYSTEM_CHOST
            set -gx MINGW_PREFIX $MSYSTEM_PREFIX
            set -gx MINGW_PACKAGE_PREFIX mingw-w64-$MSYSTEM_CARCH
        case '*'
            set -gx MSYSTEM_PREFIX /usr
            set -gx MSYSTEM_CARCH $HOSTTYPE
            set -gx MSYSTEM_CHOST $MACHTYPE
            set -gx CONFIG_SITE /etc/config.site
    end

    switch $MSYSTEM
        case 'MINGW*' 'CLANG*' 'UCRT*'
            set MINGW_MOUNT_POINT $MINGW_PREFIX
            set -gx PATH $MINGW_MOUNT_POINT/bin $MSYS2_PATH $ORIGINAL_PATH
            set -gx PKG_CONFIG_PATH $MINGW_MOUNT_POINT/lib/pkgconfig $MINGW_MOUNT_POINT/share/pkgconfig
            set ACLOCAL_PATH $MINGW_MOUNT_POINT/share/aclocal /usr/share/aclocal
            set -gx MANPATH $MINGW_MOUNT_POINT/share/man $MANPATH
        case '*'
            set -gx PATH $MSYS2_PATH $ORIGINAL_PATH
            set -gx PKG_CONFIG_PATH /usr/lib/pkgconfig /usr/share/pkgconfig /lib/pkgconfig
    end

    set -gx CONFIG_SITE /etc/config.site

    set -gx SYSCONFDIR /etc

    set ORIGINAL_TMP $TMP
    set ORIGINAL_TEMP $TEMP
    set -e TMP
    set -e TEMP
    set -gx tmp (cygpath -w $ORIGINAL_TMP 2> /dev/null)
    set -gx temp (cygpath -w $ORIGINAL_TEMP 2> /dev/null)
    set -gx TMP /tmp
    set -gx TEMP /tmp

    set p "/proc/registry/HKEY_CURRENT_USER/Software/Microsoft/Windows NT/CurrentVersion/Windows/Device"
    if test -e $p
        read PRINTER < $p
        set -gx PRINTER (echo $PRINTER | sed -e 's/,.*$//g')
    end
    set -e p

    if test -n "$ACLOCAL_PATH"
        set -gx ACLOCAL_PATH $ACLOCAL_PATH
    end

    set -gx LC_COLLATE C
    for postinst in /etc/post-install/*.post
        if test -e $postinst
            sh -c $postinst
        end
    end

    # from /etc/profile.d/lang.sh
    if test -n "$LC_ALL"; or test -n "$LANG"; or test -n "$LC_CTYPE"
        set -gx LC_CTYPE (/usr/bin/locale -uU)
        set -gx LC_NUMERIC $LC_CTYPE
        set -gx LC_TIME $LC_CTYPE
        set -gx LC_COLLATE $LC_CTYPE
        set -gx LC_MONETARY $LC_CTYPE
        set -gx LC_MESSAGES $LC_CTYPE
    end

    # from /etc/profile.d/perlbin.sh
    if test -d /usr/bin/site_perl
        set -gx PATH $PATH /usr/bin/site_perl
    end
    if test -d /usr/lib/perl5/site_perl/bin
        set -gx PATH $PATH /usr/lib/perl5/site_perl/bin
    end

    if test -d /usr/bin/vendor_perl
        set -gx PATH $PATH /usr/bin/vendor_perl
    end
    if test -d /usr/lib/perl5/vendor_perl/bin
        set -gx PATH $PATH /usr/lib/perl5/vendor_perl/bin
    end

    if test -d /usr/bin/core_perl
        set -gx PATH $PATH /usr/bin/core_perl
    end
end