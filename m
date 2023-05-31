Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6003715495
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:52 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f6dbe3c230so60025535e9.3
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542610; x=1688134610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nY/6Cm6VYEhZNs/KG+ur9NGwB6YMPKdYIkUsFrWe1KM=;
        b=BVrqaCnAVB+M+SGCzzilq9AhboG9LMkO+06KkYSPYiHw5WciRAWGygsj5hhifSFPCc
         O0+VJvavNqJ/pRj34SbG97lx8fn1DmOmTu6/5MhuVMrdAqEkBvqZwwPIbYFM2G9hh9eD
         efZXdwYd/a+rBiYTwErz1x9a/hocGhT783/QcFBzsYDPW67oXigBPIKGi6cPPnNh/vGJ
         daAsBWDvkHwSmVUkX29cGr4CoZmKcnkn3Tp4f4t79nnAoWH0no4nZiWMvpTFouhJYu6Q
         PL7EB7kE0X15j3aDrSGznotHWZYQo8UdX3J4baRmKcMVEMdZitxx3B2RlSWpkVYElxKZ
         0HYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542610; x=1688134610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nY/6Cm6VYEhZNs/KG+ur9NGwB6YMPKdYIkUsFrWe1KM=;
        b=Lmu2ANJNZ8MOTF2xoXI/ivjyJoJvTIhReDg/wrSj7lzTOgK514zgmM+1hfAb3Qljj9
         9R4xgulf+j6LZylFqxDobu/Ge8JhAwx6W1e+dppgsW0brYhU+gHmfbeKFxnAD2O1NUPU
         my3MIEMg+aZGJvDAOF3SYNLnhLMVOAyxafm/C+sb/cTWLNmEB59UVZaK12QFkBOPsIEE
         lCfonYIva2WcCxzD0h7DXHT6oZ/09+KPf5JlNM4mKeGFpivOx5Kd7IZUf4dIX4j7khaF
         gf3j2cvRr6PGpFS2TCicWdq5xDPjy1tnqUA1Y5OF2BoNwFqDaltxYrdioBMX6ztvG6Ru
         TSVQ==
X-Gm-Message-State: AC+VfDyXleYBurzY0Fdm1RUXBCDJlor+T2tKu9VfcHbEDWl8URd/nZTq
	wi5omZZzWQkPSUXxf8AijEooyQ==
X-Google-Smtp-Source: ACHHUZ75KfSPpdACLH+JLyaJQ0puXHAQ/F6vRhGaclsb4aCsIfZmwVqlABSJvPBa1afUMIC88zjr4g==
X-Received: by 2002:a05:600c:b44:b0:3f6:984:4e43 with SMTP id k4-20020a05600c0b4400b003f609844e43mr4818378wmr.21.1685542610415;
        Wed, 31 May 2023 07:16:50 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:50 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:38 +0200
Subject: [PATCH mptcp-net v3 18/32] selftests: mptcp: join: skip check if
 MIB counter not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-18-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=20182;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=pXJ6jXdlO8mkCIqzu4bhxN9uXNboJ7Ycyr/zC9NCUbw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bDL597tys3oe9JPogm7EcQnCL0qAATiwVzb
 tEyWUgngLGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwwAKCRD2t4JPQmmg
 c2yLD/43A25DpIQlRkcO9FUuuRF8JniqD2C/OkqR8+g7z151IiRbTp57T9R6kNqKw84OiDmdXbw
 aysFiJRblRIuhHtdrIFGDwuigahpm/RbKfnX2BCAFPYOVZgqc0hDweSgl1YQXGkwsdHZqNU9f1i
 j9/NRFu1lWKp3GZ6kM1uUbhkF1SKs2puFnut1teNMqRmZEW2r4/lgK/wXBsuT1ek3XzkHyPdK6M
 SXz/s19IOm4dL5V/s/cqHaQcUUIrCEaCc2dZ856ihhLVHmla46yMAICxvPLBAEp9ziS9Z4l3KX0
 g99S0QYtZPB7mFHN2V0fLML3K6wlbpHERkbMjDWerUg+pvw+xApkxkLGewbTFCBt0795AMoJCTu
 lvP/4xP2NenfB8j435Xk6qQLX5Cv2isop/O5pmldNGEYAeXZGRcLO6zlPp7L6T3Sv3WYtv5anai
 oZ5xP/SbRO1Al+svBcWpImsr+4hdwnkDwONZVXPv2Z94J2eM9mkZ+g1mt2WAmDhjm6whX1HW4tg
 0DsznPYhZxP590vsx9PqxJnRfY2YOH/NEEM8lOOXryXWOLUvf2MJDI3kGzdpjtXwqXJXn8r6n2m
 sKka8ktvw/ChutXH1XSvHwV+kmmwZXGYTd+E1HNlyeFnURNil7itHMCRhdFm6p7tYISvhqTet4o
 LkMjWbe9mAh6LCw==
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

This new helper also makes sure we get the exact counter we want to
avoid issues we had in the past, e.g. with MPTcpExtRmAddr and
MPTcpExtRmAddrDrop sharing the same prefix. While at it, we uniform the
way we fetch a MIB counter.

Note for the backports: we rarely change these modified blocks so if
there is are conflicts, it is very likely because a counter is not used
in the older kernels and we don't need that chunk.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: b08fbf241064 ("selftests: add test-cases for MPTCP MP_JOIN")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
v3:
  - Add more info about what the new helper does + backports note
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 251 ++++++++++++++----------
 1 file changed, 142 insertions(+), 109 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 72bc6769c184..53178ef00b50 100755
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
@@ -1194,12 +1208,13 @@ chk_csum_nr()
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
@@ -1207,12 +1222,13 @@ chk_csum_nr()
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
@@ -1251,12 +1267,13 @@ chk_fail_nr()
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
@@ -1265,12 +1282,13 @@ chk_fail_nr()
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
@@ -1298,10 +1316,11 @@ chk_fclose_nr()
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
@@ -1309,10 +1328,11 @@ chk_fclose_nr()
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
@@ -1339,9 +1359,10 @@ chk_rst_nr()
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
@@ -1349,9 +1370,10 @@ chk_rst_nr()
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
@@ -1368,9 +1390,10 @@ chk_infi_nr()
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
@@ -1378,9 +1401,10 @@ chk_infi_nr()
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
@@ -1408,9 +1432,10 @@ chk_join_nr()
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
@@ -1419,9 +1444,10 @@ chk_join_nr()
 
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
@@ -1436,9 +1462,10 @@ chk_join_nr()
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
@@ -1468,12 +1495,12 @@ chk_stale_nr()
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
@@ -1508,12 +1535,12 @@ chk_add_nr()
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
@@ -1521,9 +1548,10 @@ chk_add_nr()
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
@@ -1532,9 +1560,10 @@ chk_add_nr()
 
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
@@ -1542,10 +1571,10 @@ chk_add_nr()
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
@@ -1554,10 +1583,10 @@ chk_add_nr()
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
@@ -1566,10 +1595,10 @@ chk_add_nr()
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
@@ -1578,10 +1607,10 @@ chk_add_nr()
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
@@ -1590,10 +1619,10 @@ chk_add_nr()
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
@@ -1615,12 +1644,12 @@ chk_add_tx_nr()
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
@@ -1628,9 +1657,10 @@ chk_add_tx_nr()
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
@@ -1666,9 +1696,10 @@ chk_rm_nr()
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
@@ -1676,12 +1707,13 @@ chk_rm_nr()
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
@@ -1690,14 +1722,12 @@ chk_rm_nr()
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
@@ -1712,9 +1742,10 @@ chk_rm_tx_nr()
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
@@ -1731,9 +1762,10 @@ chk_prio_nr()
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
@@ -1741,9 +1773,10 @@ chk_prio_nr()
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
@@ -1854,7 +1887,7 @@ wait_attempt_fail()
 	while [ $time -lt $timeout_ms ]; do
 		local cnt
 
-		cnt=$(ip netns exec $ns nstat -as TcpAttemptFails | grep TcpAttemptFails | awk '{print $2}')
+		cnt=$(get_counter ${ns} "TcpAttemptFails")
 
 		[ "$cnt" = 1 ] && return 1
 		time=$((time + 100))

-- 
2.39.2

