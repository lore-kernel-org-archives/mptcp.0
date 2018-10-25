Content-Type: multipart/mixed; boundary="===============7574866544952647578=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 25th of October 2018
Date: Thu, 25 Oct 2018 19:46:52 +0200
Message-ID: <5993d753-9925-b781-7a32-846cbb316d85@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 831

--===============7574866544952647578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 27th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



current MPTCP:
    - v0.93.2 finally released:
https://github.com/multipath-tcp/mptcp/releases/tag/v0.93.2
    - should be announced soon
    - scripts available to ease the build:
https://github.com/multipath-tcp/mptcp-scripts/pull/7



Mat:
    - continued to work on the v3 of the patch
    - did experimentation with TopGit
    - Podcast: Hosts are SDN-oriented, and may be more comfortable
talking about network infrastructure. We should be prepared to talk
about lower-layer considerations (like middleboxes and preserving TCP
options), as well as giving an overview of how MPTCP works.



Matthieu:
    - did a demo of TopGit: https://github.com/mackyle/topgit

      tg create + tg update + tg delete
      we didn't cover `tg remote origin --populate` + `tg push` yet

    - did a demo of Gerrit using 'git review':
https://review.gerrithub.io/#/c/multipath-tcp/mptcp_net-next/+/430835

      git checkout -b my_branch master
      (...) # work here
      git add -u <...>
      git commit -sm "foo"  # Change-Id has been added
      git review            # new Change created
      (...) # rework here according to the review
      git commit --amend    # Change-Id has not been modified
      git review            # Change 430835 has been updated

      It is possible to see only the change from v1 to v2, not only from
v0 (the base) to v2 (the final version):
https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/430835/1..2

      important note: if you want to rebase your change and do other
modifications, it is easier for the reviewers to first rebase it, send
the new version (with the WIP feature), then do the modifications after.
Otherwise rebase and modifications changes are "merged", the diff might
show other modifications from the rebase.

      Git review tool:
https://docs.openstack.org/infra/git-review/installation.html


    - Gerrit repo is available:
https://review.gerrithub.io/admin/projects/multipath-tcp/mptcp_net-next
      .gitreview file:

=3D=3D=3D=3D=3D=3D=3D

[gerrit]
host=3Dreview.gerrithub.io
port=3D29418
project=3Dmultipath-tcp/mptcp_net-next
defaultbranch=3Dmaster

=3D=3D=3D=3D=3D=3D=3D

    - You can be access to Gerrit via:
https://review.gerrithub.io/plugins/github-plugin/static/scope.html
      =E2=86=92 Choose "Reviewer" to only review work, "DEFAULT" to contrib=
ute.
    - Anybody can create Changes, I can add people in different groups,
change rules, etc.:
https://github.com/multipath-tcp/mptcp_net-next/commit/aead15fd5e245f28760c=
a80fa4edf096070d8981
    - Don't forget to subscribe to new Changes:
https://review.gerrithub.io/settings/#Notifications



Next meeting:
    - We didn't decide when to have the next meeting yet: we might skip
the one of next week if it is not needed or it could be the 1st of
November. Be careful with the time, it would still be at 16:00 UTC, 9am
PDT but 5pm CEST (it is no longer the summer in Europe, but still in the
US!)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20181101



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

--===============7574866544952647578==--
