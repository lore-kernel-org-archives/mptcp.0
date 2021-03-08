Content-Type: multipart/mixed; boundary="===============5428147469269686987=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] Squash to "selftests: mptcp: launch
 mptcp_connect with timeout"
Date: Mon, 08 Mar 2021 11:16:27 +0100
Message-ID: <20210308101627.2161839-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 8070

--===============5428147469269686987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In diag.sh, we want to send signals to mptcp_connect instances that have
been started in the netns. But we cannot send this signal to 'timeout'
otherwise that will stop the timeout and print something like:

  # ./diag.sh: line 1: 9536 Done echo a
  # 9537 User defined signal 1 | timeout ${timeout_test} ip netns (...)

Instead of trying to find the right PID and storing them in an array, we
can simply use the output of 'ip netns pids' and send a signal to all
these PIDs.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "selftests: mptcp: launch mptcp_connect with timeout"

 tools/testing/selftests/net/mptcp/diag.sh | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/self=
tests/net/mptcp/diag.sh
index 35846f89cdad..2674ba20d524 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -8,7 +8,6 @@ test_cnt=3D1
 timeout_poll=3D100
 timeout_test=3D$((timeout_poll * 2 + 1))
 ret=3D0
-pids=3D()
 =

 flush_pids()
 {
@@ -16,18 +15,14 @@ flush_pids()
 	# give it some time
 	sleep 1.1
 =

-	for pid in ${pids[@]}; do
-		[ -d /proc/$pid ] && kill -SIGUSR1 $pid >/dev/null 2>&1
-	done
-	pids=3D()
+	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGUSR1 &>/dev/null
 }
 =

 cleanup()
 {
+	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
+
 	ip netns del $ns
-	for pid in ${pids[@]}; do
-		[ -d /proc/$pid ] && kill -9 $pid >/dev/null 2>&1
-	done
 }
 =

 ip -Version > /dev/null 2>&1
@@ -87,7 +82,6 @@ echo "a" | \
 			./mptcp_connect -p 10000 -l -t ${timeout_poll} \
 				0.0.0.0 >/dev/null &
 sleep 0.1
-pids[0]=3D$!
 chk_msk_nr 0 "no msk on netns creation"
 =

 echo "b" | \
@@ -96,7 +90,6 @@ echo "b" | \
 			./mptcp_connect -p 10000 -j -t ${timeout_poll} \
 				127.0.0.1 >/dev/null &
 sleep 0.1
-pids[1]=3D$!
 chk_msk_nr 2 "after MPC handshake "
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
@@ -108,14 +101,12 @@ echo "a" | \
 		ip netns exec $ns \
 			./mptcp_connect -p 10001 -l -s TCP -t ${timeout_poll} \
 				0.0.0.0 >/dev/null &
-pids[0]=3D$!
 sleep 0.1
 echo "b" | \
 	timeout ${timeout_test} \
 		ip netns exec $ns \
 			./mptcp_connect -p 10001 -j -t ${timeout_poll} \
 				127.0.0.1 >/dev/null &
-pids[1]=3D$!
 sleep 0.1
 chk_msk_fallback_nr 1 "check fallback"
 flush_pids
@@ -127,7 +118,6 @@ for I in `seq 1 $NR_CLIENTS`; do
 			ip netns exec $ns \
 				./mptcp_connect -p $((I+10001)) -l -w 10 \
 					-t ${timeout_poll} 0.0.0.0 >/dev/null &
-	pids[$((I*2))]=3D$!
 done
 sleep 0.1
 =

@@ -137,7 +127,6 @@ for I in `seq 1 $NR_CLIENTS`; do
 			ip netns exec $ns \
 				./mptcp_connect -p $((I+10001)) -w 10 \
 					-t ${timeout_poll} 127.0.0.1 >/dev/null &
-	pids[$((I*2 + 1))]=3D$!
 done
 sleep 1.5
 =

-- =

2.30.0

--===============5428147469269686987==--
