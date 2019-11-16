Content-Type: multipart/mixed; boundary="===============3274696347789508140=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] selftests: no re-ordering makes tests very slow
Date: Sat, 16 Nov 2019 13:41:07 +0100
Message-ID: <5e2d899e-852d-b213-afc2-1dce2fb80305@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2559

--===============3274696347789508140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

When trying to reproduce the crash I had, I saw that most of the time =

when there is no re-ordering set (which can happen even with the default =

options) but with loss and delay, the tests can be very slow with the ns4:


ns1 MPTCP -> ns3 (dead:beef:3::2:10013) MPTCP  (duration   157ms) [ OK ]
ns1 MPTCP -> ns4 (10.0.3.1:10014      ) MPTCP  (duration 33023ms) [ OK ]
ns1 MPTCP -> ns4 (dead:beef:3::1:10015) MPTCP  (duration 36485ms) [ OK ]
ns2 MPTCP -> ns1 (10.0.1.1:10016      ) MPTCP  (duration   118ms) [ OK ]
(...)
ns2 MPTCP -> ns3 (dead:beef:3::2:10021) MPTCP  (duration   126ms) [ OK ]
ns2 MPTCP -> ns4 (10.0.3.1:10022      ) MPTCP  (duration 15036ms) [ OK ]
ns2 MPTCP -> ns4 (dead:beef:3::1:10023) MPTCP  (duration 11507ms) [ OK ]
ns3 MPTCP -> ns1 (10.0.1.1:10024      ) MPTCP  (duration   129ms) [ OK ]
(...)
ns3 MPTCP -> ns2 (dead:beef:2::1:10029) MPTCP  (duration   139ms) [ OK ]
ns3 MPTCP -> ns4 (10.0.3.1:10030      ) MPTCP  (duration  4317ms) [ OK ]
ns3 MPTCP -> ns4 (dead:beef:3::1:10031) MPTCP  (duration  4321ms) [ OK ]
ns4 MPTCP -> ns1 (10.0.1.1:10032      ) MPTCP  (duration 48538ms) [ OK ]
ns4 MPTCP -> ns1 (dead:beef:1::1:10033) MPTCP  (duration 39943ms) [ OK ]
ns4 MPTCP -> ns2 (10.0.1.2:10034      ) MPTCP  (duration 24599ms) [ OK ]
ns4 MPTCP -> ns2 (dead:beef:1::2:10035) MPTCP  (duration 23126ms) [ OK ]
ns4 MPTCP -> ns2 (10.0.2.1:10036      ) MPTCP  (duration 64512ms) [ OK ]
ns4 MPTCP -> ns2 (dead:beef:2::1:10037) MPTCP  (duration 37747ms) [ OK ]
ns4 MPTCP -> ns3 (10.0.2.2:10038      ) MPTCP  (duration  4766ms) [ OK ]
ns4 MPTCP -> ns3 (dead:beef:2::2:10039) MPTCP  (duration  4772ms) [ OK ]
ns4 MPTCP -> ns3 (10.0.3.2:10040      ) MPTCP  (duration  4699ms) [ OK ]
ns4 MPTCP -> ns3 (dead:beef:3::2:10041) MPTCP  (duration  4324ms) [ OK ]
Time: 425 seconds


This can be easily reproduced by using:

   ./mptcp_connect.sh -r 0


When there is re-ordering, the tests are not ~95% of the time that slow. =

I guess it depends how much re-ordering we have.

Did you also see this in your tests?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3274696347789508140==--
