Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792996634;
	b=nHE+Mx8QPeVbW/YGbP153/S9KEAz6q5OH9kIBpFBWV/owAn3z2aggk1MMhWwNd1lRmKd
	 1DDCYbvcvcceUeZkMmgu02NR0TGpqRso/vjtKsUu9CC32IOa5cbulXe/KbX28lt88Uy4/
	 iComLZgGthGRq1UloZ/LsyV6Hd42zCyJXNxfBhXdWUbx7mei2yzZgIE7winDed6o+Bd+h
	 1FWLk0I9VskY3SjkS9xTGD4NaYdv5YpOdp403tSFkUpBkp+pATxIbinEZgPri53j6nqY5
	 r3RqkmmeOSJ6W/en3WnZhbCVMmNz9f7ufgfk67UPIUftq3PWPtQQWWnM4i6o5eBR2GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792996634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nZ1ISpUzXpxjtn8ICSnDrkmh3D2uUbF+KbGS6rMkJYY=;
	b=BXHnXNpkafokdFgkOaeCVRqhjLasVxgrsch88zNcqxpMbaRsYSO8zvoQJbapMXu1Xrql
	 NHtpyLPFxt0Xx0oVPB2RFIrGkoaOjUxPgWK5ApICE5QgH6FDe2I4m1Pg/yqecHBtoXn5J
	 02Q2q9fKiarltwns94z9izRonkR7Zui3+MErYLwxrtBcM8AWbvOLHEE4kuoJdEoVEdSNt
	 +rGVEqOR2kp4ZMqzi54gBME6GlE74UPAX3EVniH3H10zv5/zyprFqQh1dnRc1z5s8KJm5
	 GVNmumx/AGiLsN2gkw9FvJeQ+E1rC2fc1GJuMU4yQeiCA3Ni1qA9bhmJRxZ+XKIkfSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ndE7T0CN;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508E7606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 06:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 508E7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ndE7T0CN
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35c76e9614aso4317707eec.0
        for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 23:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792996633; x=1793601433; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nZ1ISpUzXpxjtn8ICSnDrkmh3D2uUbF+KbGS6rMkJYY=;
        b=ndE7T0CNYoI4rgOdC+l7kq8KnYbetNBv4/qzHvXWrRy04VZ8aFcEWnAsp7TGfDWNev
         laXEX0028wZPxA5upenw+34m8sJM9zNoMzlpYJcnFm1nRschRCPz9NPcXyLXsbs/jVAb
         p+6HnoS1zO4gBCM/3Z/v4ntLDP9i7+PRbXmj+UEKKhq0r0YHGzvIzON95hIDPqvgUvt9
         9x4VKumFUN2BU/3gQuXIY4jl61a7ivNeCmmD+tWQdVUM5Z/ByQR8mpSWsvtfmxLMr8pg
         tm+V25LDKO2Pk8Uggs2RESJmofRK+54Y15Lv/cQ92BdsL3PRW8xAPEec+E3Id8ZSczbH
         e+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792996633; x=1793601433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nZ1ISpUzXpxjtn8ICSnDrkmh3D2uUbF+KbGS6rMkJYY=;
        b=tpjidW1NR7qOPe8WXGALfLSipQYgVASpMfxYwKTtzGHWNj5qszAu6M7G8rdQZ6yqjH
         WMHsR5DCmg3GMEgjsaBNwtIb/Kna1//NmfF6xUQkVqUQupyZJNJFtPYj3pgCiBTunT1Y
         I0F9gbzggf6L5JvmYYW9lmkpwpBVGGSzffvaviOoACROkkQnRO1eMvW+l8DYg1pUUTw3
         l+bGjvq7VHEhSqeWvJkj0G4j+ar/RS/itCAhj59d25OIrv+2MrLKH/omLcwBLcBCLJC7
         q+ttbgxi573GJ1heOuLDASeZaw4MkireWZs1lMq6GsWRe0QnFZIJ3nKZdo44hoRwOMij
         xrBQ==
X-Gm-Message-State: AFq9FYLglz+tHfrqYXCxErYNBvGeL7SQHMY9wTw3kj/40YDK/Z8X/cU+
	mMhyKgLhEET8ymKVFzL/W6Ro0zZfjAp/Iy4iGa+X/K/ZKL/ncG/lHDPCX9ZnPQ==
X-Gm-Gg: AYBFou0UOUI5gYFWruvokcJ4SNWo7AErIUA/ZpxK6qjAX57Dm6uDPSEobJleBvtLspJ
	lhc8dwlQda595czlBgbCFeSN19IOHMBUBbvlL3/cq2eTbRGFtu5HZnLba8CYrMAQnZJHcC6F3o4
	3AIYowEX9E7xgETX5TJJjYViRYpd1PwTPwB1o8i4TQiIfeVctFCpCgl/cpdTL7ihxqS9NWoEbaw
	4Y8SIQrLmAnpIw5x/fX5ttmogws3S+DS0/3fKNHcalUoV+DXIq7xQilkPrNQ6Fph8pqB7DVRTdH
	HsdiJTSJzHdhNZQKrBmtvYycLMBd1WKz6u0/5lcGDSNYjMYybezQySH/ZmAX04IHtunPeibuWQ+
	UgtrHcmJReUb1joW3AoK6xuQNyxUJro/JGzn1+wGVRlxDIu+ZZ6Y8KrFJKjgThm+JUKUxv1QxSk
	plT279wmigDbDg1ig0sm9awmS4ZuCqH04xb3w1ytIps79ebckL2ubdMiq7OejWi/2nimBPqDgFW
	6t+HxMBSYmr2Voaxln6xXI59zRBypwFzafdJwSwOwtRv2MN2O5pLpJ4DuzpvtCfI8bBeHWHcuqV
	svWPGIpzGbhWNqjLKIyEGewLCnQR+zcykWbGyqndjqUzMA+6ZBWFtHhKU63hkNovdZPKbhy7Qpk
	j7OZXHUqdYdK3aC8c5mr4q2qH
X-Received: by 2002:a05:7300:ec14:b0:351:202c:c7a5 with SMTP id 5a478bee46e88-369e81c4c2bmr13935987eec.0.1792996632949;
        Sun, 25 Oct 2026 23:37:12 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ef6a71a4sm21191609eec.8.2026.10.25.23.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:37:12 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v10 6/6] selftests: mptcp: join: validate subflow retry after link failure
Date: Mon, 26 Oct 2026 06:36:57 +0000
Message-Id: <20261026063657.2955783-7-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261026063657.2955783-1-anilkaushikwireless@gmail.com>
References: <20261026063657.2955783-1-anilkaushikwireless@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the subflow-retries limit, with its default value, and a long
connection in the background: drop the packets the client sends from
the additional subflow address with netfilter, without bringing the link
down, until the subflow is closed and re-created. Let them through again
once the SYN of the new subflow has been retransmitted more times than
tcp_syn_retries allows, and check the subflow comes back from the same
address. Then do the same with the initial subflow.

A second test closes the connection while a subflow is being re-created,
and checks the netlink events. Only the client sends data: the server
reads it all first, in sendfile mode, and keeps its side open. The
client gets a big MPTCP send buffer compared to its subflows, and both
paths are blocked: the data left in it is never sent, nor the DATA_FIN,
so only the close of the MPTCP socket can stop the subflow being
re-created. Only the client is closed: it has nothing left to read, so
the connection is not closed with a fastclose, which would reset all the
subflows anyway. The check is skipped if a fastclose happens. The big
files used for the long connection are emptied at the end.

A third test re-creates the only subflow, and checks the connection is
still closed after the close timeout, the new subflow being unable to
connect. A fourth one lets the path come back before the close timeout,
and checks the connection stays open.

The tests are skipped if pm_nl_ctl does not show the new limit, or if the
filter rules cannot be set.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v10:
     - new test: the path of the only subflow comes back before the
       close timeout, and the connection stays open (sashiko.dev)
       The path comes back as soon as the subflow is re-created, with a
       30s close timeout, longer than the SYN backoff, and its transfer
       has a longer poll timeout, with no data at all while the only path
       is blocked: both are needed on a slow debug kernel
    v9:
     - wait for absolute counter values, read before blocking the path,
       or 0 and 1 in the new netns: the subflow can be re-created before
       a later read (netdev Sashiko)
     - check that the connection is established before blocking it, in
       the close test and the new one (netdev Sashiko)
     - the close test blocks the other path too, with a big msk send
       buffer: the pending data and the DATA_FIN no longer close the
       subflow being re-created, only the close of the MPTCP socket can.
       Checked: both the close test and the new test fail without their
       fix
     - new test: the only subflow is re-created, and the connection is
       still closed after the close timeout
     - $sinfail as the server input, kill errors ignored, clearer failure
       message, $cout and $sout emptied too
     - the server of the second test reads all the data from the client
       first, in sendfile mode, instead of blocking on a FIFO in poll
       mode: the client always has data in flight (netdev Sashiko)
    v8:
     - comment in run_tests() matching the new condition (netdev Sashiko)
     - a separate test closes the connection while a subflow is
       re-created: the server sends nothing but keeps its side open, and
       only the client is closed, so there is no fastclose, which would
       reset all the subflows anyway; the check is skipped if one happens
       (netdev Sashiko)
    v7 (netdev Sashiko):
     - the test_linkfail=1/2 modes regenerate the shared files when they
       are empty, e.g. when running link_failure_tests() twice
     - read the MP_JOIN ACK counter before letting the packets through,
       and do not compare the ports, they can be reused
    v6 (Sashiko):
     - use the slowwait helpers from net/lib.sh
     - longer first wait, while the 128 MB files are created
     - skip if the filter rules cannot be set, check each drop rule
       (netdev Sashiko)
     - empty the big files at the end, cinsent too, keep the variables
       (netdev Sashiko)
    v5 (Matthieu):
     - skipped if pm_nl_ctl does not show the new limit
     - wait for the SYN retransmissions instead of a sleep, with
       tcp_syn_linear_timeouts=0
     - helper for the check after the close
     - slower links with short queues, so the transfer lasts the whole
       test on any machine, longer timeout (killed at the end)
    v4:
     - default limit, no sysctl or MIB counter
     - more SYN retransmissions than tcp_syn_retries
     - close the connection while a subflow is re-created
     - check the netlink events
     - check the waits and the new subflow port, remove the big files at
       the end (Sashiko)
    v3:
     - check the subflow address, create the files before the background job
    v2:
     - one test, with netfilter

 .../testing/selftests/net/mptcp/mptcp_join.sh | 399 +++++++++++++++++-
 1 file changed, 391 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c3ccce96b45b..3fa561b1a8fd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -52,6 +52,7 @@ nr_blank=6
 # These var are used only in some tests, make sure they are not already set
 unset FAILING_LINKS
 unset test_linkfail
+unset server_in
 unset addr_nr_ns1
 unset addr_nr_ns2
 unset cestab_ns1
@@ -1038,7 +1039,12 @@ do_transfer()
 	fi
 
 	extra_srv_args="$extra_args $extra_srv_args"
-	if [ "$test_linkfail" -gt 1 ];then
+	if [ -n "${server_in}" ]; then
+		# the server reads all the data from the client before sending
+		# this file: it does not block on its input
+		extra_srv_args="$extra_srv_args -m sendfile"
+		listener_in="${server_in}"
+	elif [ "$test_linkfail" -gt 1 ]; then
 		listener_in="${sinfail}"
 	fi
 	ip netns exec ${listener_ns} \
@@ -1135,9 +1141,9 @@ run_tests()
 			cinfail=$(mktemp)
 		fi
 		make_file "$cinfail" "client" $size
-	# create the input file for the failure test when
-	# the first failure test run
-	elif [ "$test_linkfail" -ne 0 ] && [ -z "$cinfail" ]; then
+	# create the input file for the failure test, when
+	# it is missing or has been emptied
+	elif [ "$test_linkfail" -ne 0 ] && [ ! -s "$cinfail" ]; then
 		# the client file must be considerably larger
 		# of the maximum expected cwin value, or the
 		# link utilization will be not predicable
@@ -1146,23 +1152,27 @@ run_tests()
 		size=$((size*8192))
 		size=$((size + ( RANDOM % 8192) ))
 
-		cinfail=$(mktemp)
+		if [ -z "$cinfail" ]; then
+			cinfail=$(mktemp)
+		fi
 		make_file "$cinfail" "client" $size
 	fi
 
-	if [ "$test_linkfail" -gt 2 ]; then
+	if [ "$test_linkfail" -gt 2 ] && [ -z "${server_in}" ]; then
 		size=$test_linkfail
 
 		if [ -z "$sinfail" ]; then
 			sinfail=$(mktemp)
 		fi
 		make_file "$sinfail" "server" $size
-	elif [ "$test_linkfail" -eq 2 ] && [ -z "$sinfail" ]; then
+	elif [ "$test_linkfail" -eq 2 ] && [ ! -s "$sinfail" ]; then
 		size=$((RANDOM%16))
 		size=$((size+1))
 		size=$((size*2048))
 
-		sinfail=$(mktemp)
+		if [ -z "$sinfail" ]; then
+			sinfail=$(mktemp)
+		fi
 		make_file "$sinfail" "server" $size
 	fi
 
@@ -2151,6 +2161,237 @@ wait_attempt_fail()
 	return 1
 }
 
+# $1: timeout in seconds ; $2: ns ; $3: counter ; $4: increment, 1 by default
+wait_counter_inc()
+{
+	slowwait_for_counter "${1}" "${4:-1}" \
+		mptcp_lib_get_counter "${2}" "${3}" >/dev/null
+}
+
+# $1: timeout ; $2: ns ; $3: counter ; $4: value to reach
+wait_counter_ge()
+{
+	slowwait "${1}" until_counter_is ">= ${4}" \
+		mptcp_lib_get_counter "${2}" "${3}" >/dev/null
+}
+
+# $1: client address ; prints the local address and port of its subflow
+sf_from()
+{
+	ip netns exec $ns2 ss -tnH state established src "${1}" |
+		awk '{ print $3; exit }'
+}
+
+has_subflow_retries()
+{
+	ip netns exec $ns2 ./pm_nl_ctl limits | grep -q "^subflow_retries"
+}
+
+# the client packets are dropped with rules in this chain
+init_nft_filter()
+{
+	init_nftables
+	if ! ip netns exec $ns2 nft list chain ip filter OUTPUT \
+	     &>/dev/null; then
+		mark_as_skipped "unable to set the filter rules"
+		return 1
+	fi
+}
+
+# $1: client address
+nft_drop_from()
+{
+	ip netns exec $ns2 nft add rule ip filter OUTPUT ip saddr "${1}" drop
+}
+
+# $1: client address to block
+#
+# The link stays up, but the client packets from this address are dropped:
+# the subflow using it is closed after a few retransmissions, and re-created.
+# The packets go through again once the SYN has been retransmitted more times
+# than tcp_syn_retries allows: the new subflow still connects thanks to the
+# subflow-retries limit.
+sf_retry_after_block()
+{
+	local before ack_rx syn_tx
+
+	before=$(sf_from "${1}")
+
+	print_check "subflow from ${1}"
+	if [ -z "${before}" ]; then
+		fail_test "no established subflow from ${1} before the block"
+		return
+	fi
+
+	# read before the block: the subflow can be re-created right after it
+	syn_tx=$(mptcp_lib_get_counter $ns2 "MPTcpExtMPJoinSynTx")
+	if ! nft_drop_from "${1}"; then
+		fail_test "unable to drop the packets from ${1}"
+		return
+	fi
+	if ! wait_counter_ge "${timeout_poll}" $ns2 "MPTcpExtMPJoinSynTx" \
+	     $((syn_tx + 1)); then
+		ip netns exec $ns2 nft flush chain ip filter OUTPUT
+		fail_test "subflow from ${1} not re-created"
+		return
+	fi
+	# tcp_syn_retries=1: one more retransmission than allowed
+	if ! wait_counter_inc "${timeout_poll}" \
+		$ns2 "TcpExtTCPSynRetrans" 2; then
+		ip netns exec $ns2 nft flush chain ip filter OUTPUT
+		fail_test "SYN from ${1} not retransmitted enough"
+		return
+	fi
+	# read before the flush: the next SYN can be sent right after it
+	ack_rx=$(mptcp_lib_get_counter $ns1 "MPTcpExtMPJoinAckRx")
+	ip netns exec $ns2 nft flush chain ip filter OUTPUT
+
+	if ! wait_counter_ge "${timeout_poll}" $ns1 "MPTcpExtMPJoinAckRx" \
+	     $((ack_rx + 1)); then
+		fail_test "re-created subflow from ${1} not established"
+		return
+	fi
+
+	if [ -z "$(sf_from "${1}")" ]; then
+		fail_test "no established subflow from ${1}"
+	else
+		print_ok
+	fi
+}
+
+# $1: ns ; prints the number of MP_FASTCLOSE sent and received
+fastclose_nr()
+{
+	local tx rx
+
+	tx=$(mptcp_lib_get_counter "${1}" "MPTcpExtMPFastcloseTx")
+	rx=$(mptcp_lib_get_counter "${1}" "MPTcpExtMPFastcloseRx")
+	echo $((${tx:-0} + ${rx:-0}))
+}
+
+no_sf_connecting()
+{
+	! ip netns exec $ns2 ss -tnH state syn-sent | grep -q .
+}
+
+# $1: client address of the only subflow ; $2: close timeout
+#
+# The subflow is blocked and re-created, and its path comes back right away:
+# the new subflow connects before the close timeout, and keeps the connection
+# open after it.
+chk_sf_retry_path_back()
+{
+	print_check "open after the close timeout"
+	if ! wait_counter_ge $((timeout_poll * 4)) \
+	     $ns1 "MPTcpExtMPCapableACKRX" 1; then
+		fail_test "connection not established"
+		return
+	fi
+	if ! nft_drop_from "${1}"; then
+		fail_test "unable to drop the packets from ${1}"
+		return
+	fi
+	# no other subflow: the first MP_JOIN SYN is the re-created one
+	if ! wait_counter_ge "${timeout_poll}" \
+	     $ns2 "MPTcpExtMPJoinSynTx" 1; then
+		ip netns exec $ns2 nft flush chain ip filter OUTPUT
+		fail_test "subflow from ${1} not re-created"
+		return
+	fi
+	ip netns exec $ns2 nft flush chain ip filter OUTPUT
+	if ! wait_counter_ge "${timeout_poll}" \
+	     $ns1 "MPTcpExtMPJoinAckRx" 1; then
+		fail_test "re-created subflow from ${1} not established"
+		return
+	fi
+
+	# the close timeout started when the subflow was re-created
+	sleep $((${2} + 2))
+	if [ "$(fastclose_nr $ns2)" -gt 0 ]; then
+		fail_test "closed with a fastclose"
+	elif [ -z "$(sf_from "${1}")" ]; then
+		fail_test "no established subflow from ${1}"
+	else
+		print_ok
+	fi
+}
+
+# The client has nothing left to read: it closes the connection without a
+# fastclose, which would reset all the subflows anyway.
+kill_client()
+{
+	local pid
+
+	for pid in $(ip netns pids $ns2); do
+		if [ "$(cat "/proc/${pid}/comm" 2>/dev/null)" = mptcp_connect ]
+		then
+			kill "${pid}" 2>/dev/null
+		fi
+	done
+}
+
+# $1: why the subflow is not being re-created before the close, if it is not
+# $2: number of MP_FASTCLOSE before the close
+chk_no_sf_connecting()
+{
+	local closed
+
+	print_check "no subflow connecting after close"
+	if [ -n "${1}" ]; then
+		fail_test "${1}"
+		return
+	fi
+
+	# closed with the MPTCP socket
+	slowwait "${timeout_poll}" no_sf_connecting
+	closed=$?
+	if [ "$(fastclose_nr $ns2)" -gt "${2}" ]; then
+		print_skip "closed with a fastclose, resetting all the subflows"
+	elif [ "${closed}" -eq 0 ]; then
+		print_ok
+	else
+		fail_test "subflow still connecting after close"
+	fi
+}
+
+# Slow links with short queues: the transfer lasts the whole test on any
+# machine, and the blocked subflow always has data in flight.
+sf_retry_init()
+{
+	local i
+
+	for i in 1 3; do
+		tc -n $ns1 qdisc add dev ns1eth$i root netem \
+			rate 4mbit limit 30 delay 1ms
+		tc -n $ns2 qdisc add dev ns2eth$i root netem \
+			rate 4mbit limit 30 delay 1ms
+	done
+	ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3
+	ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_retries=1
+	ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_linear_timeouts=0
+	pm_nl_set_limits $ns1 0 4
+	pm_nl_set_limits $ns2 0 2
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+	# created here, not in the background job, for cleanup()
+	if [ -z "$cinfail" ]; then
+		cinfail=$(mktemp)
+	fi
+	if [ -z "$sinfail" ]; then
+		sinfail=$(mktemp)
+	fi
+}
+
+sf_retry_cleanup()
+{
+	ip netns exec $ns2 nft flush chain ip filter OUTPUT
+	# big files: empty them, the next tests write their own content
+	: > "$cinfail"
+	: > "$sinfail"
+	: > "$cinsent"
+	: > "$cout"
+	: > "$sout"
+}
+
 set_userspace_pm()
 {
 	local ns=$1
@@ -2585,6 +2826,148 @@ link_failure_tests()
 		chk_stale_nr $ns2 1 -1 2
 		chk_link_usage $ns2 ns2eth3 $cinsent 50
 	fi
+
+	# subflows closed after a silent link failure, then re-created: the
+	# additional one, then the initial one
+	if reset_with_events "subflow retry after link failure" &&
+	   continue_if has_subflow_retries && init_nft_filter; then
+		sf_retry_init
+		# killed at the end: the timeout only stops a stuck test
+		{ timeout_test=600 test_linkfail=131072 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		# the 128 MB files are created first, that can take a while
+		wait_counter_ge $((timeout_poll * 4)) \
+			$ns1 "MPTcpExtMPJoinAckRx" 1
+		sf_retry_after_block 10.0.3.2
+		sf_retry_after_block 10.0.1.2
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		join_syn_tx=3 chk_join_nr 3 3 3
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 3
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2 error 2
+		sf_retry_cleanup
+	fi
+
+	# close the connection while a subflow is being re-created
+	if reset_with_events "subflow retry, close while connecting" &&
+	   continue_if has_subflow_retries && init_nft_filter; then
+		sf_retry_init
+		# A big msk send buffer, compared to the subflow ones: when the
+		# client is closed, some data is not given to any subflow yet,
+		# so the DATA_FIN, which would also close the subflow being
+		# re-created, is not sent.
+		ip netns exec $ns2 sysctl -q \
+			net.ipv4.tcp_wmem="1048576 65536 262144"
+		# The server reads until the client closes, and sends nothing:
+		# the client has nothing to read, and the connection stays
+		# established. The transfer is stopped on purpose, its result
+		# is not checked.
+		: > "$sinfail"
+		{ timeout_test=600 test_linkfail=131072 server_in="$sinfail" \
+			run_tests $ns1 $ns2 10.0.1.1 >/dev/null & } 2>/dev/null
+		local tests_pid=$!
+
+		local not_ready="" syn_tx
+		if ! wait_counter_ge $((timeout_poll * 4)) \
+		     $ns1 "MPTcpExtMPJoinAckRx" 1; then
+			not_ready="no additional subflow before the block"
+		else
+			# read before the block: the subflow can be re-created
+			# right after it
+			syn_tx=$(mptcp_lib_get_counter $ns2 \
+				"MPTcpExtMPJoinSynTx")
+			if ! nft_drop_from 10.0.3.2; then
+				not_ready="unable to drop the packets"
+			elif ! wait_counter_ge "${timeout_poll}" \
+			     $ns2 "MPTcpExtMPJoinSynTx" $((syn_tx + 1)); then
+				not_ready="no subflow re-created before close"
+			fi
+		fi
+		# Block the other path too, so this data is never sent: only
+		# the close of the MPTCP socket can then stop the subflow being
+		# re-created.
+		if [ -z "${not_ready}" ] && ! nft_drop_from 10.0.1.2; then
+			not_ready="unable to drop the packets"
+		fi
+		local fc_before
+		fc_before=$(fastclose_nr $ns2)
+		kill_client
+		chk_no_sf_connecting "${not_ready}" "${fc_before}"
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		join_syn_tx=2 chk_join_nr 1 1 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1 error 1
+		sf_retry_cleanup
+	fi
+
+	# the only subflow is re-created: the connection is still closed after
+	# the close timeout, the new subflow cannot connect
+	if reset_with_events "subflow retry, no other subflow" &&
+	   continue_if has_subflow_retries && init_nft_filter; then
+		sf_retry_init
+		pm_nl_flush_endpoint $ns2
+		ip netns exec $ns2 sysctl -q net.mptcp.close_timeout=5
+		{ timeout_test=600 test_linkfail=131072 \
+			run_tests $ns1 $ns2 10.0.1.1 >/dev/null & } 2>/dev/null
+		local tests_pid=$!
+
+		print_check "closed after the close timeout"
+		if ! wait_counter_ge $((timeout_poll * 4)) \
+		     $ns1 "MPTcpExtMPCapableACKRX" 1; then
+			fail_test "connection not established"
+		elif ! nft_drop_from 10.0.1.2; then
+			fail_test "unable to drop the packets"
+		# no other subflow: the first MP_JOIN SYN is the re-created one
+		elif ! wait_counter_ge "${timeout_poll}" \
+		     $ns2 "MPTcpExtMPJoinSynTx" 1; then
+			fail_test "no subflow re-created"
+		# closed with the connection, after 5 seconds
+		elif slowwait "${timeout_poll}" no_sf_connecting; then
+			print_ok
+		else
+			fail_test "subflow still connecting"
+		fi
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		join_syn_tx=1 chk_join_nr 0 0 0
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1 error 1
+		sf_retry_cleanup
+	fi
+
+	# the path of the only subflow comes back before the close timeout:
+	# the re-created subflow keeps the connection open
+	if reset_with_events "subflow retry, no other subflow, path back" &&
+	   continue_if has_subflow_retries && init_nft_filter; then
+		# The SYN retransmissions back off: long enough for the next one
+		# to be sent once the path is back, also on a slow machine.
+		local close_timeout=30
+
+		sf_retry_init
+		pm_nl_flush_endpoint $ns2
+		ip netns exec $ns2 sysctl -q \
+			net.mptcp.close_timeout=${close_timeout}
+		# no data at all while the only path is blocked: a longer poll
+		# timeout, so the transfer outlives the outage
+		{ timeout_poll=$((timeout_poll * 4)) timeout_test=600 \
+			test_linkfail=131072 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		chk_sf_retry_path_back 10.0.1.2 ${close_timeout}
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		join_syn_tx=1 chk_join_nr 1 1 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1 error 1
+		sf_retry_cleanup
+	fi
 }
 
 add_addr_timeout_tests()
-- 
2.25.1

