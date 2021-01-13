Content-Type: multipart/mixed; boundary="===============9019304552554917602=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v5 4/4] selftests: increase timeout to 10
 min
Date: Wed, 13 Jan 2021 18:54:53 +0100
Message-ID: <20210113175453.1945886-5-matthieu.baerts@tessares.net>
In-Reply-To: 20210113175453.1945886-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7346

--===============9019304552554917602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On slow systems with kernel debug settings, we can reach the current
timeout when all tests are executed.

Likely some tests need be improved to remove some 'sleep' and wait
(less) for a specific action. This can also improve stability.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 tools/testing/selftests/net/mptcp/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/settings b/tools/testing/sel=
ftests/net/mptcp/settings
index 026384c189c9..a62d2fa1275c 100644
--- a/tools/testing/selftests/net/mptcp/settings
+++ b/tools/testing/selftests/net/mptcp/settings
@@ -1 +1 @@
-timeout=3D450
+timeout=3D600
-- =

2.29.2

--===============9019304552554917602==--
