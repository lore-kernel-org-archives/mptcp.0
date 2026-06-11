Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAFF367B8A
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209978; cv=pass; b=DTvsjxU19EtHJCDA2nF/+n9KySGZSV3fMBacyojgBxHOjc1190dKBL56TKX9zCfi6U9bukgL3vBoYZ0IwrjH39+OeiSFm8Sx3sJr3vh7eAhl4sr7OjBcoZZQZCmxCpUeg6rmHeGmJwuf9TZFR32bG2MwQ6Mv7YQXHULPwEfY/8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209978; c=relaxed/simple;
	bh=Qo+DvguPH2idkNe2yTINGjMEbVyf3DXW/ZklaEhLnuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YU0dfI+UGX72Jvld+Bwor8XDBslnvBiq44TlQeHd9HbmwzdOcuhpn969bOlPHSXkCGCb1y8xylgGSXI4M/AjD/3MLR3UdUg/JxQzwnK4adQIiu7Tw+6xG9WiPElXChNVipcz7ogzTVbEjrkx9QpohBcYwtdMIzhS2ljkNC16C5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=OivsTYe3 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="OivsTYe3"
ARC-Seal: i=1; a=rsa-sha256; t=1781209957; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bIka67mB8dni7XVFGO9MO6yp0wsdar3hijtLf2apTzZZ19DALogUBfr5LTZ1dICCmPn+9iCo4CfY1NgSZWkMCRTVpZtpoVX1S803A4ZfL6BvarZOgTV7RI1VtvquHuZYRtJGxLMRg3hmqijEVByFkaC7IIGFzHv/UTvI2ugSssY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781209957; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=G0zTt0gN8fUa8JULFkf251pW+/4azX6DKyuu1F3Kxo0=; 
	b=jZU6HuwVXA/zVLFJbI1i0YsXxDWh4Oq0hFruG0S9ot0O/Ir+ICRzb98cl0yg9E5apR2nsSzHn2xi/jt1RZuGdf72+vVCrl+q98MY/UFSEee44BzwbHN6PRWCMclzMgcJfnLslv93fK29Peql0H8wnB75TCwh1P00m2W2uTEDYik=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781209957;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=G0zTt0gN8fUa8JULFkf251pW+/4azX6DKyuu1F3Kxo0=;
	b=OivsTYe3kL+AwjLarAia/Ql6OCSAVHz3cOWTTzTNzpaYA1EedAken473CeXndO3a
	51MgfyNNGZPBxnPn457wqsoxB52i0Io/VfXuCHxmqDDSniqw2TH1vm80v4ceCx38+We
	Si8m/XndGAi94HySofe532sOxmbyqSNwcvUNHWOM=
Received: by mx.zohomail.com with SMTPS id 1781209956732633.6895611809284;
	Thu, 11 Jun 2026 13:32:36 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	pabeni@redhat.com,
	kalpan.jani@mpiricsoftware.com,
	janak@mpiric.us,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH v4 2/2] selftests: mptcp: check per-event MPTCP_RST_EMPTCP counters
Date: Fri, 12 Jun 2026 02:02:19 +0530
Message-Id: <20260611203219.3448354-3-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611203219.3448354-1-shardul.b@mpiricsoftware.com>
References: <20260611203219.3448354-1-shardul.b@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

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
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 550a6b6117a98..25768e700067c 100755
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
2.34.1

