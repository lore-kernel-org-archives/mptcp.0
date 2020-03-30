Content-Type: multipart/mixed; boundary="===============4518111419199668074=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 1/1] selftests:mptcp: fix failure due to
 whitespace damage
Date: Mon, 30 Mar 2020 16:23:54 +0200
Message-ID: <20200330142354.563259-2-matthieu.baerts@tessares.net>
In-Reply-To: 20200330142354.563259-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4109

--===============4518111419199668074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

'pm_nl_ctl' was adding a trailing whitespace after having printed the
IP. But at the end, the IP element is currently always the last one.

The bash script launching 'pm_nl_ctl' had trailing whitespaces in the
expected result on purpose. But these whitespaces have been removed when
the patch has been applied upstream. To avoid trailing whitespaces in
the bash code, 'pm_nl_ctl' and expected results have now been adapted.

The MPTCP PM selftest can now pass again.

Fixes: eedbc685321b (selftests: add PM netlink functional tests)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 12 ++++++------
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testin=
g/selftests/net/mptcp/pm_netlink.sh
index 8c7bd722476e..9172746b6cf0 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -75,29 +75,29 @@ subflows 0" "defaults limits"
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 flags signal,backup
-check "ip netns exec $ns1 ./pm_nl_ctl get 1" "id 1 flags  10.0.1.1 " "simp=
le add/get addr"
+check "ip netns exec $ns1 ./pm_nl_ctl get 1" "id 1 flags  10.0.1.1" "simpl=
e add/get addr"
 =

 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 "id 1 flags  10.0.1.1
 id 2 flags subflow dev lo 10.0.1.2
-id 3 flags signal,backup 10.0.1.3 " "dump addrs"
+id 3 flags signal,backup 10.0.1.3" "dump addrs"
 =

 ip netns exec $ns1 ./pm_nl_ctl del 2
 check "ip netns exec $ns1 ./pm_nl_ctl get 2" "" "simple del addr"
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 "id 1 flags  10.0.1.1
-id 3 flags signal,backup 10.0.1.3 " "dump addrs after del"
+id 3 flags signal,backup 10.0.1.3" "dump addrs after del"
 =

 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3
 check "ip netns exec $ns1 ./pm_nl_ctl get 4" "" "duplicate addr"
 =

 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 id 10 flags signal
-check "ip netns exec $ns1 ./pm_nl_ctl get 4" "id 4 flags signal 10.0.1.4 "=
 "id addr increment"
+check "ip netns exec $ns1 ./pm_nl_ctl get 4" "id 4 flags signal 10.0.1.4" =
"id addr increment"
 =

 for i in `seq 5 9`; do
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.$i flags signal >/dev/null 2>&1
 done
-check "ip netns exec $ns1 ./pm_nl_ctl get 9" "id 9 flags signal 10.0.1.9 "=
 "hard addr limit"
+check "ip netns exec $ns1 ./pm_nl_ctl get 9" "id 9 flags signal 10.0.1.9" =
"hard addr limit"
 check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "above hard addr limit"
 =

 for i in `seq 9 256`; do
@@ -110,7 +110,7 @@ id 4 flags signal 10.0.1.4
 id 5 flags signal 10.0.1.5
 id 6 flags signal 10.0.1.6
 id 7 flags signal 10.0.1.7
-id 8 flags signal 10.0.1.8 " "id limit"
+id 8 flags signal 10.0.1.8" "id limit"
 =

 ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index de9209305026..b24a2f17d415 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -335,14 +335,14 @@ static void print_addr(struct rtattr *attrs, int len)
 				error(1, errno, "wrong IP (v4) for family %d",
 				      family);
 			inet_ntop(AF_INET, RTA_DATA(attrs), str, sizeof(str));
-			printf("%s ", str);
+			printf("%s", str);
 		}
 		if (attrs->rta_type =3D=3D MPTCP_PM_ADDR_ATTR_ADDR6) {
 			if (family !=3D AF_INET6)
 				error(1, errno, "wrong IP (v6) for family %d",
 				      family);
 			inet_ntop(AF_INET6, RTA_DATA(attrs), str, sizeof(str));
-			printf("%s ", str);
+			printf("%s", str);
 		}
 		if (attrs->rta_type =3D=3D MPTCP_PM_ADDR_ATTR_ID) {
 			memcpy(&id, RTA_DATA(attrs), 1);
-- =

2.25.1

--===============4518111419199668074==--
