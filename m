Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3189D1373
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 21:35:07 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id lw4so7004504ejb.12
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AHKjjsNy+Cm80cELdy1dV4rKQxXIKfx40jKXCVSHStU=;
        b=6YHtDE7fqMWbPbgV+WGwLII91fMp8TkgfKHQ4DaxJsbuSfR8gM63vaNup1EsP2ae6p
         v+DEC0pwr9rvO7CPCJVXIrebAprOEoeH8jGJ9MrNM/OWXRtMEUyHFjjEHu5AZC+ltd2c
         mPK4kb1Gr4h0VjD/Cpm9ZXDm9m98rK+lGyFpLEpJemkoP0j0APK+8kCMDcE1uYKuX9Le
         sYm8o2QbPkmMVPRRnAbgH1RGvs5w+3iTK7giz9k26kda/WPqbKLWmsOVhar3+ahuggUE
         uLD67hGai8c6uu6Yd8ZoO2jUqsP1px2vUGbJjzxUSg7q2kU04zDMT8Yvz3PKh5z3aCnc
         y6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AHKjjsNy+Cm80cELdy1dV4rKQxXIKfx40jKXCVSHStU=;
        b=nd5jWxMo00QDDVcGLwuAIVh8hNTeLYpfz5wS/qpW7K8KpksgHfNUBvgfFq6gkwIhIv
         8GXPLuwZ84jlbkvTEy+aomIoTN7fHo++A43UZFk97YqDqu43Pco0fuxlRt7F75hCUh0p
         ebKggeCQzhNOxCDIAj7WCDUSDvsRsvTe9LeVf2GzLSN4RsnSqXhbbpVufihl+bgqxNxu
         hHkXnU9pk7D1fuw7UTtMBmADiRsHFFjrbnNz0zk/ezohz9Nuw8O+/Y+Qik7UmraJ327w
         3Fj/RaSJa32ll0HIxmTWtfulYVkxQooZBqa7tCra5DdBqnm4Do8RGYvyhBNeZ19fbqer
         H7rA==
X-Gm-Message-State: AOAM533qRtQdjic/jScXLz8mlB0BtmNCXLNSy9x/r+mMTcSeA5MdeuK8
	phh2vpYO0Jrf08vEB6pN7/s0wfDbeBDWS/DRcAE=
X-Google-Smtp-Source: ABdhPJyWaIs2lt4NJZfezBtdQbtnwTAGm6Op9QN9/OIAXWXqolTGPwOwevbd923gtSznHBNliRfMSA==
X-Received: by 2002:a17:906:231a:b0:6cf:276a:e838 with SMTP id l26-20020a170906231a00b006cf276ae838mr3719633eja.412.1645738505264;
        Thu, 24 Feb 2022 13:35:05 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090655d600b006d229436793sm175195ejp.223.2022.02.24.13.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 13:35:04 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v4 11/12] selftests: mptcp: join: avoid backquotes
Date: Thu, 24 Feb 2022 22:34:05 +0100
Message-Id: <20220224213406.3127061-12-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224213406.3127061-1-matthieu.baerts@tessares.net>
References: <20220224213406.3127061-1-matthieu.baerts@tessares.net>
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
index 869d021ef30b..9ff5de1098d6 100755
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
@@ -1027,7 +1027,7 @@ chk_csum_nr()
 		echo -n "   "
 	fi
 	printf " %-36s %s" "$msg" "sum"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != $csum_ns1 -a $allow_multi_errors_ns1 -eq 0 ] ||
 	   [ "$count" -lt $csum_ns1 -a $allow_multi_errors_ns1 -eq 1 ]; then
@@ -1038,7 +1038,7 @@ chk_csum_nr()
 		echo -n "[ ok ]"
 	fi
 	echo -n " - csum  "
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
+	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != $csum_ns2 -a $allow_multi_errors_ns2 -eq 0 ] ||
 	   [ "$count" -lt $csum_ns2 -a $allow_multi_errors_ns2 -eq 1 ]; then
@@ -1059,7 +1059,7 @@ chk_fail_nr()
 	local dump_stats
 
 	printf "%-${nr_blank}s %s" " " "ftx"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$fail_tx" ]; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
@@ -1070,7 +1070,7 @@ chk_fail_nr()
 	fi
 
 	echo -n " - failrx"
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}'`
+	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$fail_rx" ]; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
@@ -1212,7 +1212,7 @@ chk_join_nr()
 	fi
 
 	printf "%03u %-36s %s" "${TEST_COUNT}" "${title}" "syn"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$syn_nr" ]; then
 		echo "[fail] got $count JOIN[s] syn expected $syn_nr"
@@ -1223,8 +1223,8 @@ chk_join_nr()
 	fi
 
 	echo -n " - synack"
-	with_cookie=`ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies`
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}'`
+	with_cookie=$(ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies)
+	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$syn_ack_nr" ]; then
 		# simult connections exceeding the limit with cookie enabled could go up to
@@ -1242,7 +1242,7 @@ chk_join_nr()
 	fi
 
 	echo -n " - ack"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinAckRx | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinAckRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$ack_nr" ]; then
 		echo "[fail] got $count JOIN[s] ack expected $ack_nr"
@@ -1276,9 +1276,9 @@ chk_stale_nr()
 	local recover_nr
 
 	printf "%-${nr_blank}s %-18s" " " "stale"
-	stale_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk '{print $2}'`
+	stale_nr=$(ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk '{print $2}')
 	[ -z "$stale_nr" ] && stale_nr=0
-	recover_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover | awk '{print $2}'`
+	recover_nr=$(ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover | awk '{print $2}')
 	[ -z "$recover_nr" ] && recover_nr=0
 
 	if [ $stale_nr -lt $stale_min ] ||
@@ -1314,10 +1314,10 @@ chk_add_nr()
 	local dump_stats
 	local timeout
 
-	timeout=`ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout`
+	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
 	printf "%-${nr_blank}s %s" " " "add"
-	count=`ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}'`
+	count=$(ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}')
 	[ -z "$count" ] && count=0
 
 	# if the test configured a short timeout tolerate greater then expected
@@ -1331,7 +1331,7 @@ chk_add_nr()
 	fi
 
 	echo -n " - echo  "
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtEchoAdd | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtEchoAdd | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$echo_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
@@ -1343,7 +1343,7 @@ chk_add_nr()
 
 	if [ $port_nr -gt 0 ]; then
 		echo -n " - pt "
-		count=`ip netns exec $ns2 nstat -as | grep MPTcpExtPortAdd | awk '{print $2}'`
+		count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtPortAdd | awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$port_nr" ]; then
 			echo "[fail] got $count ADD_ADDR[s] with a port-number expected $port_nr"
@@ -1354,8 +1354,8 @@ chk_add_nr()
 		fi
 
 		printf "%-${nr_blank}s %s" " " "syn"
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a different \
@@ -1367,8 +1367,8 @@ chk_add_nr()
 		fi
 
 		echo -n " - synack"
-		count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinPortSynAckRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinPortSynAckRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$syn_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] synack with a different \
@@ -1380,8 +1380,8 @@ chk_add_nr()
 		fi
 
 		echo -n " - ack"
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortAckRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortAckRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a different \
@@ -1393,8 +1393,8 @@ chk_add_nr()
 		fi
 
 		printf "%-${nr_blank}s %s" " " "syn"
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortSynRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortSynRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$mis_syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a mismatched \
@@ -1406,8 +1406,8 @@ chk_add_nr()
 		fi
 
 		echo -n " - ack   "
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortAckRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortAckRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$mis_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a mismatched \
@@ -1453,7 +1453,7 @@ chk_rm_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "rm "
-	count=`ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{print $2}'`
+	count=$(ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
@@ -1464,7 +1464,7 @@ chk_rm_nr()
 	fi
 
 	echo -n " - rmsf  "
-	count=`ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}'`
+	count=$(ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ -n "$simult" ]; then
 		local cnt=$(ip netns exec $addr_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}')
@@ -1506,7 +1506,7 @@ chk_prio_nr()
 	local dump_stats
 
 	printf "%-${nr_blank}s %s" " " "ptx"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_prio_nr_tx" ]; then
 		echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
@@ -1517,7 +1517,7 @@ chk_prio_nr()
 	fi
 
 	echo -n " - prx   "
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_prio_nr_rx" ]; then
 		echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
@@ -1536,8 +1536,10 @@ chk_link_usage()
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

