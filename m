Content-Type: multipart/mixed; boundary="===============2791676636054226057=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 6th of September 2018
Date: Thu, 06 Sep 2018 18:47:40 +0200
Message-ID: <4f3b0e5d-aab5-63e2-3616-c3deca6d196d@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 712

--===============2791676636054226057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 20th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph and Vishnu Rangayyan (Apple) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Vishnu:
    - Vishnu is joining this MPTCP upstreaming project.
    - He is working at Apple with Christoph.
    - He has good experience with Linux kernel development.
    - Welcome Vishnu!



New fixes in mptcp_trunk:
    - one important fix from Christoph if you are using tcp + splice
    - another fix from Patrick (Tessares), theoretical issue we could
have in >=3Dv93, could more happen before with the previous ofoqueue
    - there were some updates in stable branches
    - Christoph will do a new release for v0.94 "soon"
    - Matthieu will do one for v0.93 after the end of his validation



mptcp_net-next:
    - has been updated last week by Mat
    - minor conflicts, nothing big, straightforward: that's why there
were no email on the ML.



Mat and Peter's patches:
    - Should be ready soon (now using err queue, see last week reports
for more details)
    - Need internal reviews first, will be shared on the ML as soon as
possible
    - Next: transmit side =E2=86=92 implement Eric's proposition
    - And other bug-fixes will be included



Christoph:
    - preparing fixes for mptcp_trunk
    - start allowing enabled MPTCP on other services:
https://github.com/apache/trafficserver/pull/4203
    - might be good to do that for other services!
    - but we will certainly need a way to detect which MPTCP we have
("old" or upstream or "upstream > XX").



Meeting:
    - Use Webex next time, to try if it is better than Talky (we
sometimes have disconnections, webRTC not well supported by some
browsers / stability / we need recent versions of the browser)
    - It is possible to call a number with WebEx
    - Note: I just thought about that but we could also use Google Meet,
it is now working on Firefox as well. The technology is newer (maybe
better for the quality, feature, video, etc.). There is a web
application and a phone number (only in the US)



Next steps:
    - same as last week.



Next meeting:
    - We propose to have it on Thursday again, the 13th of September.
Usual time: 9am PDT - 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20180913



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

--===============2791676636054226057==--
