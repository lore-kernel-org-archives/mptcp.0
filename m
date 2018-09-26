Content-Type: multipart/mixed; boundary="===============7806986649351409178=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 26th of September 2018
Date: Wed, 26 Sep 2018 19:05:27 +0200
Message-ID: <e3c98c44-842c-2f11-c82a-72e282b23428@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 757

--===============7806986649351409178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 23th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



current MPTCP:
    - v0.94.1 has been released by Christoph
    - v0.93.2 will be released "soon" by Matthieu
    - Matth: figure out where to upload the new binaries
    - To build RPM/DEB: https://github.com/multipath-tcp/mptcp-scripts



Test suite/environment:
    - Matth is proposing to add MPTCP support in the official Packetdrill
    - But he is looking for collaborations not to do that alone :)
    - Matth will contact Packetdrill maintainer to see if they would
accept this while MPTCP is not upstream



Mat:
    - implemented Eric's suggestion for skb private data
    - we need 3 pointers for the destructor, constructor, mem
    - looks well integrated and not too costly (copy of pointers)
    - if 3 pointers are too much, would be easy to adapt during the review



Christoph:
    - continue working on "cleaning" mptcp_net-next (removing features
and optimisations)



Ossama:
    - the daemon looks good now!
    - also need to look at legal issues of upstreaming stuff



Peter:
    - continue working on the patch-set. Cleaning months of work.



Matth:
    - finished testing the v4.9
    - will release the v0.93.2.
    - Going to finish the test of the v4.14 and mptcp_trunk in //
    - after that, will be able to find bugs and update Netlink PM patch



Next meeting:
    - We propose to have it back on Thursday this time, the 4th of
October. Usual time: 9am PDT - 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20181004



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

--===============7806986649351409178==--
