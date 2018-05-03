Content-Type: multipart/mixed; boundary="===============8118603397854784977=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 3rd of May 2018
Date: Thu, 03 May 2018 18:51:52 +0200
Message-ID: <321a352b-41fd-2d4e-a357-174e387cf411@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 602

--===============8118603397854784977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 8th meeting with Mat, Peter, Ossama (Intel OTC),
Christoph (Apple) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Next Thursday:
    - Some people will not be able to participate next week, we will see
the day before if we need to have one next week.



netdevconf:
    - tutorial proposal has been sent, waiting for an answer.
    - Who will be there:
        - Mat needs to wait for the beginning of June before getting an
approval
        - Mat and / or Peter will try to participate, they hope having
at least one of them there, maybe the 2 of them!
        - Christoph will be there and he will officially represent Apple
        - Matthieu still needs the approval, should get an answer before
the next meeting
    - If we are accepted, we need to send slides before the end of June.
Something we need to keep in mind. Ref:
https://www.netdevconf.org/0x12/submit-proposal.html



subflow lockless patches (from Christoph):
    - merged in mptcp_trunk
    - Christoph is looking at proposing them to mptcp_net-next but he is
currently facing issues with the establishment of subflows, maybe not
due to these patches, maybe due to the previous cleaning or a merge,
someone needs to check that.



mptcp_net-next:
    - Christoph is looking at doing more cleaning of features
(simplifications) but only in this repo, not mptcp_trunk because it
seems it is going to reduce performances.
    - We will certainly have to cherry-pick new bug-fixes from
mptcp_trunk, will be tricky to merge these branches once we add new
feature in mptcp_trunk
    - We could only support the v1 (MPTCP spec) in net-next. But
mptcp_trunk doesn't fully support v1 yet, we hope having this support soon.



Mat and Peter patches:
    - First step is to have it working on top of net-next
    - Then switch to mptcp_net-next
    - Note that it is not possible to establish more subflows for the
moment so this part needs to be fixed first



Next steps:
    - All: We hope to get an answer for Netdevconf before the next
meeting, nothing else we can do about that
    - Mat & Peter: looking at the v2 of their patches
    - Mat: sync mptcp_net-next / look at Christoph's patches to reduce
footprint in mptcp_net-next
    - Christoph: work on the input path in mptcp_net-next: consolidate
the processing, window handling would be a bit tricky, maybe we can
sacrifice some perfs to simplify the design =E2=86=92 how much we can re-de=
sign
that: to be discussed when the patches or an early design will be proposed
    - Peter: Will look at having additional subflows in net-next
    - Ossama: look at a userspace Open-Source code to use the
Open-Source Netlink PM
    - Matthieu: propose a v2 for the PM Netlink, should not change the
API, good point for Ossama.
    - As usual, update the wiki if there are new stuffs to put in!



Next meeting:
    - proposition: the 17th of May except if there are stuff to discuss
on the 10th of May. Usual time 9am PDT - 16:00 UTC (9am PDT, 6pm CEST)
    - open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20180510
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20180517



Feel free to comment these points and propose new ones for the next meeting!



Talk to you in two weeks,
Matthieu
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

-- =



DISCLAIMER.
This email and any files transmitted with it are confidential =

and intended solely for the use of the individual or entity to whom they =

are addressed. If you have received this email in error please notify the =

system manager. This message contains confidential information and is =

intended only for the individual named. If you are not the named addressee =

you should not disseminate, distribute or copy this e-mail. Please notify =

the sender immediately by e-mail if you have received this e-mail by =

mistake and delete this e-mail from your system. If you are not the =

intended recipient you are notified that disclosing, copying, distributing =

or taking any action in reliance on the contents of this information is =

strictly prohibited.

--===============8118603397854784977==--
