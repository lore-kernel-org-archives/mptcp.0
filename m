Content-Type: multipart/mixed; boundary="===============4777491667764762603=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 9th of August 2018
Date: Thu, 09 Aug 2018 19:02:55 +0200
Message-ID: <776dae1f-b318-b06f-5966-274d704ad065@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 698

--===============4777491667764762603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 17th meeting with Mat, Ossama, Peter (Intel OTC),
Christoph (Apple) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



New design by Mat:
    - https://github.com/multipath-tcp/mptcp_net-next/wiki/Design
    - what is at the beginning of the Design page is a bit old =E2=86=92 pl=
ease
check from "Metadata Queuing" =E2=86=92 new design is mainly about managing
MPTCP options in TCP header
    - Outgoing non-DSS options:
        - addition from Mat: if it is urgent, we can still use
tcp_send_ack() right after having added items in this queue
        - but there would be corner cases (more than one notification to
send, etc.)
        - would add complexity: maintaining the queue, allocating stuff,
etc. and maybe not really needed
        - easier to send them directly: allocate an sbk and send (at
least we manage TCP header option space for this packet)
    - Outgoing DSS option:
        - we hope David Miller will agree with Eric for his proposal but
we have one alternative just in case.
    - What's next:
        - Mat would like to update the prototype:
            - to use the error queue (that should fits well with what is
there already)
            - to use Eric's idea (should also be easy with the current
architecture)
            - maybe manage later the non-DSS options (by Peter)



tcp-robust-ooo:
    -
https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=3D=
1a4f14bab1868b443f0dd3c55b689a478f82e72e
    - do we need something like that for MPTCP (where we can have more
out-of-order by definition when using multiple subflows):
        - we might be vulnerable
        - but definitively might be good to do some fuzzing in the MPTCP
stack and detect bugs or see where are the expensive call in this case.



"MPTCP security for 5G" IETF draft:
    - not related to MPTCP upstream
    - (and doesn't seem related to MPTCP/TCP at all)


Testing recent kernel:
    - Matth: work still in progress, switching to more recent kernels!



Linux Plumbers:
    - no news nor feedback (but deadline is on the 15th of August)



Next steps:
    - Mat: update prototype
    - Peter: working on MP_JOIN stuff + later managing non-DSS options
    - Christoph: MPTCPv1 (if OK) + bug fixes
    - Ossama: more debugging on userspace code
    - Matth: use recent kernel and mptcp_net-next with our test-suite. +
update netlink code after that. (+ remove the disclaimer at the end of
my emails on public ML!)



Next meeting:
    - We propose to have it **on Monday** the 20th of August. Usual time
9am PDT - 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20180820



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

--===============4777491667764762603==--
