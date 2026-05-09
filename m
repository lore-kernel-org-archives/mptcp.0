Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9479C2F1FD0
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778351648; cv=pass; b=oJ7GPa0qVdNezRtdaMcmy5sSlgCf2pg1HQm7/zrCR0/dNQRag9tZsm7SSYOUi+xalLga2D92gKEEejCaA+hNuX14hHDX/Pe9I7V2ajn9EbjaRq+89QDXSzCbJUy9vqq8Cxgn1cgYdTY+aFRXDHmYQPwt9Ee+KylpqIG6JnEk4E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778351648; c=relaxed/simple;
	bh=ACNo50rRgsqgyyoSFxYGNE6RfpL7O9eTJNvtWV9VOv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j2gTGPW8NUhQXSah8QLe9Qq70x7slGNiL6ERpIZZ30faOA7hU1IJ38eaM/clU9Jo5manbCErHIAqUsrwbW871YaOFpObJiSiQmi3DsctTRBxDKf0B3kBhRNBb0e+fbRdczxjemy1jLg/0FFw4Q67GZ6sjeCjeNX1EikvmZLGuew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=k3WkmHWr reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="k3WkmHWr"
ARC-Seal: i=1; a=rsa-sha256; t=1778351636; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=imz1T6r9rAMKGkERFjfE36CRSC1voOGF/mIP+dDV9PIv3lV9hmqvny5voY9gBbr6xM8cRYxfP7wlAdkj7kFsIIsmbDyUNZ/4hhavml+dMLMhRQUZuEdwQBEIzSwEdHBIcz24DFdqN6rJ060pJLbWtyiTe0nK3T8nHv8ID8NaX3s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778351636; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oMQAP5M6L/WK5YpRtiCGE08zQPRosT4HRjQpTyZzUFc=; 
	b=MaWG+0HRfgqNwiKD5MiGqtBNXJu4wspA0EG+vHvhQpwlabCAgd35RzQRdu6yxKSYyik5/+f7vbmNOBPPUop90A4IjLehmKFHZhpWw+i+F91heHCrTrcydouPGTQXuNYqBQ61Qmw7nV3GdrEX1vLZxySS/s59DIdcGFuHCgh6CEM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778351636;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=oMQAP5M6L/WK5YpRtiCGE08zQPRosT4HRjQpTyZzUFc=;
	b=k3WkmHWrDshLUMpQMU3GKeITSKe+KZIsqB1+akcX/6jNkKGV6e/4Cry5g63YdD9v
	gB9m9w4LehbsNPyW//0TYBgyhI9AiGxrAVmoIvV8fDZ0bn+0y//1SdzO9Y7pKQNinJF
	UlAQr6XqeJob4SbgDN59yvkFkEb6+MHtmPwXS0u0=
Received: by mx.zohomail.com with SMTPS id 1778351634991540.3450645971392;
	Sat, 9 May 2026 11:33:54 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH v2 2/2] selftests: mptcp: extend chk_rst_nr to validate per-event RST counters
Date: Sun, 10 May 2026 00:03:35 +0530
Message-Id: <20260509183335.969018-2-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509183335.969018-1-shardul.b@mpiricsoftware.com>
References: <20260509183335.969018-1-shardul.b@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Extend chk_rst_nr() with named env-var expectations for each
per-event MPTCP_RST_EMPTCP counter, matching the pattern used by
chk_join_nr().  Each counter defaults to 0 and is checked silently
on success; mismatches print a check line and fail the test.
Counters absent from the running kernel are skipped silently so
older kernels do not false-fail.

Add a cross-namespace test that triggers MPJoinSynAckNoMPJoin: ns1
announces an address belonging to a third namespace (ns3) where
MPTCP is disabled, the client (ns2) JOINs to ns3 and receives a
plain TCP SYN/ACK without MP_JOIN, and the new counter increments
on the client side.

Other per-event counters (MD5SigReset, MPJoinAckNoMPJoin,
MPJoinAckNoCtx, DssReset, MPJoinNotEstablished) are not currently
reachable from mptcp_join.sh; the env-var hooks are in place for
future tests to set expectations explicitly.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
v2:
  New patch in this version, addressing the request from v1's
  review to validate the per-event counters in mptcp_join.sh.

 .../testing/selftests/net/mptcp/mptcp_join.sh | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5d4d0f127f79..5d4fc8951f05 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -76,6 +76,13 @@ unset join_create_err
 unset join_bind_err
 unset join_connect_err
 
+unset rst_md5sig_reset
+unset rst_synack_no_mpjoin
+unset rst_ack_no_mpjoin
+unset rst_ack_no_ctx
+unset rst_dss_reset
+unset rst_not_established
+
 unset fb_ns1
 unset fb_ns2
 unset fb_infinite_map_tx
@@ -1349,6 +1356,12 @@ chk_rst_nr()
 	local rst_tx=$1
 	local rst_rx=$2
 	local ns_invert=${3:-""}
+	local md5sig_reset=${rst_md5sig_reset:-0}
+	local synack_no_mpjoin=${rst_synack_no_mpjoin:-0}
+	local ack_no_mpjoin=${rst_ack_no_mpjoin:-0}
+	local ack_no_ctx=${rst_ack_no_ctx:-0}
+	local dss_reset=${rst_dss_reset:-0}
+	local not_established=${rst_not_established:-0}
 	local count
 	local ns_tx=$ns1
 	local ns_rx=$ns2
@@ -1385,6 +1398,43 @@ chk_rst_nr()
 	else
 		print_ok
 	fi
+
+	# Per-event MPTCP_RST_EMPTCP counters; default 0, gated on availability.
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMD5SigReset")
+	if [ -n "$count" ] && [ "$count" != "$md5sig_reset" ]; then
+		print_check "MD5SigReset ${tx}"
+		fail_test "got $count MD5SigReset expected $md5sig_reset"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPJoinSynAckNoMPJoin")
+	if [ -n "$count" ] && [ "$count" != "$synack_no_mpjoin" ]; then
+		print_check "MPJoinSynAckNoMPJoin ${rx}"
+		fail_test "got $count MPJoinSynAckNoMPJoin expected $synack_no_mpjoin"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinAckNoMPJoin")
+	if [ -n "$count" ] && [ "$count" != "$ack_no_mpjoin" ]; then
+		print_check "MPJoinAckNoMPJoin ${tx}"
+		fail_test "got $count MPJoinAckNoMPJoin expected $ack_no_mpjoin"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinAckNoCtx")
+	if [ -n "$count" ] && [ "$count" != "$ack_no_ctx" ]; then
+		print_check "MPJoinAckNoCtx ${tx}"
+		fail_test "got $count MPJoinAckNoCtx expected $ack_no_ctx"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtDssReset")
+	if [ -n "$count" ] && [ "$count" != "$dss_reset" ]; then
+		print_check "DssReset ${rx}"
+		fail_test "got $count DssReset expected $dss_reset"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPJoinNotEstablished")
+	if [ -n "$count" ] && [ "$count" != "$not_established" ]; then
+		print_check "MPJoinNotEstablished ${rx}"
+		fail_test "got $count MPJoinNotEstablished expected $not_established"
+	fi
 }
 
 chk_infi_nr()
@@ -4477,6 +4527,49 @@ endpoint_tests()
 	fi
 }
 
+rst_emptcp_tests()
+{
+	# Validate per-event MPTCP_RST_EMPTCP counters.  Use a third
+	# namespace (ns3) to trigger paths that aren't reachable in the
+	# standard ns1/ns2 setup: ns1 announces an address belonging to
+	# ns3, the client (ns2) JOINs to ns3 where the SYN/ACK arrives
+	# without an MP_JOIN option (MPTCP disabled there), and the
+	# MPJoinSynAckNoMPJoin counter increments on the client side.
+	local ns3
+
+	if reset "rst per event no mpj"; then
+		if ! setup_ns ns3; then
+			print_check "create ns3"
+			print_skip
+			return
+		fi
+
+		ip link add ns2eth5 netns "$ns2" type veth peer name ns3eth1 netns "$ns3"
+		ip -net "$ns2" addr add 10.0.6.2/24 dev ns2eth5
+		ip -net "$ns2" link set ns2eth5 up
+		ip -net "$ns3" addr add 10.0.6.1/24 dev ns3eth1
+		ip -net "$ns3" link set ns3eth1 up
+		ip -net "$ns3" link set lo up
+		ip netns exec $ns3 sysctl -q net.mptcp.enabled=0
+
+		pm_nl_add_endpoint $ns1 10.0.6.1 flags signal id 5
+		pm_nl_set_limits $ns2 1 1
+
+		local tport=$(get_port)
+		ip netns exec ${ns3} ./mptcp_connect -l -t -1 -s TCP \
+			-p $tport 10.0.6.1 &
+
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
+		wait_attempt_fail "$ns2"
+
+		rst_synack_no_mpjoin=1 \
+			chk_rst_nr 0 0
+
+		cleanup_ns "$ns3"
+	fi
+}
+
 # [$1: error message]
 usage()
 {
@@ -4527,6 +4620,7 @@ all_tests_sorted=(
 	F@fail_tests
 	u@userspace_tests
 	I@endpoint_tests
+	R@rst_emptcp_tests
 )
 
 all_tests_args=""
-- 
2.34.1

