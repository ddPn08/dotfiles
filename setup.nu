print "Setup dotfiles"

let repository_path = $env.FILE_PWD

# check XDG_CONFIG_HOME
if $env.XDG_CONFIG_HOME == "" {
  print "XDG_CONFIG_HOME is not set"
  exit 1
}

mkdir $env.XDG_CONFIG_HOME

# link all configs
let config_path = $repository_path | path join config

if ($config_path | path type) != "dir" {
    print "Config path not found"
    exit 1
}

let configs = ls $config_path | where type == "dir" or type == "file"

for config in $configs {
    let config_name = $config.name | path basename
    let config_target = $env.XDG_CONFIG_HOME | path join $config_name

    if (try {
        ls $config_target
        true
    } catch {
        false
    }) {
        print $"Config ($config_name) already exists"
        continue
    }

    ln -s $config.name $config_target
    print $"Config ($config_name) linked"
}