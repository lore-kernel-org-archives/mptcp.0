Content-Type: multipart/mixed; boundary="===============7951930245728436402=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] packetdrill MP_JOIN failures
Date: Tue, 25 Aug 2020 22:47:26 +0200
Message-ID: <c604be2ac566d83ca0f4c3e85594cf0552c6a887.camel@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5620

--===============7951930245728436402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hello,

after commit 3960b799b496 ("mptcp: allow creating non-backup subflows"),
the mp_join_client.pkt packetdrill scenario detects a mismatch in the
contents of MP_JOIN SYN: when the server's additional address is
transmitted through an ADD_ADDR, the client has no way to set the 'B'
flag [1]. If I well understand, we can toggle the 'B' flag using the
MP_PRIO suboption, but this is not yet in mptcp-net-next [2].

Given the current state of mptcp-net-next, I'm for removing the 'B' flag
from the current test [2] and adding another specific test case once the
support for MP_PRIO is implemented (by the way, in case nobody is
already planning to do it I can have a look at it in the next days).

Any opinions/feedback appreciated, thank you in advance!
-- =

davide


[1] in mptcp_pm_nl_add_addr_received() "local" is memset to 0 and
local.flags is never assigned, so I think we should at least copy the
value of MPTCP_PM_ADDR_FLAG_BACKUP from the value configured by iproute.
Am I missing something?
[2] https://github.com/multipath-tcp/mptcp_net-next/issues/51
[3] clearing the 'B' flag in the MP_JOIN SYN makes the test progress until
the FIN packet, then it will fail because of known issue #69:
mp_join_client.pkt:28: error handling packet: live packet field ipv4_total_=
length: expected: 76 (0x4c) vs actual: 52 (0x34)
script packet:  2.238278 F. 3:3(0) ack 1 <nop,nop,TS val 4074418292 ecr 407=
4418293,dss dack4 16777216 dsn8 216172782113783808 ssn 0 dll 256 no_checksu=
m flags: MmAF,nop,nop>
actual packet:  2.238122 F. 3:3(0) ack 1 win 256 <nop,nop,TS val 4074412883=
 ecr 4074418293>

--===============7951930245728436402==--
