Content-Type: multipart/mixed; boundary="===============3999506426898518512=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 29nd of August 2019
Date: Fri, 30 Aug 2019 12:12:31 +0200
Message-ID: <ae47333d-870d-3a84-0dcc-a526cd32703c@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1766

--===============3999506426898518512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 64rd meeting with Mat, Peter, Ossama (Intel OTC),
Christoph (Apple), Paolo, Florian and Davide (RedHat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - mptcp: fall back to tcp when dss checksum are requested:
        - by Florian
        - accepted by Peter
        - acked by Christoph
        - "squashed"

    - mptcp: remove msk->subflow->sk dereference in pr_debug statement:
        - by Peter
        - accepted by Mat
        - "squashed"

    - mptcp: Change options handling so in_addr are in network byte order:
        - by Peter
        - 2 patches to ease the "squashed"
        - accepted by Mat
        - proposed by Florian
        - "squashed"

    - tcp: fix hooking for mptcp_incoming_options:
        - by Paolo
        - Accepted by Mat



Pending patches:
    - mptcp: Make MPTCP socket block/wakeup ignore sk_receive_queue :
        - by Mat
        - Mat has sent a new version (2 August)
        - Waiting for reviews (especially regarding the new flags and
other modifications)
        - Paolo replied during the meeting

    - mptcp: Implement interim path manager:
        - by Peter
        - RFC v3
        - still RFC? can we merge it?
        - *@Peter* will merge the one from Matt (announce an addr) + use
(another?) sysctl to create sf

    - mptcp: sockopt: pass whitelisted setsockopt to subflows:
        - by Florian
        - v2 sent
        - Waiting to be accepted
        - @Mat looked at that just after the meeting
        - We might want to only take the getsockopt() (return an error)
part and think about the API stuff later

    - mptcp: implement retransmit infrastructure:
        - 8 patches
        - by Paolo
        - RFC v2
        - Florian gave some comments
        - Waiting for more comments
        - *@Paolo* is working on it, fixing issues (one reported on the ML)
        - will send a new version end of this week (+ other fixes
independent to that)

    - mptcp:pm: sysctl to announce an addr:
        - by Matth
        - RFC
        - to sit on top of "mptcp: Implement interim path manager":
            - if the goal is to remove this later, better to also create
a new commit here?
        - Waiting for the parent change to be merged
        - Will also create a new subflow (like in Paolo's patch)
        - Peter will look at merging this with his patch, see above

    - mptcp: refactor token code:
        - 10 patches
        - by Florian
        - RFC v2
        - next step is to make the patches "squashed-friendly"



Checksum:
    - (from Peter) where do we stand on checksums? Not necessary for
initial submission?
    - *@Matth*: for multipath-tcp.org server, we should disable checksum
(only used if the client sets it)
        =E2=86=92 request has been sent



MIB:
    - multipath tcp MIB counter placement - share with tcp or extra?
(Florian)

    - Eric:
        There are about 40 counters.
        Space for that will be per netns : num_possible_cpus * 40 * 8  bytes
        The cost of folding all the values will make nstat slower even
if MPTCP is not used.
        Maybe find a way to not having to fold the MPTCP percpu counters
if MPTCP is not loaded ?

    - Florian:
        Ok, so 'same proc file' would be fine but 'increase pcpu mem
cost unconditionally' isn't.
        MPTCP is builtin (bool). However, we might be able to delay
allocation until first mptcp socket is requested, I will see if this can
be done somehow.

    - maybe some static key and clever stuff, seems possible to do (by
Florian)

    - like that, some tools will benefit from that (without having to
modify them)

    - MIB are useful for quick debug



Memory usage:
    - Paolo: we increased memory usage in structure (struct
tcp_options_received) by ~100 bytes for the parsing of the MPTCP options

    - this is included in TCP structures (struct tcp_sock) and can be a
problem for upstream

    - =E2=86=92 a question we should ask before (now or at LPC)

    - *@Peter* will look at making some optimisations there by using
unions (not everything is needed all the time)



Namespace pollution:
    - prefix all exposed MPTCP functions (even internally in net/mptcp)
with "mptcp_"

    - linked to the patches made by Florian (refactor token code)

    - idea is to do the same for subflow / pm / crypto (all exposed
functions)



split protocol.[ch]:
    - idea would be to send a list of functions that needs to be moved
where and Matth can do the work directly to avoid double work.

    - please provide a list of what should be moved where to start
discussing on that (*@Paolo/@Peter*?)



[sg]etsockopt():
    - do we want to be able to modify things for a specific subflow?
Using which FD? Another iface?

    - related somehow to what Florian did (whitelist)

    - there are already use cases for that, e.g. SO_MARK for Android per
subflow =E2=86=92 we can ask Lorenzo for that, TCP CC per subflow, etc.

    - Benjamin did some work on that for mptcp.org (Socket API):
https://inl.info.ucl.ac.be/system/files/main_8.pdf

    - another way is to do that via the PM (Netlink)

    - conclusion: we should think about that before freezing the API:
the idea for the moment is then not to allow any change and report this
for later.



LPC:
    - Are we aiming for RFC6824 or RFC6824bis compliance in the initial
upstream patchset? Or is that to be determined at some time after LPC?:
        - Do we need to explain the differences?:
            - big difference is the initialisation (how we share the key
=E2=86=92 no longer in the SYN, only in the 3rd ACK + first data)
            - add_addr is a bit different (with HMAC)
            - reason of a remove
            - fast-close with RST
        - maybe interesting to support only the v1, not to have to deal
with both versions and add complexity the code
        - (but not easy to test with others for the moment)
        - maybe better to say that the intension is to support only the
v1 and ask the question @LPC

    - Can we re-use abstract / intro / history from last time?:
        - ok for the beginning of the paper: MPTCP didn't change.
        - the presentation will of course be different

    - What has been upstreamed already?:
        - skb extensions
        - ULP diag? =E2=86=92 almost done. Should be in next-next soon (bef=
ore LPC)
        - do we still need to mention TCP Option framework that had been
rejected?
https://www.mail-archive.com/netdev(a)vger.kernel.org/msg214958.html =E2=86=
=92 we
can skip this

        - prepare a list of questions? what should be in the first
version? (ipv6, mib, checksum, memory usage for parsing TCP options,
which mptcp version to support etc.) =E2=86=92 for next time, please start
thinking about it

    - Looks like we need to upload our slides by the evening of 8 September

    - We should send the draft sooner.



Next meeting:
    - We propose to have it next Thursday, the 5th of September.
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190905



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

--===============3999506426898518512==--
