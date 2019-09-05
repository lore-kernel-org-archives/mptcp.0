Content-Type: multipart/mixed; boundary="===============7643529434170935868=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 5th of September 2019
Date: Thu, 05 Sep 2019 19:17:21 +0200
Message-ID: <b04be734-d163-a30b-0c5c-ed8561dd2b84@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1792

--===============7643529434170935868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 65th meeting with Mat, Peter, Ossama (Intel OTC),
Christoph (Apple), Florian and Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - mptcp: sockopt: pass whitelisted setsockopt to subflows:
        - by Florian
        - we only took the change in the getsockopt part: to disable it
once the socket is connected
        - accepted by Mat
        - "squashed"

    - mptcp: Make MPTCP socket block/wakeup ignore sk_receive_queue :
        - by Mat
        - accepted by Paolo
        - added at the end



Pending patches:
    - mptcp: Implement interim path manager:
        - by Peter
        - RFC v3
        - @Peter will merge the one from Matt (announce an addr) + use
(another?) sysctl to create sf
        - Peter will share a new version soon, no longer in RFC

    - mptcp: implement retransmit infrastructure:
        - 8 patches converted to 7
        - by Paolo
        - RFC =E2=86=92 v1
        - Waiting for more comments/reviews

    - mptcp: token api refactoring/cleanup:
        - 10 patches converted to 2
        - by Florian
        - no longer an RFC
        - waiting to be accepted
        - can be applied after Peter's quick review

    - mptcp: fix mptcp socket cleanup:
        - by Paolo
        - waiting for review

    - net/mptcp: rcu-ify the subflow context:
        - by Davide
        - waiting for review



Git: sync with net-next:
    - we got one conflict, small
    - see ML for more detail



What's needed before removing RFC on MPTCP Upstream patch-set:
    - Florian: Once mptcp_poll is a bit saner, we've sorted out token
refcounting (also working on this), Paolos retrans patches are in *and*
we can deal with data arriving on multiple subflows I think we'd be good
for a non-rfc patchset.

    - Florian: IPv6 would be nice but I don't think its a deal-breaker
if we'd place it on the immediate post-merge todo list.

    - Mat: DATA_FIN handling

    - shared received window: that might lead to issues. We should
certainly add some safeguards for this that should only happen in corner
cases to avoid drop of MPTCP connections:
        - if we don't announce the right thing, if we see that the
sender sends too much (especially OOO data), we can drop. Not good for
perf but safe.
        - at the end, this is important... Either we directly implement
this or we add some protections.
        - Maybe we should ask the questions to maintainers.

    - @Mat: may you update the Wiki please?



Poll handling:
    - we shouldn't wake up userspace app blocking on mptcp socket just
because subflow has data available. Same for write side, if a backup
subflow is writeable but all others are blocked, we can't wake userspace.

    - probably need to move part of what we do in recv path into the
'sk_data_ready' path called from tcp stack so we know if we have new
in-mptcp-sequence data available

    - mptcp_poll needs to be rewritten in any case, can't call tcp_poll
on all (!) subflows

    - Florian is looking at this, current state at
    https://git.breakpoint.cc/cgit/fw/mptcp-next.git/log/?h=3Dmptcp_poll_01

    - after this change, mptcp_poll() blocks only once. Its unblocked by
first subflow that has data available.



MIB for MPTCP:
    - (see discussion we had last week)
    - Florian started to work on it
    - Sounds like it should not be complicated to add.
    - Prototype is ongoing



Token refcounting:
    - Florian also work on that to avoid having to manually freeing
resources
    - Will share that after the other patches linked to the token are merged



LPC:
    - paper:
        - *please feel free to review* :)
        - let us know if stuff are wrong, need update, are missing
        - https://www.overleaf.com/read/thprgxkdxxwg

    - list of questions we want to ask:
        - what should be in the first version? (ipv6? mib? checksum?

        - memory usage for parsing TCP options =E2=86=92 struct
tcp_options_received included in struct tcp_sock

        - which mptcp version to support

        - having MPTCP subsystem? To work directly on the upstream repo
without having to rework/rebase? MPTCP is disabled by default =E2=86=92 API=
 will
be frozen =E2=86=92 to be discussed after the presentation?

        - supporting TCP Fast Open will be a big work? Anyway it is not
needed for the initial submission but might not be easy

    - list of known "non optimised" code in the paper:
        - SKB that are cloned (?)
        - when MPTCP Data ACK
        - linked to "What to support?" subsection in the paper. Please
update the paper

    - 5G - will use MPTCP v1



Next meeting:
    - We propose to have it next Thursday, the 12th of September.
    - This might be a short call, Mat and Peter will not be available.
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190912



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

--===============7643529434170935868==--
