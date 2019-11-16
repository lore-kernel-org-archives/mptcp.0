Content-Type: multipart/mixed; boundary="===============4765725835352347834=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 02/10] selftests:mptcp: enable v6 by default
Date: Sat, 16 Nov 2019 13:59:28 +0100
Message-ID: <20191116125936.3563275-3-matthieu.baerts@tessares.net>
In-Reply-To: 20191116125936.3563275-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2563

--===============4765725835352347834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We switch to -4 option now to disable v6 tests (v4 only).

The goal is to have feedback from other CI watching netdev ML and
others and launching kselftests for each new patch.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: add basic kselftest for mptcp"

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index b51cea35e5c4..49b3fb6b042d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -3,7 +3,7 @@
 =

 time_start=3D$(date +%s)
 =

-optstring=3D"d:e:l:r:h6c"
+optstring=3D"d:e:l:r:h4c"
 ret=3D0
 sin=3D""
 sout=3D""
@@ -12,7 +12,7 @@ cout=3D""
 ksft_skip=3D4
 capture=3Dfalse
 timeout=3D30
-ipv6=3Dfalse
+ipv6=3Dtrue
 ethtool_random_on=3Dtrue
 tc_delay=3D"$((RANDOM%400))"
 tc_loss=3D$((RANDOM%101))
@@ -34,7 +34,7 @@ usage() {
 	echo -e "\t-l: tc/netem loss percentage, e.g. \"-l 0.02\" (default random=
)"
 	echo -e "\t-r: tc/netem reorder mode, e.g. \"-r 25% 50% gap 5\", use "-r =
0" to disable reordering (default random)"
 	echo -e "\t-e: ethtool features to disable, e.g.: \"-e tso -e gso\" (defa=
ult: randomly disable any of tso/gso/gro)"
-	echo -e "\t-6: enable IPv6 tests (default: only test IPv4)"
+	echo -e "\t-4: IPv4 only: disable IPv6 tests (default: test both IPv4 and=
 IPv6)"
 	echo -e "\t-c: capture packets for each test using tcpdump (default: no c=
apture)"
 }
 =

@@ -62,8 +62,8 @@ while getopts "$optstring" option;do
 	"r")
 		tc_reorder=3D"$OPTARG"
 		;;
-	"6")
-		ipv6=3Dtrue
+	"4")
+		ipv6=3Dfalse
 		;;
 	"c")
 		capture=3Dtrue
-- =

2.24.0

--===============4765725835352347834==--
