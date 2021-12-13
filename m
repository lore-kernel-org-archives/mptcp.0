Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E9068
	for <mptcp@lists.linux.dev>; Mon, 13 Dec 2021 17:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639417255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3rp1l7y/9mrhyvJSSYlh8orVrr+xf9+N2y14Wa4NYLM=;
	b=ZjUgrOKcHeC/156n4batiLJJt+7kc9OLkJNg9uoesNdc0XDrVCwCVBa+R8MgHgpqarVhfr
	zyeqJeg86nDwpMftnmPv2fWAs4xDaWeanYEELl7SLhDPZZ0BJk6RauTJFMwuKoCcchTtJ7
	vodIxaxCqWcSncnt+nMwUxE09+Qso8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-tQivnLpjM8e_ZTcky9_5cw-1; Mon, 13 Dec 2021 12:40:54 -0500
X-MC-Unique: tQivnLpjM8e_ZTcky9_5cw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25816100CC84
	for <mptcp@lists.linux.dev>; Mon, 13 Dec 2021 17:40:53 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.194])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8C11F45D93
	for <mptcp@lists.linux.dev>; Mon, 13 Dec 2021 17:40:52 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] selftests: mptcp: more stable join tests-cases.
Date: Mon, 13 Dec 2021 18:40:46 +0100
Message-Id: <6d17baa5f8bb4dcd6b63fb3dee790743c878478e.1639417229.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 58 ++++++++++++++-----
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 55b0d03f485c..505745b44e02 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -238,6 +238,37 @@ is_v6()
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
+# $1: ns, $2: endpoint id
+wait_address_deleted()
+{
+	local ns="${1}"
+	local addr="${2}"
+	local cnt
+
+	for i in $(seq 10); do
+		cnt=$(ss -tON ${ns} state big src = ${addr} | wc -l)
+		[ "$cnt" != 0 ] || break;
+		sleep 0.1
+	done
+}
+
 do_transfer()
 {
 	listener_ns="$1"
@@ -307,7 +338,7 @@ do_transfer()
 	fi
 	spid=$!
 
-	sleep 1
+	wait_local_port_listen "${listener_ns}" "${srv_port}"
 
 	if [ "$test_link_fail" -eq 0 ];then
 		timeout ${timeout_test} \
@@ -324,10 +355,13 @@ do_transfer()
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
@@ -339,7 +373,6 @@ do_transfer()
 			let counter+=1
 			let add_nr_ns1-=1
 		done
-		sleep 1
 	elif [ $addr_nr_ns1 -lt 0 ]; then
 		let rm_nr_ns1=-addr_nr_ns1
 		if [ $rm_nr_ns1 -lt 8 ]; then
@@ -347,22 +380,18 @@ do_transfer()
 			pos=1
 			dump=(`ip netns exec ${listener_ns} ./pm_nl_ctl dump`)
 			if [ ${#dump[@]} -gt 0 ]; then
-				sleep 1
-
 				while [ $counter -le $rm_nr_ns1 ]
 				do
 					id=${dump[$pos]}
 					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
-					sleep 1
+					wait_address_deleted ${listener_ns} ${dump[-1]}
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
@@ -373,10 +402,13 @@ do_transfer()
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
@@ -388,7 +420,6 @@ do_transfer()
 			let counter+=1
 			let add_nr_ns2-=1
 		done
-		sleep 1
 	elif [ $addr_nr_ns2 -lt 0 ]; then
 		let rm_nr_ns2=-addr_nr_ns2
 		if [ $rm_nr_ns2 -lt 8 ]; then
@@ -396,19 +427,17 @@ do_transfer()
 			pos=1
 			dump=(`ip netns exec ${connector_ns} ./pm_nl_ctl dump`)
 			if [ ${#dump[@]} -gt 0 ]; then
-				sleep 1
-
 				while [ $counter -le $rm_nr_ns2 ]
 				do
+					# rm_addr are serialized, allow the previous one to complete
 					id=${dump[$pos]}
 					ip netns exec ${connector_ns} ./pm_nl_ctl del $id
-					sleep 1
+					wait_address_deleted ${connector_ns} ${dump[-1]}
 					let counter+=1
 					let pos+=5
 				done
 			fi
 		elif [ $rm_nr_ns2 -eq 8 ]; then
-			sleep 1
 			ip netns exec ${connector_ns} ./pm_nl_ctl flush
 		elif [ $rm_nr_ns2 -eq 9 ]; then
 			local addr
@@ -417,7 +446,6 @@ do_transfer()
 			else
 				addr="10.0.1.2"
 			fi
-			sleep 1
 			ip netns exec ${connector_ns} ./pm_nl_ctl del 0 $addr
 		fi
 	fi
-- 
2.33.1

