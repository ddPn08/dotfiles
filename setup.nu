def ask_yes_no [message: string] -> bool {
    print $message
    let answer = input
    $answer == "y" or $answer == "Y"
}

def main [overwrite: bool = false] {
    print "Setup dotfiles"
    let repository_path = $env.FILE_PWD

    # check XDG_CONFIG_HOME
    if $env.XDG_CONFIG_HOME == "" {
        print "XDG_CONFIG_HOME is not set"
        exit 1
    }

    mkdir $env.XDG_CONFIG_HOME

    # link all configs
    let configs = open ($repository_path | path join configs.toml)
    let config_path = $repository_path | path join config

    for row in ($configs | transpose) {
        let config_name = $row | get column0
        let config = $row | get column1
        let filepath = $repository_path | path join config | path join $config.path
        let basename = $filepath | path basename
        let target_path = $env.XDG_CONFIG_HOME | path join $basename

        if ($config.platform | where $it == $nu.os-info.name | is-empty) {
            print $"Config ($basename) is not for this platform"
            continue
        }

        if (try {
            ls $target_path
            true
        } catch {
            false
        }) {
            if $overwrite or (ask_yes_no $"Config ($config_name) already exists. Do you want to overwrite it? \(y/n\)") {
                rm $target_path -r
                print $"Config ($config_name) removed"
            } else {
                print $"Config ($config_name) already exists"
                continue
            }
        }

        ln -s $filepath $target_path
        print $"Config ($config_name) linked"
    }
}