Content-Type: multipart/mixed; boundary="===============8734574460774095234=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 5/5] selftests: increase timeout to 10 min
Date: Mon, 25 Jan 2021 10:59:04 -0800
Message-ID: <20210125185904.6997-6-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210125185904.6997-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7481

--===============8734574460774095234==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Matthieu Baerts <matthieu.baerts(a)tessares.net>

On slow systems with kernel debug settings, we can reach the current
timeout when all tests are executed.

Likely some tests need be improved to remove some 'sleep' and wait
(less) for a specific action. This can also improve stability.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
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

2.30.0

--===============8734574460774095234==--
