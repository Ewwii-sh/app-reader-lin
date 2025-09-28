import "std::command" as cmd;

fn list_apps() {
    let local_apps = cmd::run_and_read("ls ~/.local/share/applications/");
    let system_apps = cmd::run_and_read("ls /usr/share/applications/");

    return local_apps.split() + system_apps.split();
}

fn get_app_entry(app_name) {
    let n = check_local_or_system(app_name);

    let path;

    if n == 0 {
        path = `~/.local/share/applications/${app_name}.desktop`
    } else if n == 1 {
        path = `/usr/share/applications/${app_name}.desktop`
    } else if n == 2 {
        return "Provided application was not found!";
    } else {
        return "Unexpected error reached!";
    }

    let fs_contents = cmd::run_and_read(`cat ${path}`);
    return fs_contents;
}

fn check_local_or_system(app_name) {
    let command = `
LOCAL=~/.local/share/applications
SYS=/usr/share/applications

if [[ -f "$LOCAL/${app_name}.desktop" ]]; then
    echo 0
elif [[ -f "$SYS/${app_name}.desktop" ]]; then
    echo 1
else
    echo 2
fi
    `;

    let res = cmd::run_and_read(command);

    return parse_int(res);
}

fn parse_app_entry(entry) {
    let result = #{};

    let lines = entry.split("\n");

    for line in lines {
        if line == "" || line.starts_with("[")  {
            continue;
        }

        let parts = line.split("=");
        if parts.len() == 2 {
            let key = parts[0];
            let value = parts[1];

            // some fields should turn into arrays
            if key == "Categories" || key == "MimeType" || key == "Actions" {
                let arr = value.split(";");
                let clean_arr = arr.filter(|x| x != "");
                result[key] = clean_arr;
            } else if value == "true" {
                result[key] = true;
            } else if value == "false" {
                result[key] = false;
            } else {
                result[key] = value;
            }
        }
    }

    return result;
}