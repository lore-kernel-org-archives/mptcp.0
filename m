Content-Type: multipart/mixed; boundary="===============4142537104343972364=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 20th of August 2018
Date: Thu, 30 Aug 2018 18:27:03 +0200
Message-ID: <e51be516-66cf-bc84-622d-9b2f291749d1@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 710

--===============4142537104343972364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 19th meeting with Mat, (Intel OTC), Christoph (Apple)
and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Design:
    - it's moving good (by Mat), now using the err queue
    - Cloning skbs before putting in the receive queue still prevents
coalescing
    - recvmsg code is now better organized for multiple subflows
    - still need to review the code, clean it and wait for Peter to be
back (next week)
    - next step: transmit path, sending ADD_ADDR



mptcp_net-next:
    - no conflict but buids failure, ongoing work
    - still need to add lockless subflows support



Next steps:
    - same as last week.



Next meeting:
    - We propose to have it on Thursday again, the 6th of September.
Usual time: 9am PDT - 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20180906



Feel free to comment on these points and propose new ones for the next
meeting!



Talk to you in two weeks,
Matthieu

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============4142537104343972364==--
