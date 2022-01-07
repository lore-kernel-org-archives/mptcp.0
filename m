Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D822CA2
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 19:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641583555; x=1673119555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IrM1n4BNK5VUVrH5+/DEpZSC+KFM8jk9oHhk716sGRY=;
  b=PY/HE+7PhY6dWYi6Vt3X9iulD19Myru+DYpIJGTYkjpKzDnCsXEiyOsM
   g0jylBN/S+VqnPWljHQuZ7RXhZg+ubYkRqiNbb+vdKl10SwX6x6/MOwN+
   snpOXjJn1iGbzkAiAtW7xR5+kdaVm0JYaefPjumZnWVv9LEpzYmQepPdS
   KAoCovJMiOfmGPD2FZL7wOZwQEy+ASPeUPJh/H9DnMSC6VPsCFyyq0lrW
   5+ggHnp8k3uc8uId9gZCrcjHtJ76iTurFutBevInO+wWOIeGvkWUFcJej
   zbFY+i3nXZwZgOaK6DpIDYx1xcCEn4nHdPmGe9MrgSVqfPAqk7DzMc3Xf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="240478008"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="240478008"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 11:25:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="527478586"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.36.93])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 11:25:53 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/3] selftests: mptcp: more stable join tests-cases
Date: Fri,  7 Jan 2022 11:25:22 -0800
Message-Id: <20220107192524.445137-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107192524.445137-1-mathew.j.martineau@linux.intel.com>
References: <20220107192524.445137-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

MPTCP join self-tests are a bit fragile as they reply on
delays instead of events to catch-up with the expected
sockets states.

Replace the delay with state checking where possible and
reduce the number of sleeps in the most complex scenarios.

This will both reduce the tests run-time and will improve
stability.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 120 ++++++++++--------
 1 file changed, 68 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3165bd1a43cc..27d0eb9afdca 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -238,6 +238,45 @@ is_v6()
 	[ -z "${1##*:*}" ]
 }
 
+# $1: ns, $2: port
+wait_local_port_listen()
+{
+	local listener_ns="${1}"
+	local port="${2}"
+
+	local port_hex i
+
+	port_hex="$(printf "%04X" "${port}")"
+	for i in $(seq 10); do
+		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
+			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
+			break
+		sleep 0.1
+	done
+}
+
+rm_addr_count()
+{
+	ns=${1}
+
+	ip netns exec ${ns} nstat -as | grep MPTcpExtRmAddr | awk '{print $2}'
+}
+
+# $1: ns, $2: old rm_addr counter in $ns
+wait_rm_addr()
+{
+	local ns="${1}"
+	local old_cnt="${2}"
+	local cnt
+	local i
+
+	for i in $(seq 10); do
+		cnt=$(rm_addr_count ${ns})
+		[ "$cnt" = "${old_cnt}" ] || break
+		sleep 0.1
+	done
+}
+
 do_transfer()
 {
 	listener_ns="$1"
@@ -307,7 +346,7 @@ do_transfer()
 	fi
 	spid=$!
 
-	sleep 1
+	wait_local_port_listen "${listener_ns}" "${port}"
 
 	if [ "$test_link_fail" -eq 0 ];then
 		timeout ${timeout_test} \
@@ -324,10 +363,13 @@ do_transfer()
 	fi
 	cpid=$!
 
+	# let the mptcp subflow be established in background before
+	# do endpoint manipulation
+	[ $addr_nr_ns1 = "0" -a $addr_nr_ns2 = "0" ] || sleep 1
+
 	if [ $addr_nr_ns1 -gt 0 ]; then
 		let add_nr_ns1=addr_nr_ns1
 		counter=2
-		sleep 1
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -339,7 +381,6 @@ do_transfer()
 			let counter+=1
 			let add_nr_ns1-=1
 		done
-		sleep 1
 	elif [ $addr_nr_ns1 -lt 0 ]; then
 		let rm_nr_ns1=-addr_nr_ns1
 		if [ $rm_nr_ns1 -lt 8 ]; then
@@ -347,22 +388,19 @@ do_transfer()
 			pos=1
 			dump=(`ip netns exec ${listener_ns} ./pm_nl_ctl dump`)
 			if [ ${#dump[@]} -gt 0 ]; then
-				sleep 1
-
 				while [ $counter -le $rm_nr_ns1 ]
 				do
 					id=${dump[$pos]}
+					rm_addr=$(rm_addr_count ${connector_ns})
 					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
-					sleep 1
+					wait_rm_addr ${connector_ns} ${rm_addr}
 					let counter+=1
 					let pos+=5
 				done
 			fi
 		elif [ $rm_nr_ns1 -eq 8 ]; then
-			sleep 1
 			ip netns exec ${listener_ns} ./pm_nl_ctl flush
 		elif [ $rm_nr_ns1 -eq 9 ]; then
-			sleep 1
 			ip netns exec ${listener_ns} ./pm_nl_ctl del 0 ${connect_addr}
 		fi
 	fi
@@ -373,10 +411,13 @@ do_transfer()
 		addr_nr_ns2=${addr_nr_ns2:9}
 	fi
 
+	# if newly added endpoints must be deleted, give the background msk
+	# some time to created them
+	[ $addr_nr_ns1 -gt 0 -a $addr_nr_ns2 -lt 0 ] && sleep 1
+
 	if [ $addr_nr_ns2 -gt 0 ]; then
 		let add_nr_ns2=addr_nr_ns2
 		counter=3
-		sleep 1
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -388,7 +429,6 @@ do_transfer()
 			let counter+=1
 			let add_nr_ns2-=1
 		done
-		sleep 1
 	elif [ $addr_nr_ns2 -lt 0 ]; then
 		let rm_nr_ns2=-addr_nr_ns2
 		if [ $rm_nr_ns2 -lt 8 ]; then
@@ -396,19 +436,18 @@ do_transfer()
 			pos=1
 			dump=(`ip netns exec ${connector_ns} ./pm_nl_ctl dump`)
 			if [ ${#dump[@]} -gt 0 ]; then
-				sleep 1
-
 				while [ $counter -le $rm_nr_ns2 ]
 				do
+					# rm_addr are serialized, allow the previous one to complete
 					id=${dump[$pos]}
+					rm_addr=$(rm_addr_count ${listener_ns})
 					ip netns exec ${connector_ns} ./pm_nl_ctl del $id
-					sleep 1
+					wait_rm_addr ${listener_ns} ${rm_addr}
 					let counter+=1
 					let pos+=5
 				done
 			fi
 		elif [ $rm_nr_ns2 -eq 8 ]; then
-			sleep 1
 			ip netns exec ${connector_ns} ./pm_nl_ctl flush
 		elif [ $rm_nr_ns2 -eq 9 ]; then
 			local addr
@@ -417,7 +456,6 @@ do_transfer()
 			else
 				addr="10.0.1.2"
 			fi
-			sleep 1
 			ip netns exec ${connector_ns} ./pm_nl_ctl del 0 $addr
 		fi
 	fi
@@ -539,6 +577,14 @@ run_tests()
 	lret=$?
 }
 
+dump_stats()
+{
+	echo Server ns stats
+	ip netns exec $ns1 nstat -as | grep Tcp
+	echo Client ns stats
+	ip netns exec $ns2 nstat -as | grep Tcp
+}
+
 chk_csum_nr()
 {
 	local msg=${1:-""}
@@ -570,12 +616,7 @@ chk_csum_nr()
 	else
 		echo "[ ok ]"
 	fi
-	if [ "${dump_stats}" = 1 ]; then
-		echo Server ns stats
-		ip netns exec $ns1 nstat -as | grep MPTcp
-		echo Client ns stats
-		ip netns exec $ns2 nstat -as | grep MPTcp
-	fi
+	[ "${dump_stats}" = 1 ] && dump_stats
 }
 
 chk_fail_nr()
@@ -607,12 +648,7 @@ chk_fail_nr()
 		echo "[ ok ]"
 	fi
 
-	if [ "${dump_stats}" = 1 ]; then
-		echo Server ns stats
-		ip netns exec $ns1 nstat -as | grep MPTcp
-		echo Client ns stats
-		ip netns exec $ns2 nstat -as | grep MPTcp
-	fi
+	[ "${dump_stats}" = 1 ] && dump_stats
 }
 
 chk_join_nr()
@@ -656,12 +692,7 @@ chk_join_nr()
 	else
 		echo "[ ok ]"
 	fi
-	if [ "${dump_stats}" = 1 ]; then
-		echo Server ns stats
-		ip netns exec $ns1 nstat -as | grep MPTcp
-		echo Client ns stats
-		ip netns exec $ns2 nstat -as | grep MPTcp
-	fi
+	[ "${dump_stats}" = 1 ] && dump_stats
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
@@ -823,12 +854,7 @@ chk_add_nr()
 		echo ""
 	fi
 
-	if [ "${dump_stats}" = 1 ]; then
-		echo Server ns stats
-		ip netns exec $ns1 nstat -as | grep MPTcp
-		echo Client ns stats
-		ip netns exec $ns2 nstat -as | grep MPTcp
-	fi
+	[ "${dump_stats}" = 1 ] && dump_stats
 }
 
 chk_rm_nr()
@@ -871,12 +897,7 @@ chk_rm_nr()
 		echo "[ ok ]"
 	fi
 
-	if [ "${dump_stats}" = 1 ]; then
-		echo Server ns stats
-		ip netns exec $ns1 nstat -as | grep MPTcp
-		echo Client ns stats
-		ip netns exec $ns2 nstat -as | grep MPTcp
-	fi
+	[ "${dump_stats}" = 1 ] && dump_stats
 }
 
 chk_prio_nr()
@@ -908,12 +929,7 @@ chk_prio_nr()
 		echo "[ ok ]"
 	fi
 
-	if [ "${dump_stats}" = 1 ]; then
-		echo Server ns stats
-		ip netns exec $ns1 nstat -as | grep MPTcp
-		echo Client ns stats
-		ip netns exec $ns2 nstat -as | grep MPTcp
-	fi
+	[ "${dump_stats}" = 1 ] && dump_stats
 }
 
 chk_link_usage()
@@ -1651,7 +1667,7 @@ add_addr_ports_tests()
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
-	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+	run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
 	chk_join_nr "flush subflows and signal with port" 3 3 3
 	chk_add_nr 1 1
 	chk_rm_nr 2 2
-- 
2.34.1

