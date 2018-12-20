Content-Type: multipart/mixed; boundary="===============8185642213068659931=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 20th of December 2018
Date: Thu, 20 Dec 2018 18:39:30 +0100
Message-ID: <f6a1bda7-b5a6-2b77-9f3a-4f6dce3ab662@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 953

--===============8185642213068659931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 33rd meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple), Florian (Redhat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Florian's patch-set: v2 had been sent and approved \o/
    - https://lwn.net/ml/netdev/20181218161527.2760-1-fw(a)strlen.de/
    - https://git.breakpoint.cc/cgit/fw/net-next.git/log/?h=3Dskb_ext_both_=
07
    -
https://review.gerrithub.io/q/topic:%22fwestphal-skb_ext_both_07%22+(status=
:open%20OR%20status:merged)
    - one colleague found a problem but maybe not a problem
    - and tiny problems, going to be fixed soon.



- Mat and Peter's patch-set:
    - now based on Florian's one, using the new feature
    - Mat will send a new version on the ML



- tcp option framework (from last year, proposed by Mat and Christoph):
    - still too many indirect calls there
    - we can live without it.



- Christoph's patch-set:
    - updated to a v3, one remaining question:
https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/436377#message=
-e0c5bccc5f6e54763b58b0f2068bce70f5c8419f
    - will check if v4 is needed depending on =E2=86=91
    - he is still able to test everything
    - after that, Christoph will have a look at the changes in the skbuff.



- Gerrit:
    - Mat & Peter's patch-set added in Gerrit:
https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/437404/3
    - All changes:
https://review.gerrithub.io/q/project:multipath-tcp%252Fmptcp_net-next+stat=
us:open
    - Christoph's patch-set updated in Gerrit:
        -
https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/436378/1..2
        -
https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/436386/1..2
    - TopGit tree also setup: Matth can manage the tree
    - Mat (and Matthieu) set as owner of the project (ability to change
rights). Do you prefer having protections or not?
    - Feel free to try ;-)
    - We should certainly often update net-next =E2=86=92 Matth can setup a=
 CI
project to pull net-next and update the tree
    - Mat: it is also interesting to see the changes that have been made
    - Matth: can be interesting to create this CI project but including
a build + test before pushing the merge



- random:
    - http://blog.multipath-tcp.org/blog/html/archive.html
    - one article per day in December about MPTCP!
    - by Olivier Bonaventure



Userspace:
    - got approval at Intel, still need to check how the code will be
shared (repository) + review
    - Matth: still working on the netlink PM in the kernel



5G:
    - MPTCP is part of the spec! As a proxy.
    - we might got more interest!
    - previous version but still valid:
http://www.3gpp.org/ftp/tsg_sa/WG2_Arch/TSGS2_127_Sanya/Docs/S2-183622.zip



Next meeting:
    - We propose to skip the two next ones due to holiday period in many
countries (OK, at least for us in the US, Belgium and Germany :-) ). We
propose to have the next one on Thursday, the 10th of January.
    - Usual time: 17:00 UTC (9am PST, 6pm CET)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190110



Feel free to comment on these points and propose new ones for the next
meeting!


Enjoy Christmas and Happy New Year,
Talk to you next year,
Matthieu
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============8185642213068659931==--
