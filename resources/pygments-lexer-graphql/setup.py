#!/usr/bin/env python
# -*- coding: utf-8 -*-

from setuptools import setup, find_packages
import os


setup(
    name='pygments-lexer-graphql',
    version= '0.1',
    description='simple graphql lexer',
    packages=find_packages(),
    install_requires=['pygments >= 1.5'],
    entry_points="""
        [pygments.lexers]
        graphql=pygments_lexer_graphql:GraphQLLexer
    """,
    zip_safe=False,
)