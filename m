Content-Type: multipart/mixed; boundary="===============6695082865913735111=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 28th of February 2019
Date: Thu, 28 Feb 2019 18:49:15 +0100
Message-ID: <c39645df-33d8-8dba-f55b-1420c9136e3d@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1022

--===============6695082865913735111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 41th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple), Florian (Red Hat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



new MPTCP design:
    - New RFCv7:
      * Added Florian's commits for kselftest/etc
      * Fixed read length bug that Florian noted
      * Fixed compilation without CONFIG_IPV6
      * Fixed DSS re-parsing warning when reading partial skb
      * ULP changes are not part of this patch-set (yet)
      * note: what is on Gerrit is slightly different (sync with latest
net-next)
    - Reviews are welcomed!
    -
https://review.gerrithub.io/q/project:multipath-tcp%252Fmptcp_net-next+bran=
ch:t%252Fupstream+status:open
    - git fetch "https://github.com/multipath-tcp/mptcp_net-next"
refs/changes/74/446474/1 && git checkout FETCH_HEAD
    -
https://github.com/multipath-tcp/mptcp_net-next/commit/674546902f011e4b6eab=
8db3c0bf14dd96809e42
    -
https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/log/?h=
=3Dmptcp-proposal



Commits for upstream:
    - do we need to add Reviewed-by/Acked-by/Signed-off-by?
        - not for the moment
        - in topic: only remove ChangeId ref
        - in cover letter: we will see later how to mention that this
patch-set is supported by different people from different companies.


    - now a few commits in "export" branch
        - https://github.com/multipath-tcp/mptcp_net-next/commits/export


    - new 'for-review' branch:
        - https://github.com/multipath-tcp/mptcp_net-next/commits/for-review
        - if you use TopGit internally to manage your different commits
you want to integrate on top of other MPTCP changes (on top of
t/upstream or export), you can now base your tree on top of 'for-review'
branch (you can also use it as target for 'git-review' or keep
't/upstream', that will be the same from a Gerrit point of view)
        - this new branch 'for-review' is like 't/upstream' (top of the
tree) but without TopGit files: Gerrit will see when changes are
integrated in the tree (not like 'export') because Change-Id are
preserved and mark changes as merged automatically when it is in the
tree. Also with this new branch, you don't have any .top* files on this
branch.

        - in other words:
            - use this branch as base and target:
                git checkout -b <new_feature> for-review
                (...)
                git commit -s
                git review for-review
            - note for Mat: for your existing patch-set: continue to use
't/upstream' as target not to create new changes. That's OK for Gerrit.
But you can rebase your patch-set on top of 'for-review'


    - branches in our repo: =E2=86=92
https://github.com/multipath-tcp/mptcp_net-next/wiki/Gerrit#different-branc=
hes-on-mptcp_net-next-repo
        - master =E2=86=92 like mptcp_trunk but with less features. (still =
sync?)
        - net-next =E2=86=92 sync of Dave's net-next
        - t/upstream =E2=86=92 top of the tree containing our changes on to=
p of
net-next
        - t/* =E2=86=92 other topic: correspond to one commit we want to se=
nd
upstream (.topdeps: parent topic(s) ; .topmsg: commit message)
        - export =E2=86=92 an export of the tree on top of net-next: what we
should send upstream
        - for-review =E2=86=92 same as t/upstream but without TopGit files:=
 can
be use as a base and target for your reviews



Syzkaller for MPTCP running now on v0.94:
    - https://github.com/google/syzkaller
    - Running on Christoph side
    - really easy to setup
    - would be nice to have it for MPTCP net-next
    - good to restrict to net syscall
    - for net-next, we just need to ask to create MPTCP socket
    - MPTCP in syscall is already there!
    - new patches will come!



Papers related to MPTCP:
    - Fixed-Mobile Convergence in the 5G era: From Hybrid Access to
Converged Core =E2=86=92 https://nms.kcl.ac.uk/toktam.mahmoodi/files/FMC-Ne=
twork.pdf



Netdev 0x13:
    - Florian will be there (and talk about Skb Meta Data Extensions
https://www.netdevconf.org/0x13/session.html?skb-meta-data-extensions )
    - Matthieu will be there (with 2 other colleagues)
    - Peter will check if he can go
    - Could be nice to meet each others at LPC 2019 (September 9-11,
Lisbon, Portugal)



multipath-tcp:
    - mptcp_v0.94 branch has been recently updated (sync with upstream)



Next meeting:
    - We propose to have the next one on Thursday, the 7th of March.
    - Usual time: 17:00 UTC (9am PST, 6pm CET)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190307



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

--===============6695082865913735111==--
