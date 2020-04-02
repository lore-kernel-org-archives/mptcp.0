Content-Type: multipart/mixed; boundary="===============1761858035059858843=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] selftests:mptcp:pm: rm the right tmp file
Date: Thu, 02 Apr 2020 09:29:53 +0200
Message-ID: <20200402072953.2505815-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4126

--===============1761858035059858843==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

"$err" is a variable pointing to a temp file. "$out" is not: only used
as a local variable in "check()" and representing the output of a
command line.

Fixes: eedbc685321b (selftests: add PM netlink functional tests)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testin=
g/selftests/net/mptcp/pm_netlink.sh
index 9172746b6cf0..15f4f46ca3a9 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -30,7 +30,7 @@ ret=3D0
 =

 cleanup()
 {
-	rm -f $out
+	rm -f $err
 	ip netns del $ns1
 }
 =

-- =

2.25.1

--===============1761858035059858843==--
