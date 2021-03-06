#!/usr/bin/Rscript
# Script to generate graphs for Tokyo, using csv exported by Sqlite job.

attend <- read.csv("attend.csv")
attend$attend
postscript('attend.eps')
plot(filter(attend$attend, rep(1/12,12), sides=1),
  type='s',
  xlab='nth Tokyo Area Debian Meeting',
  ylab='number of attendees (12m MA)',
  ylim=range(0,20))
dev.off()
attend$prework
postscript('prework.eps')
plot(filter(attend$prework, rep(1/12,12), sides=1),
  type='s',
  xlab='nth Tokyo Area Debian Meeting',
  ylab='number of prework (12m MA)',
  ylim=range(0,20))
dev.off()


