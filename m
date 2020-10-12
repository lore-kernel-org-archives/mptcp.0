Content-Type: multipart/mixed; boundary="===============8355938478913362257=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] Squash to "selftests: mptcp: add ADD_ADDR
 timeout test case"
Date: Mon, 12 Oct 2020 17:41:29 +0200
Message-ID: <20201012154129.1824527-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 6292

--===============8355938478913362257==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Skip mptcp_join selftest if IPTables is not available.

Ideally, I agree that we should switch to ntf but I don't know the
advanced features of it to block ADD_ADDR packets by matching TCP option
30 and MPTCP subtype 3. If it is possible to do that, please guide me to
match MPTCP option (it looks like we are limited to a fixed list and
MPTCP is not there) and match some data after and offset (tcp doff?).

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "selftests: mptcp: add ADD_ADDR timeout test case"

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 3767acb9bb12..0b060d9a79ae 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -122,6 +122,12 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 =

+iptables -V > /dev/null 2>&1
+if [ $? -ne 0 ];then
+	echo "SKIP: Could not run all tests without iptables tool"
+	exit $ksft_skip
+fi
+
 =

 check_transfer()
 {
-- =

2.27.0

--===============8355938478913362257==--
