#!/bin/bash
set -x

RAILS_ENV=production rake assets:precompile
exec rails s -e production -b 0.0.0.0
