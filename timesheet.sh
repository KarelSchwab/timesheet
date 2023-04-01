# timesheet add <task> - Add a take to the timesheet

# timesheet list - List current days tasks
# timesheet list <date> - List tasks for the day of the date
# timesheet list <start_date> <end_date> - List tasks for the range of dates

# timesheet remove - Removes the last added task

tasks_dir="${HOME}/.local/share/timesheet"
log_dir="${HOME}/.local/log"
log_file="${log_dir}/timesheet.log"

[ ! -d "${log_dir}" ] && mkdir -p "${log_dir}"
[ ! -f "${log_file}" ] && echo "07:00 - Day start" > "${log_file}"
[ ! -d "${tasks_dir}" ] && mkdir -p "${tasks_dir}"

case "${1}" in
    add | a)
        if [ -z "${2}" ] ; then
            echo "No task specified"
            exit 1
        fi

        task="$( date +%H:%M ) - ${2}"
        file="$( date +%Y-%m-%d ).txt"

        echo "Adding \"${task}\" to $( date +%Y-%m-%d ) timesheet" >> "${log_file}"
        echo "${task}" >> "${tasks_dir}/${file}"
        ;;
    list | l)
        start_date="${2}"
        end_date="${3}"

        if [ -n "${start_date}" ] && [ -n "${end_date}" ] ; then
            # echo "start and date specified"
            echo "Not yet implemented"
            exit 0
        fi

        if [ -n "${start_date}" ] ; then
            if [ ! -f "${tasks_dir}/${2}.txt" ] ; then
                echo "No tasks for ${2}"
                exit 1
            fi

            cat "${tasks_dir}/${2}.txt"
            exit 0
        fi

        cat "${tasks_dir}/$( date +%Y-%m-%d ).txt"
        ;;
    remove | r)
        echo "Removing last task from $( date +%Y-%m-%d ) timesheet" >> "${log_file}"
        sed -i '$ d' "${tasks_dir}/$( date +%Y-%m-%d ).txt"
        ;;
    help | h)
        echo "timesheet add <task> - Add a take to the timesheet"

        echo "timesheet list - List current days tasks"
        echo "timesheet list <date> - List tasks for the day of the date"
        echo "timesheet list <start_date> <end_date> - List tasks for the range of dates"

        echo "timesheet remove - Removes the last added task"
        ;;
    *)
        echo "Invalid command"
        ;;
esac

exit 0
