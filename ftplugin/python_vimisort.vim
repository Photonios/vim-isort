if has('python3')
else
    throw 'No python3 support present, vim-isort will be disabled.'
endif

command! Isort exec("python3 isort_file()")

python3 <<EOF
import vim
import isort

try:
    from isort import SortImports
    isort_imported = True
except ImportError:
    isort_imported = False

def count_blank_lines_at_end(lines):
    blank_lines = 0
    for line in reversed(lines):
        if line.strip():
            break
        else:
            blank_lines += 1
    return blank_lines


def isort(text_range):
    # refuse to run if isort is not installed
    if not isort_imported:
        print('isort not installed.', file=sys.stderr)
        return

    # save the current contents so we can compare
    # it after the sort and remove excessive whitelines
    blank_lines_at_end = count_blank_lines_at_end(text_range)
    old_text = '\n'.join(text_range)

    # get the configuration, we have to go through
    # all the options because vimscript converts
    # everything to strings, and options that are
    # supposed to be integers, have to be integers
    # otherwise isort complains
    config = vim.eval('g:isort_options')
    for option in config:
        try:
            config[option] = int(config[option])
        except ValueError:
            pass

    # sort the imports
    new_text = SortImports(file_contents=old_text, **config).output
    new_lines = new_text.split('\n')

    # remove empty lines wrongfully added
    while new_lines and not new_lines[-1].strip() and blank_lines_at_end < count_blank_lines_at_end(new_lines):
        del new_lines[-1]

    text_range[:] = new_lines


def isort_file():
    isort(vim.current.buffer)


def isort_visual():
    isort(vim.current.range)

EOF
