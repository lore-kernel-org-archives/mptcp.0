Content-Type: multipart/mixed; boundary="===============6341644684345178283=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 9th of May 2019
Date: Thu, 09 May 2019 19:20:02 +0200
Message-ID: <e32b3f95-6bb0-e4c7-ec25-8fb4b27bc0c8@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1138

--===============6341644684345178283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 48th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple), Paolo, Davide (Red Hat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



architecture:
    - now in Github/Gerrit repos!

    - feel free to create patches on top of "for-review" (or "export")
branch

    - if you want to drop TopGit support to have more people merging
patches, don't hesitate to say it :)

    - Matth will manage the TopGit tree. Simply add a note saying if a
fix can be squashed in one commit (if clearly related to one commit) or
to be appended. With TopGit we only add topic (no rewrite of the tree)
so it can help to follow the changes that were made. We can do that to
reduce a big rework of rebase later but we can also append at the end
if it is easier for the moment.



New patches:
    - mptcp: mptcp option len must be skb independent =E2=86=92 by Paolo,
accepted by Mat, merged

    - mptcp: refactor xmit path =E2=86=92 by Paolo, new v2 available but a =
v3 is
needed. Will be sent later.

    - mptcp: refactor shutdown/close =E2=86=92 by Paolo, a v2 is needed,  h=
ope
to send a new version soon. The simple way to fix the issue might not be
good when we will want to support the MP JOIN but that can be modified
later.

    - Mat is preparing a commit to fix the MPTCP option len saw by Florian.

    - Florian noticed memleak in accept. He is looking for a fix



kselftests:
    - new selftests change: Add capture option =E2=86=92 by Mat, merged

    - comment by Paolo:
        - On a side note, running tcpdump in background usually hides
most of the existing races, at least in my experiments :(

        - is it because it slows down the process (copy)

    - Matth can run the kselftests after the daily rebase if needed:

        - by chance, any script to share to compile the kernel + run in
KVM + launch kselftests on a CI? :)

        - don't hesitate to add scripts in the 'scripts' branch

        - https://github.com/multipath-tcp/mptcp_net-next/tree/scripts

    - MPTCP kselftests are unstable for the moment. If you are working
on a fix, please share this info:

        - Mat is currently looking at this



Wiki:
    - Mat has updated the status page:
https://github.com/multipath-tcp/mptcp_net-next/wiki/Status



Bug:
    - Paolo found a bug when a download is running for a long(er) time
(already discussed on the ML)

    - DSN updated once the app got the data, receive window is
progressing then

    - in MPTCP.org if we receive an ACK for the subflow but the DataAck
is not present, we fallback to TCP
    https://tools.ietf.org/html/rfc6824#section-3.6

    - Mat will try to reproduce that. It might be visible in the
selftest if we change the file we want to transfer to ~50MB



mptcp.org:
    - Add MPTCP support in TCP Tracepoint?

        - TCP: tcp:tcp_retransmit_skb, tcp:tcp_send_reset,
tcp:tcp_receive_reset, tcp:tcp_destroy_sock, tcp:tcp_rcv_space_adjust,
tcp:tcp_retransmit_synack, tcp:tcp_probe
        - SOCK: sock:sock_rcvqueue_full, sock:sock_exceed_buf_limit,
sock:inet_sock_set_state

    =E2=86=92 could be good to have that, Matth will look at it



Next meeting:
    - We propose to have it next Thursday, the 16th of May.
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190516



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

--===============6341644684345178283==--
