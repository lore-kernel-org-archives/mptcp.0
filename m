Content-Type: multipart/mixed; boundary="===============8225486698870998670=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 5th of April 2018
Date: Thu, 05 Apr 2018 19:12:20 +0200
Message-ID: <b4923308-ca9f-d98a-27ef-85431c2cd4a6@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 510

--===============8225486698870998670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 5th meeting with Mat, Peter and Ossama (Intel OTC), =

Christoph (Apple) and myself (Tessares).

Thanks again for this new good meeting!

Please note that there will be at least 2 people off next week and other =

busy with other activities. If we don't have urgent topics to discuss, =

we propose to delay the next meeting to the next Monday (16th of April). =

Please tell us if this change is not OK for you.



Here are the minutes of the meeting:



Netlink PM:
     - no more discussion this week apart from the one that loosing =

packets can happens but it is rare, that's fine for a PM
     - a v2 should arrive at some points (next week will be difficult).



Lockless and others patches:
     - review in progress (lockless)
     - review done (others)
     - anybody can join!



Wiki (Github) work:
     - in progress, Mat has some ideas
     - wiki can be edited by any Github user. Possible to revert changes =

if someone tries to screw it.



Branches on Github (multipath-tcp/mptcp):
     - keep mptcp_trunk "clean", following official Linux versions =E2=86=
=92 =

goal is at least to reach the next LTS (4.18?). We will see what to do =

after.
     - we still need a "usable" version, fully functional for both the =

client and server with almost the same performances while the "version =

for upstream" is still in progress in parallel
     - next stable version should then contain Netlink PM, lockless =

subflows, etc..
     - a new branch will be created (mptcp-net-next) following net-next.
     - all final patches shared, reviewed and accepted in MPTCP upstream =

ML would be integrated in this branch if they cannot be directly =

integrated upstream in net-next
     - Matthieu: I forgot to talk about 'topgit' -- a patch queue =

manager -- that can be useful for us later: =

https://github.com/greenrd/topgit & https://github.com/mackyle/topgit =E2=
=86=92 =

we can talk about that next time



netdevconf:
     - new ideas? =E2=86=92 not really
     - seems the tutorial is what is the best for us for now (because =

the maintainer will not be there)
     - Matthieu: will ask colleagues for ideas
     - for the tutorial, we mostly need a description of max 350 words: =

not too much to prepare before the 1st of May
     - we need to check Linux Plumbers participation guidelines (Mat =

will try to have a look): =

https://www.linuxplumbersconf.org/2017/participate.1.html#cfp & =

https://www.linuxplumbersconf.org/2018/participate/ (not ready)



Next steps:
     - Mat & Peter: continue the previous work linked to patches that =

have been shared ; Peter will be off next week.
     - Christoph: catch-up messages/patches in the ML, check the =

mptcp-net-next branch ; Christoph will be off next week.
     - Matthieu: continue to review lockless, look for ideas for netdevconf.



Next meeting:
     - proposition: the 16th of April at 9am PDT - 16:00 UTC (9am PDT, =

6pm CEST)
     - note that there will be at least 2 people off next week and other =

busy with other activities. If we don't have urgent topics to discuss, =

we propose to delay the next meeting to the next Monday (16th of April).
     - open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20180416



Feel free to comment these points and propose new ones for the next meeting!



Talk to you next week,
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

--===============8225486698870998670==--
