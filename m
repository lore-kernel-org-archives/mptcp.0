Content-Type: multipart/mixed; boundary="===============2416639109260113512=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 13th of December 2018
Date: Thu, 06 Dec 2018 18:46:07 +0100
Message-ID: <aad094a2-77e2-126d-89cc-9845652bfaff@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 889

--===============2416639109260113512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 31st meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple), Florian (Redhat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



new version for Mat and Peter's patch-set:
    - for the review, we can focus on:
        - changes linked to the err queue:
            - number 16 =E2=86=92
https://lists.01.org/pipermail/mptcp/2018-November/000868.html
        - maybe other ways to deal with coalesce / collapse:
            - number 13 =E2=86=92
https://lists.01.org/pipermail/mptcp/2018-November/000865.html
        - note for number 13 from Christoph: what we want to do is
closed to what kTLS is doing, that could be "merged" in a generic function
        - note from Florian: tcp coalesce is maybe not considered as
part of the fast path as it should not normally happen =E2=86=92 might be O=
K to
add a generic way there
    - next version will be on top of Florian changes (skb extension:
change the API calls but the rest should be the same)



new patch-set from Christoph:
    - DSS checksum: not used in (big) deployments and not really working
in some conditions =E2=86=92 not a priority, better to remove it
    - thanks to that (not having the checksum), you could give data
quicker to userspace, you don't need the full mapping
    - for the review: nothing complex, it is more to agree on what to remove
    - new patch-set should come later to remove other stuffs, a bit more
complex.



Gerrit:
    - new wiki page available:
https://github.com/multipath-tcp/mptcp_net-next/wiki/Gerrit
        - Why Gerrit?
        - Setup Gerrit
        - Getting the notifications
        - Typical use-cases / workflow
    - example:
https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/436375/1
    - note:
        - the workflow is basically the same as before but instead of
using 'git send-email', 'git review' will be used.
        - to download a patch-set in a new branch: `git review -d 436386`



Florian:
    - had more time to work on his patch-set (skb extension). Tested
with ipset/bridge.
    - hopes to send a new version tomorrow



Next meeting:
    - We propose to have the next one on Thursday, the 13th of December.
    - Usual time: 17:00 UTC (9am PST, 6pm CET)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20181213



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

--===============2416639109260113512==--
