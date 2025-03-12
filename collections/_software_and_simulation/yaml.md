---
title: Tips for using YAML
author: Gerard Capes
tags:
  - matflow-new
  - yaml
  - debugging
published: true
subcollection: MatFlow
---

# Useful things to know about yaml

 https://www.yaml.info/learn/bestpractices.html

 ## Indentation
YAML can use indented, or zero-indented lists (sequences), where the hyphen is
at the same level of indentation as the previous line.

```yaml
top_level_key:
- zero_indented_item
- another_zero_indented_item

different_top_level_key:
  - indented_list_item
  - another_indented_list_item
```

The creators recommend the zero-indented approach, but you can use either.
It can help to view the indentation by considering the text rather than the hyphen.
As ever, it's best to stick to one convention within the same file, for reasons of clarity.

## Splitting a long path
If you have a long path that you want to split over more than one line,
the best approach is to use a quoted string, and use a backslash to concatenate lines
without spaces e.g.

```
script: "<<script:/really/long/full/path/to/wherever/you/keep/your/matflow/script/\
        that/you/want/to/run/my_script.py>>"
```

## Multi-line strings
Block scalars using the literal style ("|") are useful for multi-line strings
e.g.

```
environments:
- name: abaqus_env
setup: |
    source /mnt/iusers01/support/mbexegc2/scratch/Abaqus_bayesian_matflow/.venv/bin/activate
    module load apps/binapps/abaqus/2022
```

## Null = None
In YAML, you use `Null` if you want to set a (python) value of `None`.

## Checking your YAML file
If you're struggling to understand a new error from MatFlow, 
it's worth checking you're using valid syntax in your yaml file(s) 
using something like https://www.yamllint.com/.
