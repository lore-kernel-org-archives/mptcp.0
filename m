Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47BC134B0
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:30 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3093a7b71fbso6076785f8f.2
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773508; x=1687365508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Efk9cL7Xil38JdYUVreVMvnwva+BSm37z9DnJN1AKng=;
        b=jB+9QGuVTNE2l91aNgHaOYqMPR6fSZxLklbu//BExWIVJ+Aa3wcoehYjuvM/tY1y64
         RszRBVpERgStD/2pj2llYEylJlhWRd9/2Ooql0uLHFIdi2EXi1BKvKfP7oehLM61+kPW
         02IIn89uPHHbAVAla4KQve0UPBien8JBZWXnbeSvdJ/htXTs7gzQstxyQFyjI5Hq1pa6
         8/X1XjsVmrNCS8c7eaMQdJYlCqeCMLRAiMJJPoBFiTY+AfCfePsKGz0TMOw1xvn+KBwB
         lZOijJ4dMOMv9Noo4LN7WwAgijIOhAY/fsRw2ARLHWXPcyP3WuDAUjlK2uOH4bfYE+5U
         lE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773508; x=1687365508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Efk9cL7Xil38JdYUVreVMvnwva+BSm37z9DnJN1AKng=;
        b=cHFxcwZbX8f2qijt4A9DmTvVfm8iFJIwwQ1FuwrgsRzvA9Y2lCSLVD9xhoML0OowHU
         HGOD3j9C81mC5gWz+17M8Qgv534x5mWF1JqBx1OQ/hqKmhtzzWcSe8SAiEbAirfFxi6m
         BPi0qIxhpU8FcBSPnbbXyNYe3x6VHDjdbpgk8Za2Lk851M5OKpd1N6/YIBVMjyK05+uS
         Mc76B3XGq8LesuYiynr6/qJ1qs/pBNregQVreP2mK1TC/SMnvv7mrr35ViiNxRBptr4c
         en1CBRYvICVBTNEcwS70ZnLz3Ku18MJ4pUH7vD4MwKbXVl3mvlkS1PNHbbTRZKPlE/ie
         tQtw==
X-Gm-Message-State: AC+VfDwhvUSFLj9PoLepA6jQQ/N1tcD3gkBe6SGi+6jBbC6APkb7c0nS
	eoEdpZ8858nVy+v7svZ9IgTenwjkey4rw+DnoQG/ag==
X-Google-Smtp-Source: ACHHUZ5PwHKZc1xbb+24Ddz0KvyWVI+e0XG58YVzzATz6YRlrlMVSVMK4Z4S/dzzl+dHNnmtJgbDng==
X-Received: by 2002:adf:e7c8:0:b0:306:462a:b78d with SMTP id e8-20020adfe7c8000000b00306462ab78dmr8262691wrn.53.1684773508501;
        Mon, 22 May 2023 09:38:28 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:28 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:57 +0200
Subject: [PATCH mptcp-net v2 25/37] selftests: mptcp: join: skip check if
 MIB counter not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-25-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=19672;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=rdDKJUN8VY0qIm+v1wuEkeCXkkZUySgdzQArtSu9XyE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pxaTJYsVA88eUvJbEnAo7fqr1fDIKV1mJWQ
 PNTXZf3kYCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacQAKCRD2t4JPQmmg
 c8c+D/9zxEMkT7SonF5sh1zocR4LmMSkIba8ow8Mcie1/ME7srgpH28WmyUi1ywyS/+Hb+ammsx
 OiLQvByW0of7xfOYZl6xpneoZQ0IwN3xrEZG0bg5UO6LkbSg2/phaMSVzgVb1Ymj1Zu0GJhyJg+
 GYoP3D55EzKXWQ6l4e6FtPMiGExLJ8/RbCbB2bcGrHdfTqroXGKcS4DGx3kIAPao8maDosi14Rt
 S5w0Rv2NpEkRClHJnEqNSJ7CzG4cK+/zgxxJdjdKdP8RTQhfYgUef7lsvQz7JPOgbjE/3ErhTEi
 iTcR7Mx82xx8QjmMMuLMwqBxdeZFFuGPr0UrDDSWOTRzdbeIF2Ihkx14tuPSrkJlxdUxa1WORnN
 NmiCwFXzQYxqeilnvFcDedPh5gHzu5A7ZJGQa3sqS/PFQJvA4cUJZfkBL4b9DB06zdRDgurP41i
 cZqijg4QrwkSgMBjO/bVLGWboVe+GfiE7Pyw9kenfsshf4FcOuqYxLtNbFLxsJVaIpzeXlIbuk0
 ogA3hYMpPdxnPdKngGXh90q+94lBmS2AYXt/0fayU6URHPhKmWc3Pg6/7+tHYbXw1Dg+nhnVige
 PBegNahAWAgrJ0mUVPur51lMcwVC8RtWvRilAYg2YxW8V+66s3b8GuDKW9jM7NDWzBtsyyBr6IH
 Kwv1yAC9y3Un2ZQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the MPTCP MIB counters introduced in commit fc518953bc9c
("mptcp: add and use MIB counter infrastructure") and more later. The
MPTCP Join selftest heavily relies on these counters.

If a counter is not supported by the kernel, it is not displayed when
using 'nstat -z'. We can then detect that and skip the verification. A
new helper (get_counter()) has been added to do the required checks and
return an error if the counter is not available.

Note that if we expect to have these features available and if
SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var is set to 1, the tests
will be marked as failed instead of skipped.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: b08fbf241064 ("selftests: add test-cases for MPTCP MP_JOIN")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 251 ++++++++++++++----------
 1 file changed, 142 insertions(+), 109 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1a8f7c6fa988..73c513f1e808 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -505,11 +505,25 @@ wait_local_port_listen()
 	done
 }
 
+# $1: ns ; $2: counter
+get_counter()
+{
+	local ns="${1}"
+	local counter="${2}"
+	local count
+
+	count=$(ip netns exec ${ns} nstat -asz "${counter}" | awk 'NR==1 {next} {print $2}')
+	if [ -z "${count}" ]; then
+		mptcp_lib_fail_if_expected_feature "${counter} counter"
+		return 1
+	fi
+
+	echo "${count}"
+}
+
 rm_addr_count()
 {
-	local ns=${1}
-
-	ip netns exec ${ns} nstat -as | grep MPTcpExtRmAddr | awk '{print $2}'
+	get_counter "${1}" "MPTcpExtRmAddr"
 }
 
 # $1: ns, $2: old rm_addr counter in $ns
@@ -532,11 +546,11 @@ wait_mpj()
 	local ns="${1}"
 	local cnt old_cnt
 
-	old_cnt=$(ip netns exec ${ns} nstat -as | grep MPJoinAckRx | awk '{print $2}')
+	old_cnt=$(get_counter ${ns} "MPTcpExtMPJoinAckRx")
 
 	local i
 	for i in $(seq 10); do
-		cnt=$(ip netns exec ${ns} nstat -as | grep MPJoinAckRx | awk '{print $2}')
+		cnt=$(get_counter ${ns} "MPTcpExtMPJoinAckRx")
 		[ "$cnt" = "${old_cnt}" ] || break
 		sleep 0.1
 	done
@@ -1185,12 +1199,13 @@ chk_csum_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "sum"
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}')
-	[ -z "$count" ] && count=0
+	count=$(get_counter ${ns1} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns1" ]; then
 		extra_msg="$extra_msg ns1=$count"
 	fi
-	if { [ "$count" != $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0 ]; } ||
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif { [ "$count" != $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0 ]; } ||
 	   { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
 		fail_test
@@ -1198,12 +1213,13 @@ chk_csum_nr()
 		echo -n "[ ok ]"
 	fi
 	echo -n " - csum  "
-	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}')
-	[ -z "$count" ] && count=0
+	count=$(get_counter ${ns2} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns2" ]; then
 		extra_msg="$extra_msg ns2=$count"
 	fi
-	if { [ "$count" != $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0 ]; } ||
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif { [ "$count" != $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0 ]; } ||
 	   { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		fail_test
@@ -1242,12 +1258,13 @@ chk_fail_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "ftx"
-	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
+	count=$(get_counter ${ns_tx} "MPTcpExtMPFailTx")
 	if [ "$count" != "$fail_tx" ]; then
 		extra_msg="$extra_msg,tx=$count"
 	fi
-	if { [ "$count" != "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif { [ "$count" != "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
 	   { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
 		fail_test
@@ -1256,12 +1273,13 @@ chk_fail_nr()
 	fi
 
 	echo -n " - failrx"
-	count=$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
+	count=$(get_counter ${ns_rx} "MPTcpExtMPFailRx")
 	if [ "$count" != "$fail_rx" ]; then
 		extra_msg="$extra_msg,rx=$count"
 	fi
-	if { [ "$count" != "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif { [ "$count" != "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
 	   { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
 		fail_test
@@ -1289,10 +1307,11 @@ chk_fclose_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "ctx"
-	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPFastcloseTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	[ "$count" != "$fclose_tx" ] && extra_msg="$extra_msg,tx=$count"
-	if [ "$count" != "$fclose_tx" ]; then
+	count=$(get_counter ${ns_tx} "MPTcpExtMPFastcloseTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$fclose_tx" ]; then
+		extra_msg="$extra_msg,tx=$count"
 		echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
 		fail_test
 	else
@@ -1300,10 +1319,11 @@ chk_fclose_nr()
 	fi
 
 	echo -n " - fclzrx"
-	count=$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPFastcloseRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	[ "$count" != "$fclose_rx" ] && extra_msg="$extra_msg,rx=$count"
-	if [ "$count" != "$fclose_rx" ]; then
+	count=$(get_counter ${ns_rx} "MPTcpExtMPFastcloseRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$fclose_rx" ]; then
+		extra_msg="$extra_msg,rx=$count"
 		echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
 		fail_test
 	else
@@ -1330,9 +1350,10 @@ chk_rst_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "rtx"
-	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPRstTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ $count -lt $rst_tx ]; then
+	count=$(get_counter ${ns_tx} "MPTcpExtMPRstTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ $count -lt $rst_tx ]; then
 		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
 		fail_test
 	else
@@ -1340,9 +1361,10 @@ chk_rst_nr()
 	fi
 
 	echo -n " - rstrx "
-	count=$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPRstRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" -lt "$rst_rx" ]; then
+	count=$(get_counter ${ns_rx} "MPTcpExtMPRstRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" -lt "$rst_rx" ]; then
 		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
 		fail_test
 	else
@@ -1359,9 +1381,10 @@ chk_infi_nr()
 	local count
 
 	printf "%-${nr_blank}s %s" " " "itx"
-	count=$(ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$infi_tx" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtInfiniteMapTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$infi_tx" ]; then
 		echo "[fail] got $count infinite map[s] TX expected $infi_tx"
 		fail_test
 	else
@@ -1369,9 +1392,10 @@ chk_infi_nr()
 	fi
 
 	echo -n " - infirx"
-	count=$(ip netns exec $ns1 nstat -as | grep InfiniteMapRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$infi_rx" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtInfiniteMapRx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$infi_rx" ]; then
 		echo "[fail] got $count infinite map[s] RX expected $infi_rx"
 		fail_test
 	else
@@ -1399,9 +1423,10 @@ chk_join_nr()
 	fi
 
 	printf "%03u %-36s %s" "${TEST_COUNT}" "${title}" "syn"
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$syn_nr" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPJoinSynRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$syn_nr" ]; then
 		echo "[fail] got $count JOIN[s] syn expected $syn_nr"
 		fail_test
 	else
@@ -1410,9 +1435,10 @@ chk_join_nr()
 
 	echo -n " - synack"
 	with_cookie=$(ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies)
-	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$syn_ack_nr" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtMPJoinSynAckRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$syn_ack_nr" ]; then
 		# simult connections exceeding the limit with cookie enabled could go up to
 		# synack validation as the conn limit can be enforced reliably only after
 		# the subflow creation
@@ -1427,9 +1453,10 @@ chk_join_nr()
 	fi
 
 	echo -n " - ack"
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinAckRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$ack_nr" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPJoinAckRx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$ack_nr" ]; then
 		echo "[fail] got $count JOIN[s] ack expected $ack_nr"
 		fail_test
 	else
@@ -1459,12 +1486,12 @@ chk_stale_nr()
 	local recover_nr
 
 	printf "%-${nr_blank}s %-18s" " " "stale"
-	stale_nr=$(ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk '{print $2}')
-	[ -z "$stale_nr" ] && stale_nr=0
-	recover_nr=$(ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover | awk '{print $2}')
-	[ -z "$recover_nr" ] && recover_nr=0
 
-	if [ $stale_nr -lt $stale_min ] ||
+	stale_nr=$(get_counter ${ns} "MPTcpExtSubflowStale")
+	recover_nr=$(get_counter ${ns} "MPTcpExtSubflowRecover")
+	if [ -z "$stale_nr" ] || [ -z "$recover_nr" ]; then
+		echo "[skip]"
+	elif [ $stale_nr -lt $stale_min ] ||
 	   { [ $stale_max -gt 0 ] && [ $stale_nr -gt $stale_max ]; } ||
 	   [ $((stale_nr - recover_nr)) -ne $stale_delta ]; then
 		echo "[fail] got $stale_nr stale[s] $recover_nr recover[s], " \
@@ -1499,12 +1526,12 @@ chk_add_nr()
 	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
 	printf "%-${nr_blank}s %s" " " "add"
-	count=$(ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}')
-	[ -z "$count" ] && count=0
-
+	count=$(get_counter ${ns2} "MPTcpExtAddAddr")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
 	# if the test configured a short timeout tolerate greater then expected
 	# add addrs options, due to retransmissions
-	if [ "$count" != "$add_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_nr" ]; }; then
+	elif [ "$count" != "$add_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_nr" ]; }; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
 		fail_test
 	else
@@ -1512,9 +1539,10 @@ chk_add_nr()
 	fi
 
 	echo -n " - echo  "
-	count=$(ip netns exec $ns1 nstat -as MPTcpExtEchoAdd | grep MPTcpExtEchoAdd | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$echo_nr" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtEchoAdd")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$echo_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
 		fail_test
 	else
@@ -1523,9 +1551,10 @@ chk_add_nr()
 
 	if [ $port_nr -gt 0 ]; then
 		echo -n " - pt "
-		count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtPortAdd | awk '{print $2}')
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$port_nr" ]; then
+		count=$(get_counter ${ns2} "MPTcpExtPortAdd")
+		if [ -z "$count" ]; then
+			echo "[skip]"
+		elif [ "$count" != "$port_nr" ]; then
 			echo "[fail] got $count ADD_ADDR[s] with a port-number expected $port_nr"
 			fail_test
 		else
@@ -1533,10 +1562,10 @@ chk_add_nr()
 		fi
 
 		printf "%-${nr_blank}s %s" " " "syn"
-		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
-			awk '{print $2}')
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$syn_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
+		if [ -z "$count" ]; then
+			echo -n "[skip]"
+		elif [ "$count" != "$syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a different \
 				port-number expected $syn_nr"
 			fail_test
@@ -1545,10 +1574,10 @@ chk_add_nr()
 		fi
 
 		echo -n " - synack"
-		count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinPortSynAckRx |
-			awk '{print $2}')
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$syn_ack_nr" ]; then
+		count=$(get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
+		if [ -z "$count" ]; then
+			echo -n "[skip]"
+		elif [ "$count" != "$syn_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] synack with a different \
 				port-number expected $syn_ack_nr"
 			fail_test
@@ -1557,10 +1586,10 @@ chk_add_nr()
 		fi
 
 		echo -n " - ack"
-		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortAckRx |
-			awk '{print $2}')
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$ack_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
+		if [ -z "$count" ]; then
+			echo "[skip]"
+		elif [ "$count" != "$ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a different \
 				port-number expected $ack_nr"
 			fail_test
@@ -1569,10 +1598,10 @@ chk_add_nr()
 		fi
 
 		printf "%-${nr_blank}s %s" " " "syn"
-		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortSynRx |
-			awk '{print $2}')
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$mis_syn_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
+		if [ -z "$count" ]; then
+			echo -n "[skip]"
+		elif [ "$count" != "$mis_syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a mismatched \
 				port-number expected $mis_syn_nr"
 			fail_test
@@ -1581,10 +1610,10 @@ chk_add_nr()
 		fi
 
 		echo -n " - ack   "
-		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortAckRx |
-			awk '{print $2}')
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$mis_ack_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
+		if [ -z "$count" ]; then
+			echo "[skip]"
+		elif [ "$count" != "$mis_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a mismatched \
 				port-number expected $mis_ack_nr"
 			fail_test
@@ -1606,12 +1635,12 @@ chk_add_tx_nr()
 	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
 	printf "%-${nr_blank}s %s" " " "add TX"
-	count=$(ip netns exec $ns1 nstat -as MPTcpExtAddAddrTx | grep MPTcpExtAddAddrTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-
+	count=$(get_counter ${ns1} "MPTcpExtAddAddrTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
 	# if the test configured a short timeout tolerate greater then expected
 	# add addrs options, due to retransmissions
-	if [ "$count" != "$add_tx_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_tx_nr" ]; }; then
+	elif [ "$count" != "$add_tx_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_tx_nr" ]; }; then
 		echo "[fail] got $count ADD_ADDR[s] TX, expected $add_tx_nr"
 		fail_test
 	else
@@ -1619,9 +1648,10 @@ chk_add_tx_nr()
 	fi
 
 	echo -n " - echo TX "
-	count=$(ip netns exec $ns2 nstat -as MPTcpExtEchoAddTx | grep MPTcpExtEchoAddTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$echo_tx_nr" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtEchoAddTx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$echo_tx_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] TX, expected $echo_tx_nr"
 		fail_test
 	else
@@ -1695,9 +1725,10 @@ chk_rm_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "rm "
-	count=$(ip netns exec $addr_ns nstat -as MPTcpExtRmAddr | grep MPTcpExtRmAddr | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$rm_addr_nr" ]; then
+	count=$(get_counter ${addr_ns} "MPTcpExtRmAddr")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
 		fail_test
 	else
@@ -1705,12 +1736,13 @@ chk_rm_nr()
 	fi
 
 	echo -n " - rmsf  "
-	count=$(ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ -n "$simult" ]; then
+	count=$(get_counter ${subflow_ns} "MPTcpExtRmSubflow")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ -n "$simult" ]; then
 		local cnt suffix
 
-		cnt=$(ip netns exec $addr_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}')
+		cnt=$(get_counter ${addr_ns} "MPTcpExtRmSubflow")
 
 		# in case of simult flush, the subflow removal count on each side is
 		# unreliable
@@ -1719,14 +1751,12 @@ chk_rm_nr()
 		[ "$count" != "$rm_subflow_nr" ] && suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
 		if [ $count -ge "$rm_subflow_nr" ] && \
 		   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then
-			echo "[ ok ] $suffix"
+			echo -n "[ ok ] $suffix"
 		else
 			echo "[fail] got $count RM_SUBFLOW[s] expected in range [$rm_subflow_nr:$((rm_subflow_nr*2))]"
 			fail_test
 		fi
-		return
-	fi
-	if [ "$count" != "$rm_subflow_nr" ]; then
+	elif [ "$count" != "$rm_subflow_nr" ]; then
 		echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
 		fail_test
 	else
@@ -1741,9 +1771,10 @@ chk_rm_tx_nr()
 	local rm_addr_tx_nr=$1
 
 	printf "%-${nr_blank}s %s" " " "rm TX "
-	count=$(ip netns exec $ns2 nstat -as MPTcpExtRmAddrTx | grep MPTcpExtRmAddrTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$rm_addr_tx_nr" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtRmAddrTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$rm_addr_tx_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_tx_nr"
 		fail_test
 	else
@@ -1780,9 +1811,10 @@ chk_prio_nr()
 	local count
 
 	printf "%-${nr_blank}s %s" " " "ptx"
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$mp_prio_nr_tx" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPPrioTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$mp_prio_nr_tx" ]; then
 		echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
 		fail_test
 	else
@@ -1790,9 +1822,10 @@ chk_prio_nr()
 	fi
 
 	echo -n " - prx   "
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$mp_prio_nr_rx" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPPrioRx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$mp_prio_nr_rx" ]; then
 		echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
 		fail_test
 	else
@@ -1903,7 +1936,7 @@ wait_attempt_fail()
 	while [ $time -lt $timeout_ms ]; do
 		local cnt
 
-		cnt=$(ip netns exec $ns nstat -as TcpAttemptFails | grep TcpAttemptFails | awk '{print $2}')
+		cnt=$(get_counter ${ns} "TcpAttemptFails")
 
 		[ "$cnt" = 1 ] && return 1
 		time=$((time + 100))

-- 
2.39.2

