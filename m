Content-Type: multipart/mixed; boundary="===============3938722100974150023=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net] mptcp: fix missing wakeup
Date: Wed, 24 Feb 2021 16:29:04 +0100
Message-ID: <8ac687c7b01474a364923a38d69183cdf7d7406f.1614180535.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7938

--===============3938722100974150023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

__mptcp_clean_una() can free write memory and should wake-up
user-space processes when needed.

When such function is invoked by the MPTCP receive path, the wakeup
is not needed, as the TCP stack will later trigger subflow_write_space
which will do the wakeup as needed.

Other __mptcp_clean_una() call sites need an additional wakeup check
Let's bundle the relevant code in a new helper and use it.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/165
Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
Fixes: 64b9cea7a0af ("mptcp: fix spurious retransmissions")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c                          | 10 ++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 ++++++++++++++-----
 2 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2859ad2c6990c..87f62fe66317d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1061,6 +1061,12 @@ static void __mptcp_clean_una(struct sock *sk)
 	}
 }
 =

+static void __mptcp_clean_una_wakeup(struct sock *sk)
+{
+	__mptcp_clean_una(sk);
+	mptcp_write_space(sk);
+}
+
 static void mptcp_enter_memory_pressure(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -2263,7 +2269,7 @@ static void __mptcp_retrans(struct sock *sk)
 	struct sock *ssk;
 	int ret;
 =

-	__mptcp_clean_una(sk);
+	__mptcp_clean_una_wakeup(sk);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag)
 		return;
@@ -2983,7 +2989,7 @@ static void mptcp_release_cb(struct sock *sk)
 	}
 =

 	if (test_and_clear_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->flags))
-		__mptcp_clean_una(sk);
+		__mptcp_clean_una_wakeup(sk);
 	if (test_and_clear_bit(MPTCP_ERROR_REPORT, &mptcp_sk(sk)->flags))
 		__mptcp_error_report(sk);
 =

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 5d7f940bceac0..28182632fcffb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -121,12 +121,6 @@ reset_with_add_addr_timeout()
 		-j DROP
 }
 =

-for arg in "$@"; do
-	if [ "$arg" =3D "-c" ]; then
-		capture=3D1
-	fi
-done
-
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
@@ -250,6 +244,8 @@ do_transfer()
 		local_addr=3D"0.0.0.0"
 	fi
 =

+	local start
+	start=3D$(date +%s%3N)
 	ip netns exec ${listener_ns} $mptcp_connect -t $timeout -l -p $port \
 		-s ${srv_proto} ${local_addr} < "$sin" > "$sout" &
 	spid=3D$!
@@ -359,20 +355,43 @@ do_transfer()
 	wait $spid
 	rets=3D$?
 =

+	local stop
+	stop=3D$(date +%s%3N)
+
 	if [ $capture -eq 1 ]; then
 	    sleep 1
 	    kill $cappid
 	fi
 =

+	local duration
+	duration=3D$((stop-start))
+	printf "(duration %05sms) " "${duration}"
+
+	NSTAT_HISTORY=3D/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
+		nstat | grep Tcp > /tmp/${listener_ns}.out
+	if [ ${listener_ns} !=3D ${connector_ns} ]; then
+		NSTAT_HISTORY=3D/tmp/${connector_ns}.nstat ip netns exec ${connector_ns}=
 \
+			| grep Tcp > /tmp/${connector_ns}.out
+	fi
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${listener_ns} ss -nita 1>&2 -o "sport =3D :$port"
+		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport =3D :$port"
+		cat /tmp/${listener_ns}.out
+
 		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${connector_ns} ss -nita 1>&2 -o "dport =3D :$port"
+		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport =3D :$port"
+		[ ${listener_ns} !=3D ${connector_ns} ] && cat /tmp/${connector_ns}.out
 =

 		cat "$capout"
 		ret=3D1
+		check_transfer $sin $cout "file received by client"
+		retc=3D$?
+		if [ "$test_link_fail" -eq 0 ];then
+			check_transfer $cin $sout "file received by server"
+		else
+			check_transfer $cinsent $sout "file received by server"
+		fi
 		return 1
 	fi
 =

@@ -1323,7 +1342,8 @@ usage()
 	echo "  -4 v4mapped_tests"
 	echo "  -b backup_tests"
 	echo "  -p add_addr_ports_tests"
-	echo "  -c syncookies_tests"
+	echo "  -S syncookies_tests"
+	echo "  -c capture pcap traces for all tests"
 	echo "  -h help"
 }
 =

@@ -1342,7 +1362,7 @@ if [ -z $1 ]; then
 	exit $ret
 fi
 =

-while getopts 'fsltra64bpch' opt; do
+while getopts 'fsltra64bpSch' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1374,9 +1394,12 @@ while getopts 'fsltra64bpch' opt; do
 		p)
 			add_addr_ports_tests
 			;;
-		c)
+		S)
 			syncookies_tests
 			;;
+		c)
+			capture=3D1
+			;;
 		h | *)
 			usage
 			;;
-- =

2.26.2

--===============3938722100974150023==--
