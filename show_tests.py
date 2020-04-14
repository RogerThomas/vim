#!/usr/bin/env python
import argparse
import importlib
import inspect
import os
import sys


def _get_classes(mod):
    classes = []
    for name, obj in inspect.getmembers(mod):
        if inspect.isclass(obj) and obj.__module__ == mod.__name__:
            classes.append(obj)
    return classes


def main(args):
    cwd = os.getcwd()
    sys.path.append(cwd)

    # Get the module
    file_path = args.file_path
    mod_path = file_path.replace("/", ".")[:-3]
    mod = importlib.import_module(mod_path)

    # Find tests
    classes = _get_classes(mod)
    tests_found = {}
    longest_cls_name = 0
    longest_method_name = 0
    for cls in classes:
        method_list = filter(
            lambda func: callable(getattr(cls, func)) and func.startswith("test"), dir(cls)
        )
        cls_name = cls.__name__
        tests_found[cls_name] = []
        for method_name in method_list:
            tests_found[cls_name].append(method_name)
            longest_cls_name = max(longest_cls_name, len(cls_name))
            longest_method_name = max(longest_method_name, len(method_name))

    i = 0
    print("Found:")
    choices = {}
    for cls_name in sorted(tests_found):
        if not tests_found[cls_name]:
            continue
        i += 1
        method_name = "All"
        print(f"{cls_name: <{longest_cls_name}} - {method_name: <{longest_method_name}} - {i}")
        choices[i] = f"{file_path}:{cls_name}"
        for method_name in tests_found[cls_name]:
            i += 1
            print(f"{cls_name: <{longest_cls_name}} - {method_name: <{longest_method_name}} - {i}")
            choices[i] = f"{file_path}:{cls_name}.{method_name}"
    test_path = choices[int(input("Please choose a test"))]
    test_str = f"nosetests -sx --nologcapture {test_path}"
    os.system(f"echo '{test_str}' | pbcopy")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Main script", epilog="Example usage: python show_tests.py file_path"
    )
    parser.add_argument("file_path", type=str)
    args = parser.parse_args()

    main(args)
