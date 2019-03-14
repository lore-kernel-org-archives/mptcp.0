Content-Type: multipart/mixed; boundary="===============8746518196544219980=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 14th of March 2019
Date: Thu, 14 Mar 2019 18:02:04 +0100
Message-ID: <788d729b-1665-745d-97f1-21923387c708@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1030

--===============8746518196544219980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 43th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple), Paolo and Davide (Red Hat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



multipath-tcp.org:
    - new fixes have been merged (by Christoph and Benjamin)
    - new sync with upstream v4.14 and v4.9 stable
    - new releases:
        - https://github.com/multipath-tcp/mptcp/releases/tag/v0.94.3
        - https://github.com/multipath-tcp/mptcp/releases/tag/v0.93.4



RFC6824bis:
    - Christoph just got the approval to publish modifications to
support this v1 in mptcp_trunk
    - should be safe in term of patent (see previous meetings about that)
    - Mat will consult with someone regarding patent-related issues



More selftests by Paolo:
    - https://lists.01.org/pipermail/mptcp/2019-March/001028.html
    - changes on top of Florian's tests
    - This expands a bit the existing tests checking for any
{[mp]tcp,subflow} <->{[mp]tcp,subflow} pairs.
    - Mat: will add this on top of the current patch-set in review



Questions about the code and where to ask them:
    - Gerrithub is ideal if the code is in review but email is fine if
Gerrithub is not possible for you
    - if you have an account, feel free to share it with Matth to add it
in the dev group (ability to give +2 but also to be able to add
everybody in cc)



Mat:
    - working on the wiki to improve the doc (update)
    - will send a notification when it is ready



Next meeting:
    - We propose *NOT* to have it next week due to Netdev 0x13 but the
*week after*, on Thursday, the 28th of March.
    - Still *NOT* the usual time if you are in Europe: 16:00 UTC (9am
PDT, 5pm CET)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190328



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

--===============8746518196544219980==--
