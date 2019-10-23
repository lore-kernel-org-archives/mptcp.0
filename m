Content-Type: multipart/mixed; boundary="===============5836350172861383378=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 1/2] selftests: settings: tests can be in subsubdirs
Date: Wed, 23 Oct 2019 08:48:53 +0200
Message-ID: <20191023064854.20453-2-matthieu.baerts@tessares.net>
In-Reply-To: 20191023064854.20453-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2273

--===============5836350172861383378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit 852c8cbf34d3 (selftests/kselftest/runner.sh: Add 45 second
timeout per test) adds support for a new per-test-directory "settings"
file. But this only works for tests not in a sub-subdirectories, e.g.

 - tools/testing/selftests/rtc (rtc) is OK,
 - tools/testing/selftests/net/mptcp (net/mptcp) is not.

We have to increase the timeout for net/mptcp tests which are not
upstreamed yet but this fix is valid for other tests if they need to add
a "settings" file, see the full list with:

  tools/testing/selftests/*/*/**/Makefile

Note that this patch changes the text header message printed at the end
of the execution but this text is modified only for the tests that are
in sub-subdirectories, e.g.

  ok 1 selftests: net/mptcp: mptcp_connect.sh

Before we had:

  ok 1 selftests: mptcp: mptcp_connect.sh

But showing the full target name is probably better, just in case a
subsubdir has the same name as another one in another subdirectory.

Fixes: 852c8cbf34d3 (selftests/kselftest/runner.sh: Add 45 second timeout p=
er test)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    To squash in "mptcp: add basic kselftest for mptcp"
    =

    Hopefully, this should be merged upstream[1]. If it is, the diff will
    "disappeared" from the TopGit topic/exported commit. So it is safe to
    squash it in an existing topic.
    =

    [1] https://patchwork.kernel.org/patch/11204935/

 tools/testing/selftests/kselftest/runner.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/se=
lftests/kselftest/runner.sh
index 84de7bc74f2c..0d7a89901ef7 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -90,7 +90,7 @@ run_one()
 run_many()
 {
 	echo "TAP version 13"
-	DIR=3D$(basename "$PWD")
+	DIR=3D"${PWD#${BASE_DIR}/}"
 	test_num=3D0
 	total=3D$(echo "$@" | wc -w)
 	echo "1..$total"
-- =

2.20.1

--===============5836350172861383378==--
