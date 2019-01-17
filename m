Content-Type: multipart/mixed; boundary="===============3841526801593497588=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 17th of January 2019
Date: Thu, 17 Jan 2019 19:06:01 +0100
Message-ID: <e1446aef-b35c-849d-4057-3e08777f566b@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 978

--===============3841526801593497588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 35th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Netdev:
    - New interesting talk to follow: (by Florian)
https://www.netdevconf.org/0x13/session.html?skb-meta-data-extensions



GSOC:
    - https://lwn.net/Articles/776816/rss
    - hard to know what we can ask students to do now, we will need time
to "bootstrap" this student with unclear objectives (for the moment)
    - maybe easier when we will have a base and a clear list of features
that need to be added (next year then?)



Gerrit:
    - Gerrit now sends notifications when new changes are created (we
can also send notifications when there is a new version of a published
patch-set, for each comment, when it is merged, only for some branches,
etc. but people can also subscribe when they want to get all
notifications or configure their profile =E2=86=92 or we could also setup an
extra ML just for that? There are other solutions for those who want
more notifications :) )
    - if you want to use gerrithub, simply use:
        - git review t/upstream =E2=86=92 goal: integrate these modificatio=
ns in
the tree
        - git review net-next =E2=86=92 goal: directly propose this change =
upstream
        - git review <part_of_the_tree> =E2=86=92 fix a topic of the tree



CI job:
    - for the moment: only a mirror of net-next (base of the tree) =E2=86=
=92
easy to propose new Gerrit Changes that would go directly to net-next
(upstream) without going in our TopGit tree
    - proposition: update the TopGit tree (for the moment empty) if no
error during merge/compilation/tests =E2=86=92 Matthieu will look at that.



Netlink Patch:
    - we might want to remove the subflow_error event =E2=86=92 in case of
error, we cannot establish a new subflow immediately anyway, we need to
wait for the "close" event. =E2=86=92 Matth will look at that
    - Christoph has a fix when compiling it as a module (thx!)
    - Ossama & Mat hasn't compared netlink APIs in detail yet
    - could be nice to have some numbers (perf) for a server.
      =E2=86=92 see the section 4.5:
https://www.tessares.net/wp-content/uploads/2016/06/SMAPP-Towards-Smart-Mul=
tipath-TCP-enabled-APPlications.pdf



PM:
    - for the server side, it might be good to have an eBPF "version",
this PM can be less "smart" (less interactions with other stuff in
userspace) but more powerful to do that directly in the kernel than
having to always announce the same address, etc.



mptcp_net-next/master:
    - Mat is looking at updating it ; after the merge, when
disconnecting the app, le PM tried to re-established the subflows, strange
    - v5 is then coming in our repo :)



Mat:
    - also looking at the data-fin case and updating the patch-set



Next meeting:
    - We propose to have the next one on Thursday, the 24th of January.
    - Usual time: 17:00 UTC (9am PST, 6pm CET)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190124



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

--===============3841526801593497588==--
