Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB4D1EB31
	for <mptcp@lists.linux.dev>; Thu,  3 Oct 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974982; cv=none; b=gxGwXvlDdC4vcu+yV1UPmjJghuMNK+bqDXWeL14NoZVwqY2NRL0aV5jO36RmmMA5nn/1SVFLMrH2iZo7JAn47cfM6VYnM6PPp39/gMS/oWzxk323l6BMjBeRaldVOLHMZ0HsarXlOn5itbEqwVeqHrXKX2yaWheRmK2PL1Vbucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974982; c=relaxed/simple;
	bh=G3Sr0YpuU5OSV/yPn5QAKyuwCNwL9ES8TAXCxHN5nX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0qqACl0bvRMbcEKi3Nt3CUFrBX8vyBy8vz+KWhFUhOOXDIBitI3eqexl3hQH5fldS3vAzXyK7jyLL6RpUETPHV2UUX54QlHhcRZHtehqOaMUPZGQ766yWZI4L/zjBCTTIxtEhwodE6NI7VtyvNDOZc9FC3bz46ZleE0sN2piFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4KMrSk0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4KMrSk0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727974979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxfdXFR2oOkvOolZTcLsyVNpFgOKBP6dHWMTNFhAZZg=;
	b=O4KMrSk0je1AbWmAkkZ91haghWCq21umTDysGtsjIMIGvqS9dqRPGXs+ga/CPX3gxvGuEI
	gylPx9sgvkLrSRZTf0v4LnR9dGslI8Hf6nmBzUCVgbB1LhVgJ9HCqiMrbROug3y28yeRvE
	Yfvm47VgCFKiqujUv6zrVXnKd8xdpuw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-Vc7mrU8FM4alxKALl0APOw-1; Thu,
 03 Oct 2024 13:02:58 -0400
X-MC-Unique: Vc7mrU8FM4alxKALl0APOw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7411719560BE;
	Thu,  3 Oct 2024 17:02:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.141])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E4F919560AD;
	Thu,  3 Oct 2024 17:02:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH mptcp-net 2/2] selftests: mptcp: join: add test-case for MPC attempt towards signl ep
Date: Thu,  3 Oct 2024 19:02:36 +0200
Message-ID: <66cfbfdf241fb43c51bf3c7d35c92f79a92b025d.1727974826.git.pabeni@redhat.com>
In-Reply-To: <833cae5982ac5d5b3236845c6db4315e634f5705.1727974826.git.pabeni@redhat.com>
References: <833cae5982ac5d5b3236845c6db4315e634f5705.1727974826.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Explicitly verify that MPC connection attempts towards a port-based
signal endpoint fail with a reset.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 80 ++++++++++++++-----
 1 file changed, 58 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e8d0a01b4144..5e2ab7dfb182 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -41,6 +41,7 @@ evts_ns2_pid=0
 last_test_failed=0
 last_test_skipped=0
 last_test_ignored=1
+cappid=""
 
 declare -A all_tests
 declare -a only_tests_ids
@@ -887,6 +888,34 @@ check_cestab()
 	fi
 }
 
+cond_start_capture()
+{
+	if $capture; then
+		local capuser
+		if [ -z $SUDO_USER ] ; then
+			capuser=""
+		else
+			capuser="-Z $SUDO_USER"
+		fi
+
+		local capfile=$(printf "mp_join-%02u-%s.pcap" "$MPTCP_LIB_TEST_COUNTER" "${listener_ns}")
+
+		echo "Capturing traffic for test $MPTCP_LIB_TEST_COUNTER into $capfile"
+		ip netns exec $1 tcpdump -i any -s 65535 -B 32768 $capuser -w $capfile > "$capout" 2>&1 &
+		cappid=$!
+
+		sleep 1
+	fi
+}
+
+cond_stop_capture()
+{
+	if $capture; then
+	    sleep 1
+	    kill $cappid
+	fi
+}
+
 do_transfer()
 {
 	local listener_ns="$1"
@@ -896,7 +925,6 @@ do_transfer()
 	local connect_addr="$5"
 
 	local port=$((10000 + MPTCP_LIB_TEST_COUNTER - 1))
-	local cappid
 	local FAILING_LINKS=${FAILING_LINKS:-""}
 	local fastclose=${fastclose:-""}
 	local speed=${speed:-"fast"}
@@ -905,22 +933,7 @@ do_transfer()
 	:> "$sout"
 	:> "$capout"
 
-	if $capture; then
-		local capuser
-		if [ -z $SUDO_USER ] ; then
-			capuser=""
-		else
-			capuser="-Z $SUDO_USER"
-		fi
-
-		capfile=$(printf "mp_join-%02u-%s.pcap" "$MPTCP_LIB_TEST_COUNTER" "${listener_ns}")
-
-		echo "Capturing traffic for test $MPTCP_LIB_TEST_COUNTER into $capfile"
-		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -w $capfile > "$capout" 2>&1 &
-		cappid=$!
-
-		sleep 1
-	fi
+	cond_start_capture ${listener_ns}
 
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat -n
@@ -1007,11 +1020,6 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	if $capture; then
-	    sleep 1
-	    kill $cappid
-	fi
-
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat | grep Tcp > /tmp/${listener_ns}.out
 	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
@@ -2160,6 +2168,34 @@ signal_address_tests()
 			chk_add_nr 3 3
 		fi
 	fi
+
+	if reset "port-based signal endpoint must not accept mpc"; then
+		local port=$((10000 + MPTCP_LIB_TEST_COUNTER - 1))
+
+		cond_start_capture ${ns1}
+
+		pm_nl_add_endpoint ${ns1} 10.0.2.1 flags signal port ${port}
+		mptcp_lib_wait_local_port_listen ${ns1} ${port}
+
+		timeout 1 ip netns exec ${ns2} \
+			./mptcp_connect -t ${timeout_poll} -p $port -s MPTCP 10.0.2.1 >/dev/null 2>&1
+		local ret=$?
+
+		cond_stop_capture
+
+		if [ ${ret} = 124 ]; then
+			fail_test "timeout on connect"
+		elif [ ! ${ret} ]; then
+			fail_test "unexpected successful connect"
+		else
+			local count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPCAttemptOnEndpoint")
+			if [ "${count}" != 1 ]; then
+				fail_test "got ${count} MPC attempts on port-based enpoint, expected 1"
+			else
+				print_ok
+			fi
+		fi
+	fi
 }
 
 link_failure_tests()
-- 
2.45.2

