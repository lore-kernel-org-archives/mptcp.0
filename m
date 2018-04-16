Content-Type: multipart/mixed; boundary="===============5779344416913064139=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 16th of April 2018
Date: Mon, 16 Apr 2018 19:18:36 +0200
Message-ID: <021c8818-f78d-5e02-9a76-aaa715ac39c8@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 540

--===============5779344416913064139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 6th meeting with Mat (Intel OTC), Christoph (Apple) and =

myself (Tessares).

Thanks again for this new good meeting!

Please note that this meeting was exceptionally on Monday because it was =

not possible to have it at the end of last week nor at the end of this =

week. We propose to have the next meeting next Thursday (26th of April). =

Feel free to propose other dates if needed.



Here are the minutes of the meeting:



Progress from last week:
     - as expected, many people off or busy with other stuffs, not so =

much new to share.
     - Mat has updated the mptcp_net-net repo (see below)
     - Mat is dealing with issue on the client side (version from =

github.com/multipath-tcp/mptcp) when using it with a modified server =

(having his patches). More discussions will continue later with a pcap.
     - Matthieu finished the review of Christoph's patches (Note for =

myself: not the review of Christoph's Paasch, that's different...). Do =

not hesitate to review the two last commits.



mptcp_net-next merge:
     - Mat started the work: =

https://github.com/multipath-tcp/mptcp_net-next/
     - one fix has been done (related to checksum and gso), seems OK, =

feel free to comment if not: =

https://github.com/multipath-tcp/mptcp_net-next/commit/6ba7f217d3a69a88152a=
3fbee8b9dfc47c77bf4d
     - Christoph will try to launch some tests using this branch
     - Could be good to merge with net-next once per week to reduce the =

amount of conflicts we need to fix in once
     - Could be good to have two branches:
         - one close to net-next and the current mptcp_trunk
         - one where we have a minimal implementation =E2=86=92 focus on th=
e =

client, simple version.



netdevconf:
     - tutorial ideas: more should come. Feel free to propose any idea.
     - Matthieu is trying to get more ideas
     - Matthieu: will start a dedicated discussion on the ML (should do =

that on Wednesday (or short after) after having collected more ideas)



topgit to manage patch sets, maybe not needed now, maybe later
     - looks like a good tool for what we have to do
     - could be good to have a look:
         https://github.com/mackyle/topgit (new version -- recommended)
         https://github.com/greenrd/topgit (original version)
     - Matthieu has some experiences with it if you need some support.
     - Feel free to try it, instructions are in the README



LPC:
     - From Mat: still not clear what it will be.
     - it is possible that they will have more miniconferences and they =

will prefer that
     - but will be a lot of people there (davem), very interesting to =

participate, get feedback, help, advises, etc.
     - the networking track submission deadline for LPC is July 11: =

http://vger.kernel.org/lpc-networking.html =E2=86=92 350 word proposal for =
a 40 =

minute talk plus 2-10 page paper.



Next steps:
     - Mat: wiki update: with links, etc. (could be good, when the base =

is there, to have some help to maintain that, at least reporting =

outdated links, etc.
     - Christoph: will first look at the lockless patches then maybe =

look at the net-next branch
     - Peter will also look at mptcp-net-next branch + continue to work =

on the patch-set with Mat
     - Matthieu: update Netlink PM patches.



Next meeting:
     - proposition: the 26th of April at 9am PDT - 16:00 UTC (9am PDT, =

6pm CEST)
     - open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20180426



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

--===============5779344416913064139==--
