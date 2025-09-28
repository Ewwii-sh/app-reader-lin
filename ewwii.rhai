// === TEST FILE === //
import "./app-reader-lin" as apprl;

let all_apps = apprl::list_apps();
let first_app = all_apps[0].split(".")[0];
let first_app_entry = apprl::get_app_entry(first_app);
let check_status = apprl::check_local_or_system(first_app);
let parsed_entry = apprl::parse_app_entry(first_app_entry);

print(all_apps); // print all apps
print(first_app_entry); // print info of first app
print(check_status); // check if app is installed at user or system (returns 0, 1, or 2)
print(parsed_entry); // print a parsed map of the .desktop entry

// just tricking ewwii to load
enter([
    defwindow("test", #{}, box(#{}, []))
])