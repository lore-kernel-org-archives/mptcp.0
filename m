Content-Type: multipart/mixed; boundary="===============6581851836016248185=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 24th of October 2019
Date: Fri, 25 Oct 2019 09:53:12 +0200
Message-ID: <39e52f1c-32fb-f869-f335-eb4db000860f@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2309

--===============6581851836016248185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 72nd meeting with Mat, Peter and Ossama (Intel =

OTC), Paolo, Florian and Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
     - mptcp: recvmsg refactor follow-up:
         - by Paolo
         - fix tests
         - Accepted by Matth & Mat

     - Fix issues in prerequisite [IPv6] patches:
         - by Peter
         - 3 patches: 1 has been applied, accepted by Matth



Pending patches:
     - mptcp: switch mptcp_poll to use parent sock wait queue:
         - include: mptcp: sendmsg scheduler skeleton
         - include: mptcp_poll should not block on each subflow:
         - by Florian
         - v2
         - Accepted by Paolo
         - *Waiting for application*

     - selftests: mptcp: increase test coverage:
         - include: selftests: fixes and improvements
         - include: prepare for mptcp ipv6 support
         - by Florian
         - v3 sent + 1 new one
         - *Waiting for review*

     - mptcp: Add DATA_FIN transmission and handling:
         - by Mat
         - RFC
         - Commented by Paolo, Christoph
         - new version expected

     - IPv6 support:
         - by Peter
         - RFC
         - Commented by Paolo, Matth
         - new version expected

     - Fix issues in prerequisite [IPv6] patches:
         - by Peter
         - 3 patches: 2 are left on review
         - Paolo raised a question about IPv4 mapped in IPv6: add the =

support for later?
         - new version expected

     - selftests:mptcp: increase timeout:
         - by Matth
         - v2
         - *Waiting for review*

     - Fix bug processing options:
         - by Peter
         - *Waiting for review*




Remaining items for the initial submission: Planning:
     - Part 1 (mainly TCP changes, will be sent with Part 2):
         - MAINTAINERS file

     - Part 2 (minimum set for MPTCP, up to KSelftests, one subflow):
         - MPTCPv1 support
         - opti in TCP options?
         - Send DATA_FIN, no corner cases

     - Part 3 (after the KSelftests, to be sent ideally before the end =

of the year)
         - Full DATA_FIN support
         - Shared recv window
         - Active backup support



Remaining items for the initial submission: Update:
     - IPv6 support =E2=86=92 part 2:
         - Peter is working on a v2

     - MPTCP v1 support =E2=86=92 part 2:
         - Paolo started to look at the RFC to support Christoph
         - Christoph will be the submitter of the patch
         - *Matth*: publish a branch with mptcp.org + MPTCPv1
         - is it OK to have v0 then switch to v1 in the same series?
         - maybe better to do the squashing to have a clearer code =

(hoping the v1 simplify a bit some parts)
         - will check if we squash or not when we have the code

     - DATA_FIN =E2=86=92 part 3 (after kselftests):
         - Mat is working on it
         - working on top of the recent changes done and the =

mptcp_rcvmesg refactor
         - trying to list the different corner cases (e.g. this is the =

last packet and it is dropped)
         - maybe we can have only the sending part for the moment =

without the corner cases in the part 2 (before kselftests, after TCP)
         - Mat will look at that perspective

     - Shared recv window =E2=86=92 part 3 (after kselftests, OK because we=
 only =

support one subflow before that):
         - work to be done

     - Active backup support =E2=86=92 part 3 (after kselftests) or 4 (extr=
a):
         - Paolo is working on it
         - receive part is done
         - send side is handle by Florian
         - found one issue with MP_JOIN

     - optimisation of options in TCP "struct mptcp_options_received":
         - Peter has a patch to share

     - MAINTAINERS file



timeout in selftest:
     - we will try to have default "series" around ~45seconds



IPv4 mapped in IPv6:
     - add the support for later
     - only support v4 only and v6 only



Feedback from netdev:
     - nope :'(
     - could be good to send a message to the list, explaining with =

other words what we have sent, what it would be useful for us
     - it is likely possible that we will not get any replies if we =

don't ask or send something else
     - Mat was asking if it could help if someone else was sending the =

patches? Maybe just unlucky: reviewers were maybe busy



Patchwork:
     - we need username
     - Mat will check with Peter which one to use
     - *Matth* will send the list to Patchwork maintainers
     - Mat added their email in the subscribers list



Netdev?:
     - =

https://netdevconf.info/0x14/news.html?netdev-0x14-call-for-submissions
     - In Vancouver
     - close to Seattle
     - Submission: around January



Next meeting:
     - We propose to have it next Thursday, the 31st of October.
     - *NOT* the usual time if you are going to change the clock this =

weekend: 16:00 UTC (9am PDT, *5pm CET*)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20191031



Feel free to comment on these points and propose new ones for the next
meeting!


Talk to you next week,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6581851836016248185==--
