Content-Type: multipart/mixed; boundary="===============4946286547937012442=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 24th of January 2019
Date: Thu, 24 Jan 2019 18:51:11 +0100
Message-ID: <20df9f14-f21e-fdb0-030e-9f6c269f1c7c@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 980

--===============4946286547937012442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 36th meeting with Mat and Ossama (Intel OTC), Christoph
(Apple), Hoang (UCLouvain) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Netlink PM:
    - v8 has been merged!
    - (no more subflow_error events =E2=86=92 cf. last meeting)
    - we will see what people will do with it!
    - pretty close match with what Intel Netlink PM was supposed to be
    - Ossama's userspace code will be shared soon:
        - can share a first version which is not compatible with the
current kernel Netlink PM now in mptcp_trunk
        - compatibility will come later



Idea of a BPF PM for servers:
    - a simple PM, only to announce IP addresses given by the userspace
    - BPF to write IP address
        - that's the complex part, certainly to write this in PM private
memory
    - then the idea would be to hook (kprobe?) and call a function to do
that?
    - With BPF it means that you need to define a new API for actions
you can do (and maintain this API)



What's next?
    - focus on the first patch-set and try to upstream this base?
        Mat: is looking at the DATA-FIN (because the disconnect part is
not fully managed for the moment)
        Peter: he is also looking at improving this (and MP+Join)
        =E2=86=92 when this is done, we can start comparing that with
mptcp_net-next/master (with extra removal) ; accept the design ;
finalise patches and upstream this

    - removing feature on mptcp_net-next/master?
        Christoph has more removal in the queue (removal of the client
side + stats ; 2k lines are removed)

    - testing? (packetdrill?)
        Peter is also looking at that
        Would need to check how this job can be shared



CI:
    - Matth: update t/upstream manually this time, automatically later.
    - Feel free to ask for an update of t/upstream while it is not done
automatically, it is really easy and quick



mptcp stable:
    - not so many users of v0.93? (at least not so many downloads of the
RPM/DEB)
    - will continue to maintain v0.94 for a while (EOL for v4.14 is
January 2020)



Next meeting:
    - We propose to have the next one on Thursday, the 31st of January.
    - Usual time: 17:00 UTC (9am PST, 6pm CET)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190131



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

--===============4946286547937012442==--
