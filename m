Content-Type: multipart/mixed; boundary="===============2677113371308045926=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 10/10] [RFC] selftests:mptcp: decrease timeout to 100
 sec
Date: Sat, 16 Nov 2019 13:59:36 +0100
Message-ID: <20191116125936.3563275-11-matthieu.baerts@tessares.net>
In-Reply-To: 20191116125936.3563275-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2571

--===============2677113371308045926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In my tests, I first tried to use the worst random case we can have: 1%
of loss, 399ms of delay and a max of re-order but I guess it really
depends on what is lost and re-ordered.

Most of my results are around 30 seconds on my machine

But mostly when there is no re-ordering, the test can be very long! This
can happen in the normal mode, when not specifying any parameter to the
script:

  ns1 MPTCP -> ns3 (dead:beef:3::2:10013) MPTCP   (duration   157ms) [ OK ]
  ns1 MPTCP -> ns4 (10.0.3.1:10014      ) MPTCP   (duration 33023ms) [ OK ]
  ns1 MPTCP -> ns4 (dead:beef:3::1:10015) MPTCP   (duration 36485ms) [ OK ]
  ns2 MPTCP -> ns1 (10.0.1.1:10016      ) MPTCP   (duration   118ms) [ OK ]
  (...)
  ns2 MPTCP -> ns3 (dead:beef:3::2:10021) MPTCP   (duration   126ms) [ OK ]
  ns2 MPTCP -> ns4 (10.0.3.1:10022      ) MPTCP   (duration 15036ms) [ OK ]
  ns2 MPTCP -> ns4 (dead:beef:3::1:10023) MPTCP   (duration 11507ms) [ OK ]
  ns3 MPTCP -> ns1 (10.0.1.1:10024      ) MPTCP   (duration   129ms) [ OK ]
  (...)
  ns3 MPTCP -> ns2 (dead:beef:2::1:10029) MPTCP   (duration   139ms) [ OK ]
  ns3 MPTCP -> ns4 (10.0.3.1:10030      ) MPTCP   (duration  4317ms) [ OK ]
  ns3 MPTCP -> ns4 (dead:beef:3::1:10031) MPTCP   (duration  4321ms) [ OK ]
  ns4 MPTCP -> ns1 (10.0.1.1:10032      ) MPTCP   (duration 48538ms) [ OK ]
  ns4 MPTCP -> ns1 (dead:beef:1::1:10033) MPTCP   (duration 39943ms) [ OK ]
  ns4 MPTCP -> ns2 (10.0.1.2:10034      ) MPTCP   (duration 24599ms) [ OK ]
  ns4 MPTCP -> ns2 (dead:beef:1::2:10035) MPTCP   (duration 23126ms) [ OK ]
  ns4 MPTCP -> ns2 (10.0.2.1:10036      ) MPTCP   (duration 64512ms) [ OK ]
  ns4 MPTCP -> ns2 (dead:beef:2::1:10037) MPTCP   (duration 37747ms) [ OK ]
  ns4 MPTCP -> ns3 (10.0.2.2:10038      ) MPTCP   (duration  4766ms) [ OK ]
  ns4 MPTCP -> ns3 (dead:beef:2::2:10039) MPTCP   (duration  4772ms) [ OK ]
  ns4 MPTCP -> ns3 (10.0.3.2:10040      ) MPTCP   (duration  4699ms) [ OK ]
  ns4 MPTCP -> ns3 (dead:beef:3::2:10041) MPTCP   (duration  4324ms) [ OK ]
  Time: 425 seconds

I can reproduce this when there is no re-ordering:

  ./mptcp_connect.sh -r 0

I guess there is a bug and we should not take this into account to find
the best timeout but while this is not fixed, I don't know if we can
apply this patch.

Most of the time, the tests take ~30 seconds. When the conditions make
the test slower, if I remove the very long tests (no re-ordering), the
tests take max 50 seconds. That's why I double this last value for the
new default timeout.
This could be doubled again if needed because I didn't use a very slow
machine.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: add basic kselftest for mptcp"

 tools/testing/selftests/net/mptcp/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/settings b/tools/testing/sel=
ftests/net/mptcp/settings
index 026384c189c9..a953c96aa16e 100644
--- a/tools/testing/selftests/net/mptcp/settings
+++ b/tools/testing/selftests/net/mptcp/settings
@@ -1 +1 @@
-timeout=3D450
+timeout=3D180
-- =

2.24.0

--===============2677113371308045926==--
