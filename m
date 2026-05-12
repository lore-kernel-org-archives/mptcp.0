Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6CC349CFE
	for <mptcp@lists.linux.dev>; Tue, 12 May 2026 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582030; cv=none; b=PiJ1M5rYvhDl8y3j+EUIex9TSzRUPZX7pT8gKNpQ74PWJIvFhenTMFj1eCDXOV/Sg8TSLM0X3mcatlVMao6Dl6OVM8KsdOqT0mOUOJT3bCOBYs5H2D64Y5JvSMiGBY8pFcsi/BOJ5xMtnBk51J0fMEVlQPr5dU2nautfdlL4BIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582030; c=relaxed/simple;
	bh=Tg+zV+iWATUPAY5d17maKwXhtR/3q/I6kpjIZpNi50o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YBCa/ZWntjLno8Q0JsI95qcIp109AzCB/anyyDwBTentOEJuUrlcoTqlwLGz/tu/xRt4NrEjrT7xuWV2kUZjpkV//ZthA49QJClX312OmUw+1PfBztiAYydkFhfwuhfvgh4D8HQxxDRmG0rE5ezxJe9HPy0avgekKl/F7EmtMJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVmnymSH; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVmnymSH"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c795f441ff7so3924391a12.2
        for <mptcp@lists.linux.dev>; Tue, 12 May 2026 03:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778582028; x=1779186828; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ANfKVgPeeuwB5NuLNibYdW4JeMBz2Td+ZxGK8agnaI=;
        b=NVmnymSHxad7CFTai3PCuI1lQrc1GaXh2IOHe5OMQn7vE1qFZldi2Xu3LzEiCqoqBQ
         Q1b7WuhH4zg0L0h8pD1IZlVJK9dHyocw3un4tWnh4rJiHahYqT8Rcsi4UrV1P64NrpqB
         W5sbek97zNUAizdO4Vq0pxm6Vj2d+PpUSKg7eAXGZ9OUijrY5ApnzxHE8tAAUaBNnuhe
         ixl5lxJMDDiRdaufy6KoKhLQ8rdeMp29DPDPNproBtN4UH6c+cu9r4nbsHDolqtE7iIt
         agEgH4K4o5rX29wYGGNgW/LeTsp6iFIcVCPxowa8yKZC9jQTaX58eTAVtjggqf+QgWyx
         Hecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778582028; x=1779186828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ANfKVgPeeuwB5NuLNibYdW4JeMBz2Td+ZxGK8agnaI=;
        b=JpYJKgK9GGhbcXNtshMpIYDk58sfDy+lk6yqCW2OxxggplAPWQ9c033eepdqOHVv+6
         asfLvzytpuHLFw8CJc+5CjjxBG59vClOOutJHxu5ocJ5SAOOCdKbDCOisze/plxh0Hc5
         S8rKG52iaHuX+ia6GvWkcMzTnxfBVVZUI+cwuwwY75KW7TUPt+4ZR8xLWq6Q1t614pJF
         CR5qiv4QtlqOzpDMW8YEtbOB2yONdrAQw139dKFpWr/skLJFtzrTXFC7gmuuCvt6uY4z
         RyTE0s8LeRbL1Xbf/2K6DMTh/eWh0gUzwYf7L9fRiqaR8kbPkNjXfuCvM2SfZ1R5XqZo
         xECA==
X-Gm-Message-State: AOJu0YydNhQnzBYpL0ySMhBmIDo+6Eu648FQqcGEb7SAobivhTsUdqhq
	gs63tpwi8FCZffKyvOrB4RcbgJwfkYF4x4M6EFmr+iVNBeKnxf2TVZBGbGp2hF1U
X-Gm-Gg: Acq92OEg7NcADUVzAuSGFMnKRw9EwbB0mnbJdAefU2J6qObzQVa9hfw5ynGmfKxOWK0
	wWyirVr+sYZr19h0cLYcjgIwdjABWv25qqjcsJ6Wl5VTRSEDQ8W7nh7n/iDwx+3T52qSRQSoFCo
	CCP87ztj1/agNkdL0BhvipwN/gFvqqLASRgD4lml7PJcvo9yJmPEMpcmET/e0mzGQOV2SohSQ+V
	IV3PfR+m+rsKFBbxwN0cqMeexvgEAWNRFmJFJqIgFw9H9DkgZZ3tP3wDhYp5nPl79vw1Fg7+kgg
	gN/KO3HsMHWafI1S3k6iDbH6wSV7Wu/jXWnuV6GbAyeSmsfkN2fpcEErpevzWmNXHN1AsUVkc3n
	EDel20EHkl3ZuecNr5iMnsGf4CvtEAVeT0etvJGYN5uxpZ2vWYzRl9qtC5gqd+vK8w0IIAOjlX2
	xp4mimt9YpTu+QR6ub1Ec+kG4Kqn5iHWP/
X-Received: by 2002:a05:6a20:3d85:b0:398:a1ca:7a22 with SMTP id adf61e73a8af0-3aa5ac62b6dmr33333788637.54.1778582028335;
        Tue, 12 May 2026 03:33:48 -0700 (PDT)
Received: from localhost ([223.185.43.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f03bsm23715483b3a.9.2026.05.12.03.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:33:47 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
X-Google-Original-From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH v3 2/2] selftests: mptcp: extend chk_rst_nr to validate per-event RST counters
Date: Tue, 12 May 2026 16:03:31 +0530
Message-Id: <20260512103331.1934343-3-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512103331.1934343-1-shardul.b@mpiricsoftware.com>
References: <20260512103331.1934343-1-shardul.b@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend chk_rst_nr() with named env-var expectations for each
per-event MPTCP_RST_EMPTCP counter, matching the pattern used by
chk_join_nr().  Each counter defaults to 0 and is checked silently
on success; mismatches print a check line and fail the test.
Counters absent from the running kernel are skipped silently so
older kernels do not false-fail.

Add a test at the end of signal_address_tests that triggers
MPJoinSynAckNoMPJoin: ns1 signals an address that is already bound
on the client (ns2), where a TCP-only mptcp_connect listener is
started.  The client's MP_JOIN routes locally to the TCP listener,
which responds with a plain SYN/ACK without the MP_JOIN option, and
the new counter increments on the client side.

Other per-event counters (MD5SigReset, MPJoinAckNoMPJoin,
MPJoinAckNoCtx, DssReset, MPJoinNotEstablished) are not currently
reachable from mptcp_join.sh; the env-var hooks are in place for
future tests to set expectations explicitly.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
v3:
  - Drop the third-netns approach for triggering
    MPJoinSynAckNoMPJoin.  Use ns1 signalling an address that is
    already bound on ns2 (10.0.2.2) with a TCP-only mptcp_connect
    listener on ns2; the client's MP_JOIN routes locally to that
    listener and the SYN/ACK arrives without MP_JOIN.
  - Move the test into signal_address_tests; drop the standalone
    rst_emptcp_tests group and its sorted-list entry.
  - Drop speed=slow (not needed: only one ADD_ADDR, no in-flight
    actions).
  - The local-and-assign that tripped shellcheck SC2155 is gone
    with the old test.
v2: https://lore.kernel.org/all/20260509183335.969018-1-shardul.b@mpiricsoftware.com/

 .../testing/selftests/net/mptcp/mptcp_join.sh | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5d4d0f127f795..c6ef7f785a558 100755
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
@@ -2378,6 +2428,28 @@ signal_address_tests()
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
+
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns1 10.0.2.2 flags signal
+
+		ip netns exec ${ns2} ./mptcp_connect -l -t -1 -p "$(get_port)" \
+			-s TCP 10.0.2.2 &
+		extra_bind=$!
+
+		run_tests $ns1 $ns2 10.0.1.1
+		rst_synack_no_mpjoin=1 \
+			chk_rst_nr 0 0
+
+		kill ${extra_bind} 2>/dev/null
+	fi
 }
 
 laminar_endp_tests()
-- 
2.34.1

