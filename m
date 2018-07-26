Content-Type: multipart/mixed; boundary="===============6977497596866459508=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 26th of July 2018
Date: Thu, 26 Jul 2018 19:04:38 +0200
Message-ID: <a5dcf79f-e1b6-cdb2-59e2-8d8001ec16e7@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 689

--===============6977497596866459508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 15th meeting with Mat, Ossama, Peter (Intel OTC),
Christoph (Apple) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Linux Plumber:
    - we sent a proposition of talk but no news
    - now a 2-days track
    - there are new announcements on the list (new talks accepted)



mptcp_net-next:
    - new patches (3) are coming from mptcp_trunk (and applied)
    - sync with net-next done by Mat
    - Christoph will look at upstreaming MPTCPv1 (first on mptcp_trunk)



Netdev's debriefing:
    - we got good feedbacks:
        - people want to have MPTCP upstream and are supportive (Tom
Herbert and Eric Dumazet)
        - some concerns about not modifying binaries and still use MPTCP
(without LD_PRELOAD), something possible with mptcp_trunk.
        - there were some discussions/reminders about using per cgroups
ebpf hooks (e.g. for API extension):
            - BPF/netdev background:
http://vger.kernel.org/netconf2018_files/AlexeiStarovoitov_netconf2018.pdf
    - skb buff: we got advises from Eric Dumazet: add a pointer at the
end is no longer costly (see the next topic)
    - changes in TCP stack: we didn't got propositions/discussions about
that, what we could do then:
        - either propose code change (RFC)
        - having other possibilities to talk about architecture
        - RFC about a design/API (internal API first before exposing
that to userspace)
            - for the userspace API, it could be nice to expose subflows
or only a part of them (err queue, send queue info)



Mat and Peter's patches:
    - can be updated after Eric Dumazet comments:
        - it is fine to add a few bytes *as long as we don't touch them*
(not to affect cache misses)
        - "size doesn't matter"... he said (somehow)
        - Mat: could still be good to check if we need a separated queue
        - Christoph: callback + memory generator:
            - could be good in case of splitting (tcp_fragment: to point
to the same memory if it is linked to the same DSS)
            - should be ok for the incoming and outgoing path
    - TODO: write in the wiki a design based on Eric's idea (adding a
few bytes at the end of the SKB is OK)
        - Mat will start that and share the wiki page.

Next steps:
    - Peter: working on MP_JOIN stuff
    - Christoph: MPTCPv1 + bug fixes + test mptcp_net-next
    - Mat: new design + new test setup between two VMs but difficult to
track regression (for mptcp_net-next)
    - Matth: use recent kernel and try to test mptcp_net-next with our
test-suite. + update netlink code after that.
    - Ossama: more debugging on userspace code



Next meeting:
    - We propose to have it next Wednesday this time to have more people
available, the 1st of August then. Usual time 9am PDT - 16:00 UTC (9am
PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20180801



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

-- =



DISCLAIMER.
This email and any files transmitted with it are confidential =

and intended solely for the use of the individual or entity to whom they =

are addressed. If you have received this email in error please notify the =

system manager. This message contains confidential information and is =

intended only for the individual named. If you are not the named addressee =

you should not disseminate, distribute or copy this e-mail. Please notify =

the sender immediately by e-mail if you have received this e-mail by =

mistake and delete this e-mail from your system. If you are not the =

intended recipient you are notified that disclosing, copying, distributing =

or taking any action in reliance on the contents of this information is =

strictly prohibited.

--===============6977497596866459508==--
