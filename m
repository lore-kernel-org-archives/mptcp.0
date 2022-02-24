Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5681B62
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:56:53 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id z22so2983757edd.1
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 05:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S3Jrr7A6MiE8JCHkBT/ROfwZdMN2UJR8MM2XF951x4s=;
        b=62ZqmZ+0jj3Wj+F5BvyPo8cS/KRfdv4fhNFDGk4P10nCJVVEx2yBwLm/NkMvQgwIVx
         9yEfGgmSVtcxtKNokz7ZaEcT9zgVB7ihWMhLRAsrPYGja40Wx6tWhHiVQYf3UIHkkSv2
         E7BTkGjbEPN9vw31FX4fTfCbBYxoc+7fS4yIwGFJDCQxPbYYlzWMaDtbjLnus/PCrtlz
         lCdLgfjwGhoouqhbyIYuqQIYuAo2h1qfkZ85HgPDNTO5rJa66V9CRBitfZuuXOgXdgAc
         8T7NRKH7nx/Rn2/D33hkM5UkGpG9jBcH/NccglyLMIYZbmUaYaBWOuOSnVJ08t5Tz1gD
         JNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3Jrr7A6MiE8JCHkBT/ROfwZdMN2UJR8MM2XF951x4s=;
        b=WBcAPAr3ONiFEL4BD/MAsDuLGMrJIp55qROtcjOBndln4TvrGjLxsrPMMGW1eQ+uQz
         Sw13Fwx3Bpq81i9lAHF87k1cl5io8LpCGi375LKpFrWQp+/e/O05Xy5Y3E7Sn5+6AIZ4
         QrYrdtWnPcIkLhfygqElV0+1QKRcGOVxJqBttYVhQZ1YQSTkIUZbLu+7WfHR1/NgWcMP
         e4M5B0dU8Qj5bHy1HUHkiWJBj7qI0zvaeboMOm9mTnDfnHCC7wgnvIQc/tUknUDKmFM7
         Rxv3NOelMZ0vwenrCTS7OVGK9ay2dD2/JndP9qKIbmw0oM9RUnpAPXVXencv9UY6/dz9
         qvvA==
X-Gm-Message-State: AOAM532VkK1GJkdsm1IWaSy9+LItTWEWsNrLnMshnjNqFUtX2z2z6snr
	Uw2SzmWVn0frX9C7UFzdnrNxiDAbkUqZ4MXRu4I=
X-Google-Smtp-Source: ABdhPJzlsQGeNaoE7oVDbM4zraMKy9ySvVWThmekyDXrXtdsrbJ1E3DOzvAn+XA/rNm8inxf7Nufpw==
X-Received: by 2002:a05:6402:35c8:b0:410:dd43:3c09 with SMTP id z8-20020a05640235c800b00410dd433c09mr2414464edc.256.1645711011767;
        Thu, 24 Feb 2022 05:56:51 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm1360733edw.37.2022.02.24.05.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:56:51 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v3 10/12] selftests: mptcp: join: avoid backquotes
Date: Thu, 24 Feb 2022 14:56:17 +0100
Message-Id: <20220224135619.2523272-11-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224135619.2523272-1-matthieu.baerts@tessares.net>
References: <20220224135619.2523272-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As explained on ShellCheck's wiki [1], it is recommended to avoid
backquotes `...` in favour of parenthesis $(...):

> Backtick command substitution `...` is legacy syntax with several
> issues.
>
> - It has a series of undefined behaviors related to quoting in POSIX.
> - It imposes a custom escaping mode with surprising results.
> - It's exceptionally hard to nest.
>
> $(...) command substitution has none of these problems, and is
> therefore strongly encouraged.

[1] https://www.shellcheck.net/wiki/SC2006

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 66 ++++++++++---------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f5e17cd2a7df..f61c3804f5e0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -84,7 +84,7 @@ init_partial()
 	# ns1eth4    ns2eth4
 
 	local i
-	for i in `seq 1 4`; do
+	for i in $(seq 1 4); do
 		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns2"
 		ip -net "$ns1" addr add 10.0.$i.1/24 dev ns1eth$i
 		ip -net "$ns1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
@@ -103,7 +103,7 @@ init_partial()
 init_shapers()
 {
 	local i
-	for i in `seq 1 4`; do
+	for i in $(seq 1 4); do
 		tc -n $ns1 qdisc add dev ns1eth$i root netem rate 20mbit delay 1
 		tc -n $ns2 qdisc add dev ns2eth$i root netem rate 20mbit delay 1
 	done
@@ -1014,7 +1014,7 @@ chk_csum_nr()
 		echo -n "   "
 	fi
 	printf " %-36s %s" "$msg" "sum"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != $csum_ns1 -a $allow_multi_errors_ns1 -eq 0 ] ||
 	   [ "$count" -lt $csum_ns1 -a $allow_multi_errors_ns1 -eq 1 ]; then
@@ -1025,7 +1025,7 @@ chk_csum_nr()
 		echo -n "[ ok ]"
 	fi
 	echo -n " - csum  "
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
+	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != $csum_ns2 -a $allow_multi_errors_ns2 -eq 0 ] ||
 	   [ "$count" -lt $csum_ns2 -a $allow_multi_errors_ns2 -eq 1 ]; then
@@ -1046,7 +1046,7 @@ chk_fail_nr()
 	local dump_stats
 
 	printf "%-${nr_blank}s %s" " " "ftx"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$fail_tx" ]; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
@@ -1057,7 +1057,7 @@ chk_fail_nr()
 	fi
 
 	echo -n " - failrx"
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}'`
+	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$fail_rx" ]; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
@@ -1199,7 +1199,7 @@ chk_join_nr()
 	fi
 
 	printf "%03u %-36s %s" "${TEST_COUNT}" "${title}" "syn"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$syn_nr" ]; then
 		echo "[fail] got $count JOIN[s] syn expected $syn_nr"
@@ -1210,8 +1210,8 @@ chk_join_nr()
 	fi
 
 	echo -n " - synack"
-	with_cookie=`ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies`
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}'`
+	with_cookie=$(ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies)
+	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$syn_ack_nr" ]; then
 		# simult connections exceeding the limit with cookie enabled could go up to
@@ -1229,7 +1229,7 @@ chk_join_nr()
 	fi
 
 	echo -n " - ack"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinAckRx | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinAckRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$ack_nr" ]; then
 		echo "[fail] got $count JOIN[s] ack expected $ack_nr"
@@ -1263,9 +1263,9 @@ chk_stale_nr()
 	local recover_nr
 
 	printf "%-${nr_blank}s %-18s" " " "stale"
-	stale_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk '{print $2}'`
+	stale_nr=$(ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk '{print $2}')
 	[ -z "$stale_nr" ] && stale_nr=0
-	recover_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover | awk '{print $2}'`
+	recover_nr=$(ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover | awk '{print $2}')
 	[ -z "$recover_nr" ] && recover_nr=0
 
 	if [ $stale_nr -lt $stale_min ] ||
@@ -1301,10 +1301,10 @@ chk_add_nr()
 	local dump_stats
 	local timeout
 
-	timeout=`ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout`
+	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
 	printf "%-${nr_blank}s %s" " " "add"
-	count=`ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}'`
+	count=$(ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}')
 	[ -z "$count" ] && count=0
 
 	# if the test configured a short timeout tolerate greater then expected
@@ -1318,7 +1318,7 @@ chk_add_nr()
 	fi
 
 	echo -n " - echo  "
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtEchoAdd | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtEchoAdd | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$echo_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
@@ -1330,7 +1330,7 @@ chk_add_nr()
 
 	if [ $port_nr -gt 0 ]; then
 		echo -n " - pt "
-		count=`ip netns exec $ns2 nstat -as | grep MPTcpExtPortAdd | awk '{print $2}'`
+		count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtPortAdd | awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$port_nr" ]; then
 			echo "[fail] got $count ADD_ADDR[s] with a port-number expected $port_nr"
@@ -1341,8 +1341,8 @@ chk_add_nr()
 		fi
 
 		printf "%-${nr_blank}s %s" " " "syn"
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a different \
@@ -1354,8 +1354,8 @@ chk_add_nr()
 		fi
 
 		echo -n " - synack"
-		count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinPortSynAckRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinPortSynAckRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$syn_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] synack with a different \
@@ -1367,8 +1367,8 @@ chk_add_nr()
 		fi
 
 		echo -n " - ack"
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortAckRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortAckRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a different \
@@ -1380,8 +1380,8 @@ chk_add_nr()
 		fi
 
 		printf "%-${nr_blank}s %s" " " "syn"
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortSynRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortSynRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$mis_syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a mismatched \
@@ -1393,8 +1393,8 @@ chk_add_nr()
 		fi
 
 		echo -n " - ack   "
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortAckRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortAckRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$mis_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a mismatched \
@@ -1440,7 +1440,7 @@ chk_rm_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "rm "
-	count=`ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{print $2}'`
+	count=$(ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
@@ -1451,7 +1451,7 @@ chk_rm_nr()
 	fi
 
 	echo -n " - rmsf  "
-	count=`ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}'`
+	count=$(ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ -n "$simult" ]; then
 		local cnt=$(ip netns exec $addr_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}')
@@ -1493,7 +1493,7 @@ chk_prio_nr()
 	local dump_stats
 
 	printf "%-${nr_blank}s %s" " " "ptx"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_prio_nr_tx" ]; then
 		echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
@@ -1504,7 +1504,7 @@ chk_prio_nr()
 	fi
 
 	echo -n " - prx   "
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_prio_nr_rx" ]; then
 		echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
@@ -1523,8 +1523,10 @@ chk_link_usage()
 	local link=$2
 	local out=$3
 	local expected_rate=$4
-	local tx_link=`ip netns exec $ns cat /sys/class/net/$link/statistics/tx_bytes`
-	local tx_total=`ls -l $out | awk '{print $5}'`
+
+	local tx_link tx_total
+	tx_link=$(ip netns exec $ns cat /sys/class/net/$link/statistics/tx_bytes)
+	tx_total=$(ls -l $out | awk '{print $5}')
 	local tx_rate=$((tx_link * 100 / $tx_total))
 	local tolerance=5
 
-- 
2.34.1

