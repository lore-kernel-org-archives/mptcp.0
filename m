Content-Type: multipart/mixed; boundary="===============1726599311269864116=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 10th of January 2019
Date: Thu, 10 Jan 2019 18:45:12 +0100
Message-ID: <859d101e-5fd3-3de8-578a-36081fcb3b04@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 972

--===============1726599311269864116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 34rd meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple), Florian (Redhat), Hoang (UCLouvain) and myself
(Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Mat did in December: mptcp_net-next/master sync with net-next:
    - one small conflict with his patch-set (also seen by Matthieu,
result is also on gerrit)
    - will do a sync when window opened on net-next



Gerrit:
    - proposition to send notifications when a change is created.
    - Matthieu: will have a look at that.



code activity:
    - Christoph added some patches on mptcp_trunk and backported it to
mptcp_net-next/master, straightforward.
    - Christoph is also working on another branch to remove even more
than what has been done in December.



netlink PM:
    - new versions (last is v5) have been sent on mptcp-dev ML if you
want more details
    -
https://sympa-2.sipr.ucl.ac.be/sympa/arc/mptcp-dev/2019-01/msg00039.html
    - reviews are welcomed
    - after this, we will branch to have a new stable (mptcp_v0.95) and
sync mptcp_trunk with the next versions



netdev:
    - interesting talk:
https://netdevconf.org/0x13/session.html?tcp-analytics
    - Matthieu: will ask to go to the conference
    - Hoang as well
    - Mat will check (might have to decide with Linux Plumber where
maybe more people from here could join)
    - Linux plumber in September (Portugal)



Beyond socket options: making the Linux TCP stack truly extensible:
    - Hoang shared this paper:
https://www.arxiv-vanity.com/papers/1901.01863/
    - Repo: https://github.com/hoang-tranviet/tcp-options-bpf
    - allow to add TCP option from eBPF with a very small overhead (1-2%
per packet)
    - there are some limitations with eBPF but it also demonstrates what
we can do with it!
    - eBPF is definitively something to look at for some tasks, e.g. the
scheduler (linked to http://progmp.net/)



Next meeting:
    - We propose to have the next one on Thursday, the 17th of January.
    - Usual time: 17:00 UTC (9am PST, 6pm CET)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190117



Feel free to comment on these points and propose new ones for the next
meeting!


Talk to you next week,
Matthieu
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1726599311269864116==--
