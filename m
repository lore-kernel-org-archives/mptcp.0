Content-Type: multipart/mixed; boundary="===============4829193085382212010=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] selftests: mptcp: fix dependecies
Date: Fri, 07 Aug 2020 11:32:04 +0200
Message-ID: <781f07aa4d05b123a80bf98f5839e1611a833272.1596791966.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5508

--===============4829193085382212010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since commit df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
the MPTCP selftests relies on the MPTCP diag interface which is
enabled by a specific kconfig knob: be sure to include it.

Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 tools/testing/selftests/net/mptcp/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selft=
ests/net/mptcp/config
index 2499824d9e1c..8df5cb8f71ff 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -1,4 +1,6 @@
 CONFIG_MPTCP=3Dy
 CONFIG_MPTCP_IPV6=3Dy
+CONFIG_INET_DIAG=3Dm
+CONFIG_INET_MPTCP_DIAG=3Dm
 CONFIG_VETH=3Dy
 CONFIG_NET_SCH_NETEM=3Dm
-- =

2.26.2

--===============4829193085382212010==--
