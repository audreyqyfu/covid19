# Covid-19 Outbreak Data and Analysis
The Covid-19 outbreak has become a global health emergency.  This repo shares statistics of this outbreak in mainland China.  Data are extracted from daily briefings of China's National Health Commission (http://www.nhc.gov.cn/yjb/pqt/new_list.shtml), Hubei Province Health Commission (http://wjw.hubei.gov.cn/bmdt/ztzl/fkxxgzbdgrfyyq/xxfb/), and Wuhan Health Commission (http://www.nhc.gov.cn/yjb/pqt/new_list.shtml).  Counts for each day are cumulative or daily counts at 24:00 of that day (Beijing time).  A summary of the analysis is at https://twitter.com/audreyqyfu/status/1224078188839497728.

Data files are updated daily.  Counts in Wuhan before Jan 16, 2020 are unreliable.

Fields in data file are explained below.  Not all fields are reported by all the sources; missing data are indicated by _NA_.
- _Cases_: cumulative confimed cases;
- _Deaths_: cumulative deaths;
- _Recovered_: cumulative number of individuals that have beeen discharged from hospital;
- _Severe_: number of severe cases at the end of that day.  News briefings from Hubei Province Health Commission further separate these cases into _Severe_ and _Very Severe_, which are lumped together in the data files here;
- _Suspected_: daily cases that are waiting for diagnostic results;
- _CloseContact_: cumulative count of individuals that have been in close contact with a confirmed case;
- _UnderObservation_: daily count; among _CloseContact_, individuals that are under observation by medical professionals;
- _NoLongerObserved_: _CloseContact_ - _UnderObservation_; individuals who were once in close contact with a confirmed case but are no longer suspected to have the infection.  This field is no longer reported in the daily briefing since Feb 5, 2020;
- _CurrentlyConfirmed_: number of confirmed cases at the end of that day. 
