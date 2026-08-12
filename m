Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093154582CC;
	Wed, 12 Aug 2026 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546584; cv=none; b=qsW7h+/PWJYKpp9HYY5/4gnVaiyRH1IGNZloi51j2JpHJZVBrKdTEYvvDGMOz4BkQwD0EPdN6zcIedwWbEHWvOO5oVQvKLLchDaOTJUfUnxECs41g/WS/qYRsajXgpBTxw4umd56j29Ms3NXfr8kCb0of4tv3OGVjjqDZn5hdiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546584; c=relaxed/simple;
	bh=LzYlqMxOnrP3ac6yswSD0OrjsAL0XQTnCxoappByfew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SaEQBA8CyrjrfrjxOUL74UsVwPevxM1RzDT//cjX09YOWvjafQRVp5z4Rzg66O5TVzA4fGhX64YPl3fnOFCOAT5KnlIduYrAropyUayXkAH/WarKb4/BqvnhuRLEoxiDETxEJgJ+UbQcq2VrrRthHMt6Iy4Ns+7nWRLRB9wlOTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDeHcnzi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDeHcnzi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288021F000E9;
	Wed, 12 Aug 2026 14:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786546572;
	bh=BHTexpgUJnus0ibGvazLufzJY+HblJSMIlw5P4v/khQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jDeHcnzixOf2HAqQlmgZreaNMJfkzlEHda1XUm4AEeCYwoqsVxYGJlYUtms8IlDyY
	 p3uKJjWrh7TwThjnf7V9yszZWtNhGxh8xXgnYbe5x0PaRDSsmmDcGlZWvIVjNfNP/U
	 enmsMntah9FgKPoEAhwn98V5Ugonb/0hRfM2XhNrwJNlMcAnlXcEoOFXbb2vDKuot0
	 m8uX2f9YVOyVFfnqnMf0PEg7KDEvLbDvi5wmriCoUt3KYYIlOSnlgse009gsU33OQR
	 H9svguOTdkJH9gCTTtlFbdmP7sQIhylKQ3oHLzNoDoypYXypnpcbcQZSt6SXMFf8mw
	 X9f37GOBj8HGw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Aug 2026 16:55:41 +0200
Subject: [PATCH net-next 06/11] selftests: mptcp: check per-event
 MPTCP_RST_EMPTCP counters
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-net-next-mptcp-misc-feat-7-3-v1-6-1905a818f6cb@kernel.org>
References: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
In-Reply-To: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6256; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/Iroxz+d24z4W4nzpbaKXj8fb/69PMlTOJqVyPvoEGk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJqOstcD7jo/GyeUCT29uyOj9rfrDe+3RFTJl6hsrfU0
 OC2q8vajlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImsqWX4Zxy3PrySP3yLwqpb
 k5melqxP3zP/WbjzI0uHyQt4tC9ILWdkuMSz+v464xn6///u1N4jFiX7TGBS554iu9vLJ8ZfexV
 2jQMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Shardul Bankar <shardul.b@mpiricsoftware.com>

Add named env-var expectations for each per-event MPTCP_RST_EMPTCP
counter, matching the pattern used by the existing JOIN/RST checks.
Each defaults to 0 and is checked silently on success; a mismatch prints
a check line and fails the test.  Counters absent from the running
kernel are skipped silently so older kernels do not false-fail.

The JOIN-related counters (MPJoinSynAckNoMPJoin, MPJoinAckNoMPJoin,
MPJoinAckNoCtx, MPJoinNotEstablished, MPJoinNoIdFound) are checked in
chk_join_nr() on fixed namespaces; the two remaining reset counters
(MD5SigReset, DssReset) stay in chk_rst_nr().

Add a test at the end of signal_address_tests that triggers
MPJoinSynAckNoMPJoin: ns1 signals an address that is already bound on
the client (ns2), where a TCP-only mptcp_connect listener is started.
The client's MP_JOIN routes locally to the TCP listener, which responds
with a plain SYN/ACK without the MP_JOIN option, and the new counter
increments on the client side.

Other per-event counters (MD5SigReset, MPJoinAckNoMPJoin, MPJoinAckNoCtx,
DssReset, MPJoinNotEstablished, MPJoinNoIdFound) are not currently
reachable from mptcp_join.sh; the env-var hooks are in place for future
tests to set expectations explicitly.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 93 +++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7dc91fac4917..9b9fb3de9da3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -75,6 +75,14 @@ unset join_syn_tx
 unset join_create_err
 unset join_bind_err
 unset join_connect_err
+unset join_synack_no_mpjoin
+unset join_ack_no_mpjoin
+unset join_ack_no_ctx
+unset join_not_established
+unset join_no_id_found
+
+unset rst_md5sig
+unset rst_dss
 
 unset fb_ns1
 unset fb_ns2
@@ -1353,6 +1361,8 @@ chk_rst_nr()
 	local rst_tx=$1
 	local rst_rx=$2
 	local ns_invert=${3:-""}
+	local md5sig=${rst_md5sig:-0}
+	local dss=${rst_dss:-0}
 	local count
 	local ns_tx=$ns1
 	local ns_rx=$ns2
@@ -1389,6 +1399,21 @@ chk_rst_nr()
 	else
 		print_ok
 	fi
+
+	# MPTCP_RST_EMPTCP reset-event counters; default 0, gated on
+	# availability.  Fixed namespaces: MD5SigReset fires on the listener
+	# (server), DssReset on the data receiver (client).
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMD5SigReset")
+	if [ -n "$count" ] && [ "$count" != "$md5sig" ]; then
+		print_check "MD5SigReset"
+		fail_test "got $count MD5SigReset expected $md5sig"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtDssReset")
+	if [ -n "$count" ] && [ "$count" != "$dss" ]; then
+		print_check "DssReset"
+		fail_test "got $count DssReset expected $dss"
+	fi
 }
 
 chk_infi_nr()
@@ -1587,6 +1612,11 @@ chk_join_nr()
 	local rst_nr=${join_rst_nr:-0}
 	local infi_nr=${join_infi_nr:-0}
 	local corrupted_pkts=${join_corrupted_pkts:-0}
+	local synack_no_mpjoin=${join_synack_no_mpjoin:-0}
+	local ack_no_mpjoin=${join_ack_no_mpjoin:-0}
+	local ack_no_ctx=${join_ack_no_ctx:-0}
+	local not_established=${join_not_established:-0}
+	local no_id_found=${join_no_id_found:-0}
 	local rc=${KSFT_PASS}
 	local count
 	local with_cookie
@@ -1655,6 +1685,44 @@ chk_join_nr()
 		fail_test "got $count JOIN[s] syn rejected expected $syn_rej"
 	fi
 
+	# Per-event MPTCP_RST_EMPTCP JOIN counters; default 0, gated on
+	# availability.  Fixed namespaces: the *SynAck* one fires on the
+	# client receiving the SYN/ACK, the others on the server.
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynAckNoMPJoin")
+	if [ -n "$count" ] && [ "$count" != "$synack_no_mpjoin" ]; then
+		rc=${KSFT_FAIL}
+		print_check "synack no mpjoin"
+		fail_test "got $count JOIN[s] synack no mpjoin expected $synack_no_mpjoin"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckNoMPJoin")
+	if [ -n "$count" ] && [ "$count" != "$ack_no_mpjoin" ]; then
+		rc=${KSFT_FAIL}
+		print_check "ack no mpjoin"
+		fail_test "got $count JOIN[s] ack no mpjoin expected $ack_no_mpjoin"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckNoCtx")
+	if [ -n "$count" ] && [ "$count" != "$ack_no_ctx" ]; then
+		rc=${KSFT_FAIL}
+		print_check "ack no ctx"
+		fail_test "got $count JOIN[s] ack no ctx expected $ack_no_ctx"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinNotEstablished")
+	if [ -n "$count" ] && [ "$count" != "$not_established" ]; then
+		rc=${KSFT_FAIL}
+		print_check "join not established"
+		fail_test "got $count JOIN[s] not established expected $not_established"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinNoIdFound")
+	if [ -n "$count" ] && [ "$count" != "$no_id_found" ]; then
+		rc=${KSFT_FAIL}
+		print_check "join no id found"
+		fail_test "got $count JOIN[s] no id found expected $no_id_found"
+	fi
+
 	print_results "join Rx" ${rc}
 
 	join_syn_tx="${join_syn_tx:-${syn_nr}}" \
@@ -2359,6 +2427,31 @@ signal_address_tests()
 			chk_add_nr 4 4
 		fi
 	fi
+
+	# signalled address belongs to the client, where a TCP-only
+	# listener is bound at it: the client's MP_JOIN routes locally
+	# to the listener and receives a SYN/ACK without MP_JOIN.
+	# MPJoinSynAckNoMPJoin increments on the client side.
+	if reset "signal address, TCP-only listener on client"; then
+		local extra_bind
+		local port
+
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns1 10.0.2.2 flags signal
+
+		port=$(get_port)
+		ip netns exec ${ns2} ./mptcp_connect -l -t -1 -p "$port" \
+			-s TCP 10.0.2.2 &
+		extra_bind=$!
+		mptcp_lib_wait_local_port_listen "$ns2" "$port"
+
+		run_tests $ns1 $ns2 10.0.1.1
+		join_synack_no_mpjoin=1 join_syn_tx=1 \
+			chk_join_nr 0 0 0
+
+		kill ${extra_bind} 2>/dev/null
+	fi
 }
 
 laminar_endp_tests()

-- 
2.53.0

