Content-Type: multipart/mixed; boundary="===============1283444441693781771=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] squash-to: selftests: add PM netlink functional tests
Date: Wed, 25 Mar 2020 16:19:37 -0700
Message-ID: <20200325231937.28080-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4066

--===============1283444441693781771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add pm_nl_ctl to .gitignore

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 tools/testing/selftests/net/mptcp/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/.gitignore b/tools/testing/s=
elftests/net/mptcp/.gitignore
index d72f07642738..ea13b255a99d 100644
--- a/tools/testing/selftests/net/mptcp/.gitignore
+++ b/tools/testing/selftests/net/mptcp/.gitignore
@@ -1,2 +1,3 @@
 mptcp_connect
+pm_nl_ctl
 *.pcap
-- =

2.26.0

--===============1283444441693781771==--
