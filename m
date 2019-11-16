Content-Type: multipart/mixed; boundary="===============8589676930109964527=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 05/10] selftests:mptcp: reduce time to wait for DAD
Date: Sat, 16 Nov 2019 13:59:31 +0100
Message-ID: <20191116125936.3563275-6-matthieu.baerts@tessares.net>
In-Reply-To: 20191116125936.3563275-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2566

--===============8589676930109964527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We can use 'ip addr' to know if everything is setup.

In my test, DAD has already finished when checking the first time.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: add basic kselftest for mptcp"

 .../testing/selftests/net/mptcp/mptcp_connect.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 3274cc1fd145..f413a7f3379c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -461,9 +461,23 @@ check_mptcp_disabled
 =

 check_mptcp_ulp_setsockopt
 =

+show_all_ipv6()
+{
+	local ns
+	for ns in "$ns1" "$ns2" "$ns3" "$ns4"; do
+		ip -net "${ns}" -6 addr show scope global
+	done
+}
+
 # Allow DAD to finish
-$ipv6 && sleep 2
+if $ipv6; then
+	for dad in $(seq 20); do
+		show_all_ipv6 | grep -q -e tentative -e temporary || break
+		sleep 0.1
+	done
+fi
 =

+echo "INFO: validating network environment with pings"
 for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns1" $sender 10.0.1.1
 	if $ipv6;then
-- =

2.24.0

--===============8589676930109964527==--
