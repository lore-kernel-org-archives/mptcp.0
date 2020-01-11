Content-Type: multipart/mixed; boundary="===============4338445689243932084=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Squash-to: "mptcp: add basic kselftest for mptcp"
Date: Fri, 10 Jan 2020 17:10:57 -0800
Message-ID: <20200111011057.19143-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3343

--===============4338445689243932084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I was helping the LKP/0-day team with information on running our tests,
and noticed some missing config options.

It looks like a toss-up between 'm' and 'y' for these, so I set values
based on similar entries in tools/testing/selftests/net/config

Did I miss any others that aren't in the default config?

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 tools/testing/selftests/net/mptcp/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selft=
ests/net/mptcp/config
index 463f0514577d..2499824d9e1c 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -1,2 +1,4 @@
 CONFIG_MPTCP=3Dy
 CONFIG_MPTCP_IPV6=3Dy
+CONFIG_VETH=3Dy
+CONFIG_NET_SCH_NETEM=3Dm
-- =

2.24.1

--===============4338445689243932084==--
