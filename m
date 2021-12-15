Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87C8168
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 11:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639568215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eG7vDm8F2NnDRaebCcDIfIP5Ikvf4YwH9uGtCzqK6HU=;
	b=WIhV2baYi6SSb3J0dQnX0jHBNzbYljpSnRmdJkR0RCfXIkyM9V0smhnOGgiuW01QSyNCJp
	MxQUUrQeZuZTP+/v6LyEu7yaGe8QZySAic5OyrUoATzP9zHsEBpL9lHL6yFxhZvuwXnpoy
	TK2kXttrlLhbaXzW5gb5r86hLT2hBTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-f9UKBoFXOG2uLq-226NDUQ-1; Wed, 15 Dec 2021 06:36:53 -0500
X-MC-Unique: f9UKBoFXOG2uLq-226NDUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B44A801962
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 11:36:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.64])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B754A3468B
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 11:36:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next] selftests: mptcp: more stable join tests-cases.
Date: Wed, 15 Dec 2021 12:36:49 +0100
Message-Id: <dfbdb183399851cfa695fa4c965a8d146d436e52.1639567831.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

MPTCP join self-tests are a bit fragile as they reply on
delays instead of events to catch-up with the expected
sockets states.

Replace the delay with state checking where possible and
reduce the number of sleeps in the most complex scenarios.

This will both reduce the tests run-time and will improve
stability.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note: I still see frequent failures in "remove subflow and signal IPv6",
but that looks unrelated from this patch: sk lookup fails on the
client side for the MPJ syn-ack. Funnily enough, I can't reproduce
the failure with pcap capture on...

v2 -> v3:
 - fix wait_for_address
 - consolidate stats dumping, add TCP stats

v1 -> v2:
 - fix ipv6 addr handling
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 127 ++++++++++--------
 1 file changed, 69 insertions(+), 58 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2684ef9c0d42..c85ef7987785 100755
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
 
 chk_infi_nr()
@@ -644,12 +680,7 @@ chk_infi_nr()
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
@@ -693,12 +724,7 @@ chk_join_nr()
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
@@ -861,12 +887,7 @@ chk_add_nr()
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
@@ -909,12 +930,7 @@ chk_rm_nr()
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
@@ -946,12 +962,7 @@ chk_prio_nr()
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
@@ -1615,7 +1626,7 @@ add_addr_ports_tests()
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
-	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+	run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
 	chk_join_nr "flush subflows and signal with port" 3 3 3
 	chk_add_nr 1 1
 	chk_rm_nr 2 2
-- 
2.33.1

