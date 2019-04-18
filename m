Content-Type: multipart/mixed; boundary="===============4150944140239272075=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 18th of April 2019
Date: Thu, 18 Apr 2019 19:43:46 +0200
Message-ID: <044ce53e-3c9f-f095-0f99-3ac9fef29e8d@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1077

--===============4150944140239272075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 46th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple), Davide (Red Hat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Paolo's patch-sets:
    - refactor xmit, new version:
https://lists.01.org/pipermail/mptcp/2019-April/001066.html

    - addressed Mat's feedback, dropping patch 3/4 and switching to per
msk page frag use, and checking mptcp seq number for coalescing

    - Mat didn't have time to do a deeper review, will do it ASAP
(hoping today) =E2=86=92 once reviewed (and accepted), Mat will squash this=
 in
the commit introducing the xmit code

    - also a fix for mptcp_accept() =E2=86=92 Mat will integrate that in the
commit introducing the bug

    - https://lists.01.org/pipermail/mptcp/2019-April/001075.html

    - Paolo is testing that.

    - Found a bug in the substream (subflow) part. But when tracking the
bug, the bug is not visible, playing hide and seek :)

    - Mat also found a race condition in mptcp_accept() but seems
different than what Paolo saw. For Mat, it might be related to the ULP
stuff. Maybe a bug due to concurrency.

    - Note that with ULP, it is currently not used with listening
socket. Might have issues there.



Davide:
    - he is looking at extending the ULP structure to get info about
MPTCP via ss.

    - Mat: it might be good to also fix the fact the userspace can
create MPTCP subflow via ULP

    - Also a question about having MPTCP in a module: but certainly
better to avoid this (lot of work to support this). We can also see if
maintainers request it.



questions about mptcp-level locking:
    - https://lists.01.org/pipermail/mptcp/2019-April/001070.html

    - simpler lock/release vs cmpxchg

    - Mat's answer:
        Right now, the mptcp-level socket lock is taken first when
called from userspace for sendmsg/recvmsg because the MPTCP-level socket
will need to be locked first to determine which subflow socket to work
with, and then lock the subflow it needs to use.
        I had been thinking that calling "up" from the subflow to the
MPTCP-level socket would involve scheduling a worker that would be able
to lock in the same order as sendmsg/recvmsg. That does introduce some
latency, but I don't think MPTCP-level resends are as time-sensitive as
TCP retransmission (but maybe others on the list have more data or
experience on that topic).
        As for the window size computation, I've been trying to think of
ways to handle that without needing the msk lock but haven't found the
right idea yet.

    - in short, there was a missing lock (bug).

    - worker vs using locks: worker seems fine for to manage regular
data but not when we need a have an immediate response. Especially when
there are middleboxes.

    - adding a lock might reduces the race conditions issues but we need
to check if it is OK to do that in Linux.

    - we need to be careful with the contention, ddos attacks, etc.

    - we might need to add a lock when doing "subflow_finish_connect()
-> mptcp_finish_connect()"

    - (sorry I missed the beginning) according to Paolo's research, we
might need 3 locks: one lock for the state structure)

    - can be good to document that on the Wiki


@Paolo: may you document that in the wiki please?
I just checked and according to Github' settings: Any GitHub user can
create and edit pages to use for documentation,  examples, support, or
anything you wish. Please ping me if you cannot do that!



Ossama:
    - license in uapi: there should be a note mentioning that we can use
this file in a non GPL project.



Paolo:
    - Pushing patches to Gerrit introduces some overheads.
    - we all agreed it is OK to continue to use git send-email
    - Matt just updated the wiki page to keep the essential. The goal,
once 'git review' is setup is to keep the same workflow as before with
'git send-email' but only this last command is replaced by 'git review'.



Next meeting:
    - We propose to have it next Thursday, the 25th of April.
    - Paolo and Davide will not be there (Liberation Day in Italy).
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190425



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

--===============4150944140239272075==--
