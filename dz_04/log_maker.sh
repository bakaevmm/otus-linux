#!/bin/bash

sort -R ./source_log | head -100  >> ./access.log
