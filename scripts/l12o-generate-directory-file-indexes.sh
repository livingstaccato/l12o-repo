#!/bin/bash

find /repo -type d -exec /scripts/_l12o_generate_index_page.sh {} ';'
