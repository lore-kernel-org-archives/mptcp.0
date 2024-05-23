Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8A313C9C0
	for <mptcp@lists.linux.dev>; Thu, 23 May 2024 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451749; cv=none; b=ba2mAUd4a0QQVoDcx77sZWv+6EkwBVJ3Addh8znVIr4ZCdGrtuM+Mw8uKAtZXHiJ6bhHBis4CpEjkgCc9hYpOyS7PlB13N2Lte5Pgh67hXbiSEfSIAAc+EkFz5tNB1iQVXJEv9ryZSbnJA/ncL5m1YPyWvRWhhxR1iUb3xJGdag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451749; c=relaxed/simple;
	bh=Due/G7Ua3ODM0XvZmz7UKCbv/uG+4mq5OCRG2kxb7wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1Zh+GK92XvVqBvGwEKaoV1XSoVWW3ocO4pY60yO5IknprQI7aL45ulKIz+yVdQ5CD3xN2Md/7rm1jrZLuumzTivuiUJeNT6sAdfUDAmcUcs6zbYO6OFVHpl9iYUSjvUi/9vWWdUzLCj5+v12n5yHOJu++6IgBlNfQJOwe/xwRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDoUxkdf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDoUxkdf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE24C4AF0D;
	Thu, 23 May 2024 08:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716451748;
	bh=Due/G7Ua3ODM0XvZmz7UKCbv/uG+4mq5OCRG2kxb7wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lDoUxkdf7zT8w2gc3jvlF2OnjlVtVfY3Wfoo9WGe2EHBy9H6ypMC+yFE425STaBy9
	 tRBPTPv4c+FQ21X5uQ6dukwQva0fYLiw9XsaMXj72pDw0jvywrLvn+P7hW5/GbB/BX
	 YdxBBzj0W/y8q6IWP6SyyHHD/8kcRS5ZiWnidWk+nFLzMnEPcdAfmy0rf3kcGGzJSY
	 DZB99pzQU4ZCtuURAvAVoNE1qBu84h4k69tjjYDaghrf8JdGHR6uVh6u3xAza79klK
	 oPKnhm+6w8PFSQz+HVKVOScktT4TB53f8KKH3hXv+/tXdMYKpIvEL1N3Z/tK03TgO5
	 BZuJvZS83VmVw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/4] selftests: mptcp: rename ns to ns1 in diag.sh
Date: Thu, 23 May 2024 16:08:57 +0800
Message-ID: <8ba084333877b94a5675d7a6c8b855c4505956d2.1716451525.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716451525.git.tanggeliang@kylinos.cn>
References: <cover.1716451525.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The next commit will use setup_ns() helper defined in lib.sh instead
of mptcp helper mptcp_lib_ns_init(). But the namespace "ns" in diag.sh
makes it not working. Since "ns" is a local variable in this helper.
So this patch renames it as "ns1".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh | 58 +++++++++++------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 776d43a6922d..eec1f04d231f 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -8,7 +8,7 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-ns=""
+ns1=""
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 ret=0
@@ -19,10 +19,10 @@ flush_pids()
 	# give it some time
 	sleep 1.1
 
-	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGUSR1 &>/dev/null
+	ip netns pids "${ns1}" | xargs --no-run-if-empty kill -SIGUSR1 &>/dev/null
 
 	for _ in $(seq $((timeout_poll * 10))); do
-		[ -z "$(ip netns pids "${ns}")" ] && break
+		[ -z "$(ip netns pids "${ns1}")" ] && break
 		sleep 0.1
 	done
 }
@@ -31,9 +31,9 @@ flush_pids()
 #shellcheck disable=SC2317
 cleanup()
 {
-	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
+	ip netns pids "${ns1}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
 
-	mptcp_lib_ns_exit "${ns}"
+	mptcp_lib_ns_exit "${ns1}"
 }
 
 mptcp_lib_check_mptcp
@@ -41,7 +41,7 @@ mptcp_lib_check_tools ip ss
 
 get_msk_inuse()
 {
-	ip netns exec $ns cat /proc/net/protocols | awk '$1~/^MPTCP$/{print $3}'
+	ip netns exec $ns1 cat /proc/net/protocols | awk '$1~/^MPTCP$/{print $3}'
 }
 
 __chk_nr()
@@ -75,7 +75,7 @@ __chk_msk_nr()
 	local condition=$1
 	shift 1
 
-	__chk_nr "ss -inmHMN $ns | $condition" "$@"
+	__chk_nr "ss -inmHMN $ns1 | $condition" "$@"
 }
 
 chk_msk_nr()
@@ -88,8 +88,8 @@ chk_listener_nr()
 	local expected=$1
 	local msg="$2"
 
-	__chk_nr "ss -nlHMON $ns | wc -l" "$expected" "$msg - mptcp" 0
-	__chk_nr "ss -nlHtON $ns | wc -l" "$expected" "$msg - subflows"
+	__chk_nr "ss -nlHMON $ns1 | wc -l" "$expected" "$msg - mptcp" 0
+	__chk_nr "ss -nlHtON $ns1 | wc -l" "$expected" "$msg - subflows"
 }
 
 wait_msk_nr()
@@ -105,7 +105,7 @@ wait_msk_nr()
 	msg=$*
 
 	while [ $i -lt $timeout ]; do
-		nr=$(ss -inmHMN $ns | $condition)
+		nr=$(ss -inmHMN $ns1 | $condition)
 		[ $nr == $expected ] && break;
 		[ $nr -gt $max ] && max=$nr
 		i=$((i + 1))
@@ -143,7 +143,7 @@ __chk_listen()
 	local expected=$2
 	local msg="$3"
 
-	__chk_nr "ss -N $ns -Ml '$filter' | grep -c LISTEN" "$expected" "$msg" 0
+	__chk_nr "ss -N $ns1 -Ml '$filter' | grep -c LISTEN" "$expected" "$msg" 0
 }
 
 chk_msk_listen()
@@ -173,7 +173,7 @@ chk_msk_inuse()
 		msg+=" after flush"
 	fi
 
-	listen_nr=$(ss -N "${ns}" -Ml | grep -c LISTEN)
+	listen_nr=$(ss -N "${ns1}" -Ml | grep -c LISTEN)
 	expected=$((expected + listen_nr))
 
 	for _ in $(seq 10); do
@@ -196,7 +196,7 @@ chk_msk_cestab()
 		msg+=" after flush"
 	fi
 
-	__chk_nr "mptcp_lib_get_counter ${ns} MPTcpExtMPCurrEstab" \
+	__chk_nr "mptcp_lib_get_counter ${ns1} MPTcpExtMPCurrEstab" \
 		 "${expected}" "${msg}" ""
 }
 
@@ -205,7 +205,7 @@ msk_info_get_value()
 	local port="${1}"
 	local info="${2}"
 
-	ss -N "${ns}" -inHM dport "${port}" | \
+	ss -N "${ns1}" -inHM dport "${port}" | \
 		mptcp_lib_get_info_value "${info}" "${info}"
 }
 
@@ -267,23 +267,23 @@ wait_connected()
 }
 
 trap cleanup EXIT
-mptcp_lib_ns_init ns
+mptcp_lib_ns_init ns1
 
 echo "a" | \
 	timeout ${timeout_test} \
-		ip netns exec $ns \
+		ip netns exec $ns1 \
 			./mptcp_connect -p 10000 -l -t ${timeout_poll} -w 20 \
 				0.0.0.0 >/dev/null &
-mptcp_lib_wait_local_port_listen $ns 10000
+mptcp_lib_wait_local_port_listen $ns1 10000
 chk_msk_nr 0 "no msk on netns creation"
 chk_msk_listen 10000
 
 echo "b" | \
 	timeout ${timeout_test} \
-		ip netns exec $ns \
+		ip netns exec $ns1 \
 			./mptcp_connect -p 10000 -r 0 -t ${timeout_poll} -w 20 \
 				127.0.0.1 >/dev/null &
-wait_connected $ns 10000
+wait_connected $ns1 10000
 chk_msk_nr 2 "after MPC handshake "
 chk_last_time_info 10000
 chk_msk_remote_key_nr 2 "....chk remote_key"
@@ -297,16 +297,16 @@ chk_msk_cestab 0 "2->0"
 
 echo "a" | \
 	timeout ${timeout_test} \
-		ip netns exec $ns \
+		ip netns exec $ns1 \
 			./mptcp_connect -p 10001 -l -s TCP -t ${timeout_poll} -w 20 \
 				0.0.0.0 >/dev/null &
-mptcp_lib_wait_local_port_listen $ns 10001
+mptcp_lib_wait_local_port_listen $ns1 10001
 echo "b" | \
 	timeout ${timeout_test} \
-		ip netns exec $ns \
+		ip netns exec $ns1 \
 			./mptcp_connect -p 10001 -r 0 -t ${timeout_poll} -w 20 \
 				127.0.0.1 >/dev/null &
-wait_connected $ns 10001
+wait_connected $ns1 10001
 chk_msk_fallback_nr 1 "check fallback"
 chk_msk_inuse 1
 chk_msk_cestab 1
@@ -319,16 +319,16 @@ NR_CLIENTS=100
 for I in $(seq 1 $NR_CLIENTS); do
 	echo "a" | \
 		timeout ${timeout_test} \
-			ip netns exec $ns \
+			ip netns exec $ns1 \
 				./mptcp_connect -p $((I+10001)) -l -w 20 \
 					-t ${timeout_poll} 0.0.0.0 >/dev/null &
 done
-mptcp_lib_wait_local_port_listen $ns $((NR_CLIENTS + 10001))
+mptcp_lib_wait_local_port_listen $ns1 $((NR_CLIENTS + 10001))
 
 for I in $(seq 1 $NR_CLIENTS); do
 	echo "b" | \
 		timeout ${timeout_test} \
-			ip netns exec $ns \
+			ip netns exec $ns1 \
 				./mptcp_connect -p $((I+10001)) -w 20 \
 					-t ${timeout_poll} 127.0.0.1 >/dev/null &
 done
@@ -344,16 +344,16 @@ chk_msk_cestab 0 "many->0"
 chk_listener_nr 0 "no listener sockets"
 NR_SERVERS=100
 for I in $(seq 1 $NR_SERVERS); do
-	ip netns exec $ns ./mptcp_connect -p $((I + 20001)) \
+	ip netns exec $ns1 ./mptcp_connect -p $((I + 20001)) \
 		-t ${timeout_poll} -l 0.0.0.0 >/dev/null 2>&1 &
 done
-mptcp_lib_wait_local_port_listen $ns $((NR_SERVERS + 20001))
+mptcp_lib_wait_local_port_listen $ns1 $((NR_SERVERS + 20001))
 
 chk_listener_nr $NR_SERVERS "many listener sockets"
 
 # graceful termination
 for I in $(seq 1 $NR_SERVERS); do
-	echo a | ip netns exec $ns ./mptcp_connect -p $((I + 20001)) 127.0.0.1 >/dev/null 2>&1 &
+	echo a | ip netns exec $ns1 ./mptcp_connect -p $((I + 20001)) 127.0.0.1 >/dev/null 2>&1 &
 done
 flush_pids
 
-- 
2.43.0

