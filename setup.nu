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

    for config in $configs.configs {
        if ($config.platform | where $it == $nu.os-info.name | is-empty) {
            print $"Config ($config.name) is not for this platform"
            continue
        }

        for $link in $config.links {
            let source_path = $repository_path | path join config | path join $link.0
            let target_path = $env.XDG_CONFIG_HOME | path join $link.1

            print $"Linking ($source_path) to ($target_path)"

            if (try {
                ls $target_path
                true
            } catch {
                false
            }) {
                if $overwrite or (ask_yes_no $"($target_path) already exists. Do you want to overwrite it? \(y/n\)") {
                    if ($target_path | path type) == "symlink" {
                        rm $target_path
                        print $"($target_path) removed \(because it was a symlink\)"
                    } else {
                        mv $target_path $"($target_path).bak"
                        print $"($target_path) backed up"
                    }
                } else {
                    print $"($target_path) already exists"
                    continue
                }
            }

            ln -s $source_path $target_path
        }
    }
}