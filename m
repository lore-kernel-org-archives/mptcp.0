Content-Type: multipart/mixed; boundary="===============0096343264950781946=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 20th of August 2018 (fwd)
Date: Mon, 20 Aug 2018 16:09:49 -0700
Message-ID: <alpine.OSX.2.21.1808201608570.6886@sriyenga-mobl.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 705

--===============0096343264950781946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



---------- Forwarded message ----------
From: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Hello,

We just had our 18th meeting with Mat, (Intel OTC), Christoph (Apple),
Hoang (UCL) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



New commits on mptcp_trunk:
     - surprising we didn't see that before
     - (that could have impact when accepting a lot of new connections,
maybe we could act on the wrong sk)
     - proposed to mptcp_net-next



LPC:
     - not selected
     - but without any reason (many people asked to participate)
     - but anyway, we should continue working on the patches and send stuff.
     - if possible, that could be nice to participate and meet Eric and
David to talk about the new design. (but they will certainly want to see
code)



Design:
     - might be good at some points to send RFC for the design, now they
know what we are trying to do.
     - but Mat is also close to have a version meeting the design we
agreed last time



Next steps:
     - Mat: update prototype
     - Peter: working on MP_JOIN stuff + later managing non-DSS options
     - Ossama: more debugging on userspace code
     - Christoph: bug fixes
     - Matth: use recent kernel and maybe mptcp_net-next with our
test-suite. + update netlink code after that.



Next meeting:
     - We propose to have it back on Thursday, the 30th of August. Usual
time: 9am PDT - 16:00 UTC (9am PDT, 6pm CEST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20180830



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

--===============0096343264950781946==--
