Content-Type: multipart/mixed; boundary="===============3244320708231894836=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 31st of October 2019
Date: Thu, 31 Oct 2019 18:06:27 +0100
Message-ID: <00fd95a4-aee3-aae9-12c9-1a618da6e603@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2382

--===============3244320708231894836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Today, we had our 73rd (scary) meeting with Mat, Peter and Ossama (Intel =

OTC), Christoph (Apple), Paolo, Florian and Davide (RedHat) and myself =

(Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
     - mptcp: switch mptcp_poll to use parent sock wait queue:
         - include: mptcp: sendmsg scheduler skeleton
         - include: mptcp_poll should not block on each subflow:
         - by Florian
         - Accepted by Paolo

     - selftests: mptcp: increase test coverage:
         - include: selftests: fixes and improvements
         - include: prepare for mptcp ipv6 support
         - by Florian
         - Accepted by Mat
         - With a fix from Mat (capture options)

     - selftests:mptcp: increase timeout:
         - by Matth
         - v2

     - Fix bug processing options:
         - by Peter
         - Accepted by Mat
         - (+ fixed a compilation error)

     - self-tests: catch poll errors:
         - by Paolo
         - Accepted by Florian

     - Small improvement in kselftests:
         - by Matth
         - accepted by Mat

     - Fix issues in prerequisite [IPv6] patches:
         - by Peter
         - v2 accepted by Paolo
         - *Peter*: there is a comment by Paolo: patch 2/2 will allow =

mptcp clients to either ipv4 and ipv6 subflows, if the server =

allows/supports that - e.g. mptcp.org server



Pending patches:
     - mptcp: Add DATA_FIN transmission and handling:
         - by Mat
         - (old) RFC
         - Commented by Paolo, Christoph

     - IPv6 support:
         - by Peter
         - (new) v1
         - v1 Commented by Paolo, Davide

     - mptcp: add primitive scheduler:
         - by Florian
         - (new) v1
         - v2 expected



Remaining items for the initial submission: Planning:
     - Part 1 (mainly TCP changes, will be sent with Part 2):
         - MAINTAINERS file

     - Part 2 (minimum set for MPTCP, up to KSelftests, one subflow):
         - IPv6 support
         - MPTCPv1 support
         - opti in TCP options?
         - Send DATA_FIN, no corner cases
         - if the peer never sends MPTCP-level ACK, a lot of memory will =

be used

     - Part 3 (after the KSelftests, to be sent ideally before the end =

of the year)
         - Full DATA_FIN support
         - Shared recv window
         - Active backup support



Remaining items for the initial submission: Update:
     - IPv6 support:
         - Peter is working on it
         - patches are almost ready, mostly some changes needed related =

to KConfig
         - maybe separated files? Seems not needed now (specific changes =

are small), could be done later once upstream
         - ideally we would need CONFIG_MPTCP_IPV6=3Dy by default

     - MPTCP v1 support:
         - Better to keep v1 patch alone with Christoph as an author
         - Still need to check how we arrange patches but the idea is to =

have v0 and v1 support in the same patch-set (series)
         - Christoph is working on it
         - Paolo: Looking at the code (mptcp.org), it seems to me the =

above does not implement/use sha256, but it still relies on sha1 hmac:
             - Should be SHA256
             - additional patches are required (but small)
         - Wireshark and TCPDump do not support MPTCPv1:
             - Wireshark: https://code.wireshark.org/review/#/c/34896/

     - DATA_FIN:
         - Mat is working on it
         - "Basic" support: send the data fin (at least one, will see =

later for the retransmissions, receive, etc.)
         - will share an update soon

     - Shared recv window:
         - work to be done

     - Active backup support:
         - Florian is working on it

     - optimisation of options in TCP "struct mptcp_options_received":
         - Peter is working on it

     - if the peer never sends MPTCP-level ACK, a lot of memory will be =

used:
         - Florian is working on that
         - quite tricky to fix but important

     - MAINTAINERS file
         - TODO



Netdev:
     - no feedback
     - should we send a new message?
     - maybe now better to wait for part 2 to be ready instead of =

sending a new message to have some feedbacks



exported branch:
     - some code chunks should be moved to other patches:
         - Paolo will send an email about that

     - in some code of .h files, some spaces/tabs are used while it =

should be the opposite:
         - Peter will look at that when optimising stuff in struct =

mptcp_options_received



Patchwork:
     - no news from the maintainers



Next meeting:
     - We propose to have it next Thursday, the 7th of November.
     - *Back to the usual time* (for most of us): 17:00 UTC (9am PST, =

6pm CET)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20191107



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
--===============3244320708231894836==--
