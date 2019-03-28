Content-Type: multipart/mixed; boundary="===============6164810255705647409=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 28th of March 2019
Date: Thu, 28 Mar 2019 18:10:12 +0100
Message-ID: <0217a2f2-898a-9f56-590c-35bc1bf868d0@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1039

--===============6164810255705647409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 44th meeting with Mat, Peter and Ossama (Intel OTC),
Florian, Paolo and Davide (Red Hat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Feedback from Netdev:
    - Eric:
        - is very happy to see that ULP is used to control the subflows!
        - would be happy to comment on the architecture, we can even
send an email to him directly if we prefer. He can give his
recommendations, even if it is not working or important pieces are
missing (MP_JOIN)
    - do we need to support the fact that the client (initiating the
connection) can support new subflows initiated by the server?
        - no: should never been needed as many clients are being a NAT
(don't say IPv6! For more jokes:
https://www.netdevconf.org/0x13/session.html?talk-ipv4-unicast-expansions)
    - Hoang has a proto to have a PM controlled by BPF
    - Florian got positive feedbacks:
https://www.netdevconf.org/0x13/session.html?skb-meta-data-extensions
        - (I forgot to ask: will they look at that for kTLS?)



Mat & Peter's patch-set:
    - new version sent by Mat addressing comments shared on Gerrit
    - Davide found issues when compiling without CONFIG_MPTCP
    - Mat is fixing these issues.
    - And combining that with what Peter is doing.
    - Peter: ULP update 3/4 done, hoping to finish soon (maybe end of
Peter's week) and share the implementation
    - MP_JOIN: the idea is first to have the support on the server side.
For the client, we can use mptcp.org implementation.
    - seems still important to have that for the first submission to netdev.
    - Once ULP is there, we can send this version to Eric for him to
look at.
    - Then we can see his reaction, implement the MP_JOIN part and send
that to netdev.
    - We don't have to wait for the client implementation to start
testing with only the "upstream" version: we can use Packetdrill for
that (TBC).
    - once ULP is done, can we merge in our repo, hoping it will help
ease other contributions to the code in parallel and ease maintenance
for Mat & Peter.



Wiki:
    - https://github.com/multipath-tcp/mptcp_net-next/wiki/Status
    - has just been updated by Mat: outgoing/future/previous work has
been updated
    - don't hesitate to comment on that!



mptcp.org:
    - new fixes from Christoph (found with syzkaller)



Ossama:
    - released the alpha for the Uspace PM (daemon)
    - it is currently implementing the "first version" of kernel netlink
path-manager (Intel proposition from last year)
    - next step: support the netlink version from mptcp.org (mptcp_trunk
branch)
    - Available: https://github.com/intel/mptcpd
    - Don't hesitate to like it ;-)



Next meeting:
    - We propose to have it next Thursday, the 4th of April.
    - *Back to the usual time* if you are in Europe: 16:00 UTC (9am
PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190404



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

--===============6164810255705647409==--
