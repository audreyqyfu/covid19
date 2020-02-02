# Wuhan New Coronavirus Outbreak Data and Analysis
Wuhan new coronavirus outbreak has become a global health emergency.  This repo shares statistics of this outbreak in mainland China.  Data are extracted from daily briefings of China's National Health Commission (http://www.nhc.gov.cn/yjb/pqt/new_list.shtml), Hubei Province Health Commission (through real-time updates via https://news.163.com/), and Wuhan Health Commission (http://www.nhc.gov.cn/yjb/pqt/new_list.shtml).  Counts for each day are cumulative counts at 24:00 of that day.

Data files are updated daily.  Counts in Wuhan before Jan 16, 2020 are unreliable.

Fields in data file are explained below.  Not all fields are reported by all the sources; missing data are indicated by _NA_.
- _Cases_: confimed cases;
- _Deaths_: deaths;
- _Recovered_: individuals that have beeen discharged from hospital;
- _Severe_: severe cases.  News briefings from Hubei Province Health Commission further separate these cases into _Severe_ and _Very Severe_, which are lumped together in the data files here;

- _Suspected_: cases that are waiting for diagnostic results;
- _CloseContact_: individuals that have been in close contact with a confirmed case;
- _UnderObservation_: among _CloseContact_, individuals that are under observation by medical professionals;
- _NoLongerObserved_: _CloseContact_ - _UnderObservation_; individuals who were once in close contact with a confirmed case but are no longer suspected to have the infection.
