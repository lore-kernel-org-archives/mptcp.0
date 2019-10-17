Content-Type: multipart/mixed; boundary="===============0902886314025168252=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 17th of October 2019
Date: Thu, 17 Oct 2019 18:57:09 +0200
Message-ID: <8f4d601d-ab5a-b949-9e70-50d62b3b48ee@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2231

--===============0902886314025168252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Today, we just had our 71st meeting with Mat, Peter and Ossama (Intel =

OTC), Christoph (Apple), Paolo, Florian and Davide (RedHat) and myself =

(Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
     - mptcp: fix 'assignment from incompatible pointer type' warning:
         - By Paolo
         - squashed
         - Accepted by Mat

     - [GIT] add Co-developed-by tag:
         - By Matth
         - squashed

     - mptcp: Interim Path Manager:
         - by Peter
         - Accepted by Paolo

     - mptcp: disallow setting the MPTCP ULP from userspace:
         - by Davide
         - squashed
         - v2 Accepted by Paolo, Matth

     - selftests: allow compilation on older systems:
         - by Florian
         - squashed
         - Accepted by Davide, Matth

     - mptcp:pm: some cleanup:
         - by Matth
         - limit changes for basic in pm.c + remove dup code
         - squashed
         - Accepted by Paolo

     - mptcp: just another recvmsg refactor=E2=80=8B:
         - by Paolo
         - Accepted by Mat
         - rebase/squash done by Paolo

     - IPv6 prerequisite patches:
         - by Peter
         - squashed
         - Accepted by Paolo

     - mptcp: fix compilation warnings with i386:
         - by Matth
         - Accepted by Paolo

     - mptcp: fix compilation warnings/errors without IPV6:
         - by Matth
         - Accepted by Paolo

     - mptcp: fix warnings reported by checkpatch:
         - by Matth
         - 5 patches
         - Accepted by Paolo
         - Except patch 4/5: =

https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/message/TON4FBKW5=
O3K2LN3E3FVVFNS4BTAL22O/
         - Feel free to comment if you think it is needed (if not, it =

will be dropped)



Pending patches:
     - mptcp: sendmsg scheduler skeleton
         - include: mptcp_poll should not block on each subflow:
         - by Florian
         - new RFC
         - commented by Paolo

     - selftests: fixes and improvements:
         - include: prepare for mptcp ipv6 support
         - by Florian
         - v2 sent + 2 new ones
         - *Waiting for review*

     - mptcp: Add DATA_FIN transmission and handling:
         - by Mat
         - RFC
         - Commented by Paolo, Christoph

     - IPv6 support:
         - by Peter
         - RFC
         - Commented by Paolo, Matth

     - mptcp: recvmsg refactor follow-up:
         - by Paolo
         - fix tests
         - Accepted by Matth
         - *To be applied if there is no objections*



Remaining items for the initial submission:
     - IPv6 support:
         - Peter is working on it
         - see below

     - MPTCP v1 support:
         - To be done
         - Paolo might start to look at it next week

     - DATA_FIN:
         - Mat is working on it
         - rebasing on what has been recently modified + applying =

comments + continuing the dev

     - Shared recv window:
         - work to be done

     - Active backup support:
         - Paolo is working on it

     - Limit subflow ULP visibility to kernel space:
         - Davide did that

     - optimisation of options in TCP "struct mptcp_options_received":
         - Peter did a first patch, will share it ASAP

     - MAINTAINERS file



IPv6 support:
     -  Paolo: What if we make MPTCP IPv6 support depending on IPV6 =3D y =

? (not to have IPv6 as a module but still not depending on IPV6)

     - So we propose to have a new CONFIG_MPTCP_IPV6 depending on IPV6=3Dy

     - If we move to separated files, it should be OK and not have too =

many if statements (CONFIG_MPTCP_IPV6), then no need to have MPTCP =

directly depending on IPV6

     - Still to do:
         - Add selftests.

         - Multiple subflows. ADD_ADDR option does not fit in TCP header =

with DSS, need to send independent ACK to carry it.

         - Possibly split IPv4 and IPv6-specific portions into separate =

files, or at least reduce some of the excessive copy-paste in this version.

         - Is special handling needed for IPv4-mapped addresses? =E2=86=92 =
maybe =

yes for IPv6 sockets handling both v4 and v6

     - Note: In mptcp.org, if we create a v4 only socket, it cannot =

accept v6 subflows. Many apps are doing that by default (nginx, etc.). =

Would be good to avoid that here.



patchwork:
     - sounds good
     - we can ask the maintainers to know if they can host us
     - *@Matth* can do that



CI:
     - i386 build
     - with -Werror
     - build without IPv6



Basic PM:
     - is it temporary?
     - if not: maybe better to add pm in the name
     - maybe "safer" to do that now (the patch is at the end)



Next meeting:
     - We propose to have it next Thursday, the 24th of October.
     - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20191024



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
--===============0902886314025168252==--
