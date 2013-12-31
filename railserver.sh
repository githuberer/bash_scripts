#!/usr/bin/env bash

param=$1
port=3001
pid=$(ps -ef |awk '{ if ($0 ~ "rails server -p '$port'" && $0 !~ "awk") print $2}')

[[ $# = 1 ]] ||\
  {
    echo "param error!!!"
    exit
  }


start()
{
  echo "start..."
  nohup rails server -p $port &> railserver.log &
}


stop()
{
  echo "stop..."
  kill -9 $pid
}

case $param in
  status)
    echo "Rails server port:$port <==> Pid:$pid"
    ;;
  start)
  [[ -z $pid ]] && start
    ;;
  stop)
  [[ -z $pid ]] || stop
    ;;
  restart)
    stop
    sleep 2
    start
    ;;
  *)
    echo "param: start|stop|status"
esac



