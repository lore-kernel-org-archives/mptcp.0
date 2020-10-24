Content-Type: multipart/mixed; boundary="===============3567160319467374347=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] Squash to "selftests: mptcp: add link
 failure test case"
Date: Sat, 24 Oct 2020 12:15:52 +0200
Message-ID: <20201024101552.3707034-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 6430

--===============3567160319467374347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix typo in files listed in the cleanup() function: $sin and $sout were
no longer removed at the end of the test.

That's not a big issue, when finishing the script, $sin and $sout weight
both 1KB.

Fixes: 36221baa8712 ("selftests: mptcp: add link failure test case")
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "selftests: mptcp: add link failure test case"

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 8b28c6cc038d..7ed2d8bdc9c0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -82,7 +82,7 @@ cleanup_partial()
 cleanup()
 {
 	rm -f "$cin" "$cout"
-	rm -f "$cin" "$cout" "$cinsent"
+	rm -f "$sin" "$sout" "$cinsent"
 	cleanup_partial
 }
 =

-- =

2.27.0

--===============3567160319467374347==--
