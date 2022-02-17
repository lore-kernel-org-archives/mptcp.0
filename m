Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C5436C
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 17:43:54 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id o24so10362200wro.3
        for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 09:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+adziSvF41I6atlt1Z2ldiJMMCyHoUkso8xyREXLgOc=;
        b=BoxMJnSFuuqCFNPisgtaAOjFsLFDwjJ92FgRrj5x98M+Wog7/6Uu3AxF3ulC0dfBdL
         0JB369mXwn3kxelhKH+EsPuxnL68H5Zy+FB8Tz8IjgIPMs/NQ5GTIj9ly4ZhVHuVKmsR
         ABHjB+cJbUYJvCZEgE+uPjILhI9N7LKdFSl7uBhGQCGmJW1449ushlv+3Xms+58WW9lQ
         uZhlTZ4Ia8Psl55c2KM7ga8jPQD21iEF8VtayS2JszFnYBZqZC+PzxARhKWQlZflYCSd
         ihTg79Gzd9us/EtMucaqc9nuT8uoda2g7Vkt/+M2/x37MWw3PLVL8RMTwyr7c8Xuhcb/
         Helg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+adziSvF41I6atlt1Z2ldiJMMCyHoUkso8xyREXLgOc=;
        b=RSREjAdMpPCwBICU7o2FUOGinxyeftBJRe4xYH9UXjOkaNE915ML/gHjaEHSxLtrHL
         VVN9wIETXymFJjBx/oxU8eBYQo1I6yI+6BQsFYVVazxt4UOuWl6D7R8ryb1+hkyuuI7Q
         72GFTTdCUKHxt5UC0ljuzNTL0CdP0yEWlPeenl6X4RJsGgGnVPeIxnA8mi1eao90z8aQ
         2wgdhreDwBknAFPWw2zzvCbttOGkL051dW35PeKnN0ryGDH5Qbol0IgEEBYMizfC+zaH
         4WaUa0QSW4/CfCM4QZCOtz2G0qG3OKG1uiNr6h/JH+YYyk5mbiPG7jp+Vi66FRS+31TU
         aNsQ==
X-Gm-Message-State: AOAM531t2enqeSXnREvq1lBuel289ciF+q4xgE9RNUxcyPWFq6vUNwGF
	y/PvVm2wVgTfruhvKnH8DXmm9fiZvsLe4Wh1
X-Google-Smtp-Source: ABdhPJy/BK64PYpQo6Jqpf5+FuEGf2zVQbfG0tEdB4a5Is6K8/4hqpkvEX7frsoZYqTGt9GRtVIr4g==
X-Received: by 2002:adf:f34d:0:b0:1e3:3e54:cc96 with SMTP id e13-20020adff34d000000b001e33e54cc96mr3129361wrp.84.1645119832542;
        Thu, 17 Feb 2022 09:43:52 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm23060203wrb.43.2022.02.17.09.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 09:43:51 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 8/9] selftests: mptcp: join: avoid backquotes
Date: Thu, 17 Feb 2022 18:43:28 +0100
Message-Id: <20220217174329.826430-9-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217174329.826430-1-matthieu.baerts@tessares.net>
References: <20220217174329.826430-1-matthieu.baerts@tessares.net>
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

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 70 ++++++++++---------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ccd7d900c9f1..78d8bc1beb25 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -83,7 +83,7 @@ init_partial()
 	# ns1eth4    ns2eth4
 
 	local i
-	for i in `seq 1 4`; do
+	for i in $(seq 1 4); do
 		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns2"
 		ip -net "$ns1" addr add 10.0.$i.1/24 dev ns1eth$i
 		ip -net "$ns1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
@@ -102,7 +102,7 @@ init_partial()
 init_shapers()
 {
 	local i
-	for i in `seq 1 4`; do
+	for i in $(seq 1 4); do
 		tc -n $ns1 qdisc add dev ns1eth$i root netem rate 20mbit delay 1
 		tc -n $ns2 qdisc add dev ns2eth$i root netem rate 20mbit delay 1
 	done
@@ -834,7 +834,7 @@ chk_csum_nr()
 		echo -n "   "
 	fi
 	printf " %-36s %s" "$msg" "sum"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != 0 ]; then
 		echo "[fail] got $count data checksum error[s] expected 0"
@@ -844,7 +844,7 @@ chk_csum_nr()
 		echo -n "[ ok ]"
 	fi
 	echo -n " - csum  "
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
+	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != 0 ]; then
 		echo "[fail] got $count data checksum error[s] expected 0"
@@ -864,7 +864,7 @@ chk_fail_nr()
 	local dump_stats
 
 	printf "%-${nr_blank}s %s" " " "ftx"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_fail_nr_tx" ]; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $mp_fail_nr_tx"
@@ -875,7 +875,7 @@ chk_fail_nr()
 	fi
 
 	echo -n " - frx   "
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}'`
+	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_fail_nr_rx" ]; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $mp_fail_nr_rx"
@@ -896,7 +896,7 @@ chk_infi_nr()
 	local dump_stats
 
 	printf "%-${nr_blank}s %s" " " "itx"
-	count=`ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print $2}'`
+	count=$(ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_infi_nr_tx" ]; then
 		echo "[fail] got $count infinite map[s] TX expected $mp_infi_nr_tx"
@@ -907,7 +907,7 @@ chk_infi_nr()
 	fi
 
 	echo -n " - irx   "
-	count=`ip netns exec $ns1 nstat -as | grep InfiniteMapRx | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep InfiniteMapRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_infi_nr_rx" ]; then
 		echo "[fail] got $count infinite map[s] RX expected $mp_infi_nr_rx"
@@ -930,7 +930,7 @@ chk_join_nr()
 	local with_cookie
 
 	printf "%03u %-36s %s" "${TEST_COUNT}" "${TEST_NAME}" "syn"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$syn_nr" ]; then
 		echo "[fail] got $count JOIN[s] syn expected $syn_nr"
@@ -941,8 +941,8 @@ chk_join_nr()
 	fi
 
 	echo -n " - synack"
-	with_cookie=`ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies`
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}'`
+	with_cookie=$(ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies)
+	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$syn_ack_nr" ]; then
 		# simult connections exceeding the limit with cookie enabled could go up to
@@ -960,7 +960,7 @@ chk_join_nr()
 	fi
 
 	echo -n " - ack"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinAckRx | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinAckRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$ack_nr" ]; then
 		echo "[fail] got $count JOIN[s] ack expected $ack_nr"
@@ -993,9 +993,9 @@ chk_stale_nr()
 	local recover_nr
 
 	printf "%-${nr_blank}s %-18s" " " "stale"
-	stale_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk '{print $2}'`
+	stale_nr=$(ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk '{print $2}')
 	[ -z "$stale_nr" ] && stale_nr=0
-	recover_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover | awk '{print $2}'`
+	recover_nr=$(ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover | awk '{print $2}')
 	[ -z "$recover_nr" ] && recover_nr=0
 
 	if [ $stale_nr -lt $stale_min ] ||
@@ -1031,10 +1031,10 @@ chk_add_nr()
 	local dump_stats
 	local timeout
 
-	timeout=`ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout`
+	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
 	printf "%-${nr_blank}s %s" " " "add"
-	count=`ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}'`
+	count=$(ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}')
 	[ -z "$count" ] && count=0
 
 	# if the test configured a short timeout tolerate greater then expected
@@ -1048,7 +1048,7 @@ chk_add_nr()
 	fi
 
 	echo -n " - echo  "
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtEchoAdd | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtEchoAdd | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$echo_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
@@ -1060,7 +1060,7 @@ chk_add_nr()
 
 	if [ $port_nr -gt 0 ]; then
 		echo -n " - pt "
-		count=`ip netns exec $ns2 nstat -as | grep MPTcpExtPortAdd | awk '{print $2}'`
+		count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtPortAdd | awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$port_nr" ]; then
 			echo "[fail] got $count ADD_ADDR[s] with a port-number expected $port_nr"
@@ -1071,8 +1071,8 @@ chk_add_nr()
 		fi
 
 		printf "%-${nr_blank}s %s" " " "syn"
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a different \
@@ -1084,8 +1084,8 @@ chk_add_nr()
 		fi
 
 		echo -n " - synack"
-		count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinPortSynAckRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinPortSynAckRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$syn_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] synack with a different \
@@ -1097,8 +1097,8 @@ chk_add_nr()
 		fi
 
 		echo -n " - ack"
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortAckRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortAckRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a different \
@@ -1110,8 +1110,8 @@ chk_add_nr()
 		fi
 
 		printf "%-${nr_blank}s %s" " " "syn"
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortSynRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortSynRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$mis_syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a mismatched \
@@ -1123,8 +1123,8 @@ chk_add_nr()
 		fi
 
 		echo -n " - ack   "
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortAckRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortAckRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$mis_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a mismatched \
@@ -1160,7 +1160,7 @@ chk_rm_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "rm "
-	count=`ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{print $2}'`
+	count=$(ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
@@ -1171,7 +1171,7 @@ chk_rm_nr()
 	fi
 
 	echo -n " - sf    "
-	count=`ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}'`
+	count=$(ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rm_subflow_nr" ]; then
 		echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
@@ -1192,7 +1192,7 @@ chk_prio_nr()
 	local dump_stats
 
 	printf "%-${nr_blank}s %s" " " "ptx"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_prio_nr_tx" ]; then
 		echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
@@ -1203,7 +1203,7 @@ chk_prio_nr()
 	fi
 
 	echo -n " - prx   "
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}'`
+	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_prio_nr_rx" ]; then
 		echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
@@ -1222,8 +1222,10 @@ chk_link_usage()
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

