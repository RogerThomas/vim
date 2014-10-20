#!/usr/bin/env python
"""
Changes output of the nose testing tool into format easily parsable
by a machine.

Originally written by Max Ischenko.
"""

from setuptools import setup

setup(
    name="nose_machineout",
    version="0.3-rc1",
    description=__doc__.replace('\n', ' ').strip(),
    author="Mike Crute",
    author_email="mcrute@gmail.com",
    url="http://nose-machineout.googlecode.com",
    install_requires = [
        "nose>=0.10",
    ],
    license="BSD",
    py_modules=['machineout', 'test_machineout'],
    entry_points = {
        'nose.plugins.0.10': [
            'machineout = machineout:NoseMachineReadableOutput'
        ],
    },
    classifiers=[
        'Development Status :: 4 - Beta',
        'Environment :: Console',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: Python Software Foundation License',
        'Operating System :: POSIX',
        'Programming Language :: Python',
        'Topic :: Software Development',
    ],
    keywords='test unittest nose',
    test_suite = 'nose.collector')
