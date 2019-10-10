Content-Type: multipart/mixed; boundary="===============7461286366393315461=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 10th of October 2019
Date: Thu, 10 Oct 2019 19:04:37 +0200
Message-ID: <a450bc77-03b5-13d5-cf0f-5928d0c03884@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2093

--===============7461286366393315461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Today, we just had our 70th meeting with Mat (Intel OTC), Christoph =

(Apple), Paolo, Florian and Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
     - mptcp:diag: prefix exposed items:
         - by Matth
         - v1 commented by Davide & Florian
         - v2 sent

     - Squashed "tcp: Expose tcp struct and routine for MPTCP" into =

"tcp: Export TCP functions and ops struct":
         - proposed by Mat

     - Yet another rebase/squash/cleanup proposal:
         - by Florian
         - Reviewed by Paolo, Mat, Matth
         - Summary:
             - folds two commits
             - fixes the kbuild warnings we got with rfcv2
             - gets rid of refcounting in mptcp_subflow_get_ref

     - squash "mptcp: Make MPTCP socket block/wakeup ignore =

sk_receive_queue" into "MPTCP receive path":
         - by Mat

     - mptcp: timout delta must be signed:
         - by Paolo
         - Accepted by Matth

     - mptcp: mib: fix sparse warnings:
         - by Florian
         - Accepted by Matth

     - mptcp: fix kbuild warning:
         - by Matth
         - Accepted by Matth

     - PATCH kbuild:
         - by Mat
         - 3 patches
         - Accepted by Matth



Pending patches:
     - mptcp: Interim Path Manager:
         - by Peter
         - v2 sent
         - *Waiting for a last review*

     - mptcp_poll should not block on each subflow:
         - by Florian
         - no longer an RFC
         - *Waiting for a last review*

     - selftests: prepare for mptcp ipv6 support:
         - by Florian
         - commented by Paolo and Peter (+ who can do what) and Alexander
         - *Waiting for a last review*

     - mptcp: disallow setting the MPTCP ULP from userspace:
         - by Davide
         - Commented by Matth, Paolo
         - v2 expected

     - mptcp: fix warnings reported by checkpatch:
         - by Matth
         - 5 patches
         - *Waiting for review*
         - questions about remaining warnings:
             - no need to cut if just above 80 chars if hard to read =

after the cut
             - warnings: memory barrier without comment. Paolo has =

proposed a new comment
             - MAINTAINERS file

     - mptcp: fix 'assignment from incompatible pointer type' warning:
         - By Paolo
         - *Waiting for review*



Commit message:
     - According to the doc, we should have a pair of "Co-developed-by: =

<xxx>"  immediately followed by  "Signed-off-by: <xxx>"

     - Then a "Signed-off-by" for the one sending the patches

     - checkpatch.pl will not complain if "Co-developed-by: <xxx>" is =

not added, only if the following signed-off is not OK

     - =

https://elixir.bootlin.com/linux/v5.4-rc2/source/Documentation/process/subm=
itting-patches.rst#L548

     - > Checkpatch has "Check Co-developed-by: immediately followed by =

Signed-off-by: with same name and email"

     - *@Matth* can look at that



Remaining items for the initial submission:
     - IPv6 support:
         - Peter is working on it
         - Simple test cases working, will post an RFC patch soon

     - MPTCP v1 support:
         - To be done
         - Do we need also the support in mptcp.org (out-of-tree)
         - patches that had been shared were working, at least v1 =E2=86=92=
 v1

     - DATA_FIN:
         - Mat is working on it
         - working fine with a single subflow, WIP for multiple ones
         - Mat hopes to prepare a RFC patch soon
         - It seems there are work to do on MPTCP shutdown side.

     - Shared recv window:
         - we at least need protections again "deadlocks" if we accept =

having multiple subflows
         - work to be done, e.g. drop out of order MPTCP data

     - Active backup support:
         - Paolo is working on it
         - Florian plans to work on a basic scheduler.

     - Limit subflow ULP visibility to kernel space:
         - Davide is working on it
         - should be closed soon

     - optimisation of options in TCP "struct mptcp_options_received":
         - work to be done

     - MP_FAST_CLOSE, seems not implemented:
         - Do we want to add it now?
         - We might be able to live without it *for the moment*
         - implementation is easier with MPTCPv1
         - worst case if we don't support it:
             - one end with MPTCPv1 but using the old method: sending an =

ACK with FC
             - the other end with MPTCPv1 upstream: we don't react to =

this ACK
             - RST not sent
             - but initiator should anyway drop the connections



RFCv3:
     - sent by Mat yesterday (20191009)
     - no feedback yet



KBuild:
     - possible to cc warnings/errors to the ML?
     - Mat will check if:
         - the system can monitor the mailing
         - the system can continue to monitor Mat's repo but send =

messages to our ML (not only the people listed in the commit message)



Patent question:
     - By Paolo:
         - It appears its best that the implementation submitted for =

mainline kernel inclusion of the detail that appears to be the subject =

of the patent be done with code authored by you as and Apple employee.
         - It should be apparent from the written records (e.g. mailing =

list archives) that you've consulted with others at Apple who are aware =

of the relationship between the patent and the implementation.
         - Failing that, a Signed-off-by from you -- using your =

@apple.com address on the patch implementing the relevant V1 bits.

     - Signed-off-by from Christoph is enough?:
         - the best would be to have Christoph writing the code covered =

by the patent



CI:
     - now checking that each commit can compile



selftests:
     - new functionality tests?:
         - diag, mib, etc.

     - packetdrill:
         - 2 lines to add the new socket support
         - Davide will have a look at this to know what is possible to =

do with the existing implementation
         - (ideally we should re-implement MPTCP support on top of the =

last version of packetdrill)



lwn:
     - https://lwn.net/Articles/800501/
     - now public



for the next chunk of patches:
     - we hope to have feedback from David Miller

     - could be good to send a new RFC of the second chunk later

     - for IPv6, we could implement the workaround proposed by Florian =

last week

     - (also hard to comply with the other request: smaller patch-set)



RFC6824bis:
     - progressing
     - there were new comments from IESG
     - For the moment at the RFC Editor state, checking typo
     - https://datatracker.ietf.org/doc/draft-ietf-mptcp-rfc6824bis/
     - hard to give a date



Next meeting:
     - We propose to have it next Thursday, the 17th of October.
     - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
     - Still open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20191017



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
--===============7461286366393315461==--
