Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBC22C80
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 21:25:52 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so2571467wml.5
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 13:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ve71QE+CKR2fEdrkxRcg9nDk3jNnHMgDgR1Zr5zelSQ=;
        b=xEDUPR+eA/AiFcTx486LAAag85asOdL5hiyUroDSbfliguxyx0oXxGnponNqEukEiZ
         MFu5wTVkYYF5UmdVXVPmontzNosRjiPXFIBSk/pS3e+Q/G5F4Y558keYFOUXvLb+2SI+
         O8NOeNyo78ndsjY0kwMxgFX1fsZf2/l74HFel8MA57C5n72AJbtn33opVsko72Zdv8Vl
         vGrruvS/5k6qijmwn6XdMKESMUOPxCML7P9ArDXJN5x04qjs3BjzGoUJY45tVHi40a+H
         2aVLeb2xzYbN1tH4L8orxHi9vOEb24fKaVWS4+/0Fxk4Zhg/Ia67ycogShDc8+aLN7W4
         Kx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ve71QE+CKR2fEdrkxRcg9nDk3jNnHMgDgR1Zr5zelSQ=;
        b=NDhMjeayBe+5g6zjzRC5ivW6A57d6LRp809HhxRSqzYekX3s1vz6c8qsHC5+CIoI79
         YVAgO0e+Td9LezGPr1vJNRGIOqt5iGK9soitLWJYESlYnVOledjK8PSg6appc9z5bF98
         PHGNIMtIBD4j+ePKgKE7j8strqJeo4IsN+QgeL44DWvZHdXJ5yi043YsccL/AWiKyC+h
         094E/kGcfgYStVpszcNqLQJ0hjXkn3i7ATcQXHkCbDs2jB9Nsla9GuNairQYCVnoFc6A
         vAOo9mgmtbGEZNmweJcjQb8h1uOd+L00KN0li8Gg7hVjlSyVf/CY4B85bYoeb/zMIId0
         hX1w==
X-Gm-Message-State: AOAM5315mCnuBmHoedFoYxgyJ0DlgtiefMgmjURBRqK50M9hfA6B0N6u
	zlN4czPHLPDgQuSxqCEmJUaXKSsl2/w2aTYa
X-Google-Smtp-Source: ABdhPJz5VJpof8m6KaSrnZqOmwQqD6Sbpoww1PD1WEdMyXKTqSCiiTPCpKKo1NnpDjqmkpIyHopFBA==
X-Received: by 2002:a7b:c778:: with SMTP id x24mr3778709wmk.11.1644441950804;
        Wed, 09 Feb 2022 13:25:50 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id p14sm18500730wrr.7.2022.02.09.13.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:25:50 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 8/9] selftests: mptcp: join: avoid backquotes
Date: Wed,  9 Feb 2022 22:25:19 +0100
Message-Id: <20220209212520.2989291-9-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
References: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
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
index 15e642e0fa03..c39d5b4e73cb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -75,7 +75,7 @@ init_partial()
 	# ns1eth4    ns2eth4
 
 	local i
-	for i in `seq 1 4`; do
+	for i in $(seq 1 4); do
 		ip link add ns1eth$i netns "$NS1" type veth peer name ns2eth$i netns "$NS2"
 		ip -net "$NS1" addr add 10.0.$i.1/24 dev ns1eth$i
 		ip -net "$NS1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
@@ -94,7 +94,7 @@ init_partial()
 init_shapers()
 {
 	local i
-	for i in `seq 1 4`; do
+	for i in $(seq 1 4); do
 		tc -n $NS1 qdisc add dev ns1eth$i root netem rate 20mbit delay 1
 		tc -n $NS2 qdisc add dev ns2eth$i root netem rate 20mbit delay 1
 	done
@@ -605,7 +605,7 @@ do_transfer()
 			else
 				addr="10.0.$counter.2"
 			fi
-			pm_nl_add_endpoint $ns2 $addr flags $flags
+			pm_nl_add_endpoint $NS2 $addr flags $flags
 			let counter+=1
 			let add_nr_ns2-=1
 		done
@@ -791,7 +791,7 @@ chk_csum_nr()
 		echo -n "   "
 	fi
 	printf " %-36s %s" "$msg" "sum"
-	count=`ip netns exec $NS1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
+	count=$(ip netns exec $NS1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != 0 ]; then
 		echo "[fail] got $count data checksum error[s] expected 0"
@@ -801,7 +801,7 @@ chk_csum_nr()
 		echo -n "[ ok ]"
 	fi
 	echo -n " - csum  "
-	count=`ip netns exec $NS2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
+	count=$(ip netns exec $NS2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != 0 ]; then
 		echo "[fail] got $count data checksum error[s] expected 0"
@@ -821,7 +821,7 @@ chk_fail_nr()
 	local dump_stats
 
 	printf "%-${NR_BLANK}s %s" " " "ftx"
-	count=`ip netns exec $NS1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}'`
+	count=$(ip netns exec $NS1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_fail_nr_tx" ]; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $mp_fail_nr_tx"
@@ -832,7 +832,7 @@ chk_fail_nr()
 	fi
 
 	echo -n " - frx   "
-	count=`ip netns exec $NS2 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}'`
+	count=$(ip netns exec $NS2 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_fail_nr_rx" ]; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $mp_fail_nr_rx"
@@ -853,7 +853,7 @@ chk_infi_nr()
 	local dump_stats
 
 	printf "%-${NR_BLANK}s %s" " " "itx"
-	count=`ip netns exec $NS2 nstat -as | grep InfiniteMapTx | awk '{print $2}'`
+	count=$(ip netns exec $NS2 nstat -as | grep InfiniteMapTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_infi_nr_tx" ]; then
 		echo "[fail] got $count infinite map[s] TX expected $mp_infi_nr_tx"
@@ -864,7 +864,7 @@ chk_infi_nr()
 	fi
 
 	echo -n " - irx   "
-	count=`ip netns exec $NS1 nstat -as | grep InfiniteMapRx | awk '{print $2}'`
+	count=$(ip netns exec $NS1 nstat -as | grep InfiniteMapRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_infi_nr_rx" ]; then
 		echo "[fail] got $count infinite map[s] RX expected $mp_infi_nr_rx"
@@ -887,7 +887,7 @@ chk_join_nr()
 	local dump_stats
 
 	printf "%03u %-36s %s" "$TEST_COUNT" "$msg" "syn"
-	count=`ip netns exec $NS1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}'`
+	count=$(ip netns exec $NS1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$syn_nr" ]; then
 		echo "[fail] got $count JOIN[s] syn expected $syn_nr"
@@ -898,7 +898,7 @@ chk_join_nr()
 	fi
 
 	echo -n " - synack"
-	count=`ip netns exec $NS2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}'`
+	count=$(ip netns exec $NS2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$syn_ack_nr" ]; then
 		echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
@@ -909,7 +909,7 @@ chk_join_nr()
 	fi
 
 	echo -n " - ack"
-	count=`ip netns exec $NS1 nstat -as | grep MPTcpExtMPJoinAckRx | awk '{print $2}'`
+	count=$(ip netns exec $NS1 nstat -as | grep MPTcpExtMPJoinAckRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$ack_nr" ]; then
 		echo "[fail] got $count JOIN[s] ack expected $ack_nr"
@@ -942,9 +942,9 @@ chk_stale_nr()
 	local recover_nr
 
 	printf "%-${NR_BLANK}s %-18s" " " "stale"
-	stale_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk '{print $2}'`
+	stale_nr=$(ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk '{print $2}')
 	[ -z "$stale_nr" ] && stale_nr=0
-	recover_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover | awk '{print $2}'`
+	recover_nr=$(ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover | awk '{print $2}')
 	[ -z "$recover_nr" ] && recover_nr=0
 
 	if [ $stale_nr -lt $stale_min ] ||
@@ -980,10 +980,10 @@ chk_add_nr()
 	local dump_stats
 	local timeout
 
-	timeout=`ip netns exec $NS1 sysctl -n net.mptcp.add_addr_timeout`
+	timeout=$(ip netns exec $NS1 sysctl -n net.mptcp.add_addr_timeout)
 
 	printf "%-${NR_BLANK}s %s" " " "add"
-	count=`ip netns exec $NS2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}'`
+	count=$(ip netns exec $NS2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}')
 	[ -z "$count" ] && count=0
 
 	# if the test configured a short timeout tolerate greater then expected
@@ -997,7 +997,7 @@ chk_add_nr()
 	fi
 
 	echo -n " - echo  "
-	count=`ip netns exec $NS1 nstat -as | grep MPTcpExtEchoAdd | awk '{print $2}'`
+	count=$(ip netns exec $NS1 nstat -as | grep MPTcpExtEchoAdd | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$echo_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
@@ -1009,7 +1009,7 @@ chk_add_nr()
 
 	if [ $port_nr -gt 0 ]; then
 		echo -n " - pt "
-		count=`ip netns exec $NS2 nstat -as | grep MPTcpExtPortAdd | awk '{print $2}'`
+		count=$(ip netns exec $NS2 nstat -as | grep MPTcpExtPortAdd | awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$port_nr" ]; then
 			echo "[fail] got $count ADD_ADDR[s] with a port-number expected $port_nr"
@@ -1020,8 +1020,8 @@ chk_add_nr()
 		fi
 
 		printf "%-${NR_BLANK}s %s" " " "syn"
-		count=`ip netns exec $NS1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $NS1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a different \
@@ -1033,8 +1033,8 @@ chk_add_nr()
 		fi
 
 		echo -n " - synack"
-		count=`ip netns exec $NS2 nstat -as | grep MPTcpExtMPJoinPortSynAckRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $NS2 nstat -as | grep MPTcpExtMPJoinPortSynAckRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$syn_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] synack with a different \
@@ -1046,8 +1046,8 @@ chk_add_nr()
 		fi
 
 		echo -n " - ack"
-		count=`ip netns exec $NS1 nstat -as | grep MPTcpExtMPJoinPortAckRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $NS1 nstat -as | grep MPTcpExtMPJoinPortAckRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a different \
@@ -1059,8 +1059,8 @@ chk_add_nr()
 		fi
 
 		printf "%-${NR_BLANK}s %s" " " "syn"
-		count=`ip netns exec $NS1 nstat -as | grep MPTcpExtMismatchPortSynRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $NS1 nstat -as | grep MPTcpExtMismatchPortSynRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$mis_syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a mismatched \
@@ -1072,8 +1072,8 @@ chk_add_nr()
 		fi
 
 		echo -n " - ack   "
-		count=`ip netns exec $NS1 nstat -as | grep MPTcpExtMismatchPortAckRx |
-			awk '{print $2}'`
+		count=$(ip netns exec $NS1 nstat -as | grep MPTcpExtMismatchPortAckRx |
+			awk '{print $2}')
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$mis_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a mismatched \
@@ -1109,7 +1109,7 @@ chk_rm_nr()
 	fi
 
 	printf "%-${NR_BLANK}s %s" " " "rm "
-	count=`ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{print $2}'`
+	count=$(ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
@@ -1120,7 +1120,7 @@ chk_rm_nr()
 	fi
 
 	echo -n " - sf    "
-	count=`ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}'`
+	count=$(ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rm_subflow_nr" ]; then
 		echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
@@ -1141,7 +1141,7 @@ chk_prio_nr()
 	local dump_stats
 
 	printf "%-${NR_BLANK}s %s" " " "ptx"
-	count=`ip netns exec $NS1 nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}'`
+	count=$(ip netns exec $NS1 nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_prio_nr_tx" ]; then
 		echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
@@ -1152,7 +1152,7 @@ chk_prio_nr()
 	fi
 
 	echo -n " - prx   "
-	count=`ip netns exec $NS1 nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}'`
+	count=$(ip netns exec $NS1 nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_prio_nr_rx" ]; then
 		echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
@@ -1171,8 +1171,10 @@ chk_link_usage()
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

