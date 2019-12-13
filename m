Content-Type: multipart/mixed; boundary="===============1081629982742393808=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] Revert "selftests: settings: tests can be in
 subsubdirs"
Date: Fri, 13 Dec 2019 12:38:53 +0100
Message-ID: <20191213113854.1690771-2-matthieu.baerts@tessares.net>
In-Reply-To: 20191213113854.1690771-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2930

--===============1081629982742393808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This reverts commit ef0a0e4954b360419a75c1428f422263eed29730.

This fix is not applied upstream yet but not really blocking for us, just a=
 bit
annoying. Better to remove it not to depend on KSelftests devs for that.

If you have a way to accelerate the process to have this patch applied
upstream, please do :-)

https://patchwork.kernel.org/patch/11204935/

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: add basic kselftest for mptcp"

 tools/testing/selftests/kselftest/runner.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/se=
lftests/kselftest/runner.sh
index 0d7a89901ef7..84de7bc74f2c 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -90,7 +90,7 @@ run_one()
 run_many()
 {
 	echo "TAP version 13"
-	DIR=3D"${PWD#${BASE_DIR}/}"
+	DIR=3D$(basename "$PWD")
 	test_num=3D0
 	total=3D$(echo "$@" | wc -w)
 	echo "1..$total"
-- =

2.24.0

--===============1081629982742393808==--
