Content-Type: multipart/mixed; boundary="===============6399648512628732341=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] selftests:mptcp:pm: rm the right tmp file
Date: Fri, 15 May 2020 17:54:41 +0200
Message-ID: <20200515155442.1910397-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4392

--===============6399648512628732341==
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

--===============6399648512628732341==--
