Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659056;
	b=05YbyqFqjyVs2o2Z62NcqSHSnjErIRahKy5yT+laegN9e4636ibxgVxmz1eqero6WPVL
	 wZeciNY73nNhWBCTWqRSAlvCYZCAkVvHPSu8yin6io0fQMlNXsMhh9w/XwpZPTnC5x2Cp
	 XsIRb6zKB/xYTCXOvf4c9nhD0zqo+iYPMxIM09EwmKYcniSr1YMT5oAX8LMGtoZGK2l5H
	 ZQbidrUFkxZSzT7XLBd4XqdEohUp14QdT7KQmNiYuW1jbkLCd3L6ZJkU8qm+/Tp0UIJcF
	 AJtuQBbU1Uf0BqqmBXbImXdzvXDPAxO6Zj3rVOqpkh7kYWcv8WIQw5uJygZBKN15ElA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gArmKloCONmWsNnso4T8+VfV7ei+OVH+qReeovhn4bA=;
	b=D0FVNIeCMh7Q64dv2AN52fAYvmKp6/T5U/lKECq/kUp9s8anHrbIu+pKBd3TVNG1L+qP
	 57vcnjM/0mDHKbNuPalHdijFyFCjQkF3KEuQkDpT2Mk/yrf7w3uWtn8MxmLXBOWZ5PP+w
	 /JNAg8NbBzZR1AP6OlaysnlKMHGw2xtT+ViOim4dCcpqRa9gtYpVyaA1Fk/f3t6y/OcVO
	 9qIYu0QBiYSLY+BAo/Qv78aYPP+Us9ctnyCMHxuthDKmiv85KBxnK5/GoNDSNNo9xB3MA
	 rtxyx8fWOJXgZNLLgxE4yMXRkQiiDwF3Dzdl/2LtwmdRpNFfthEjNqQijnW6yHGjnVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H5WsEOki;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6DF606A322
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 08:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B6DF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H5WsEOki
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3514b90bb89so4315800eec.1
        for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 01:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792659055; x=1793263855; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gArmKloCONmWsNnso4T8+VfV7ei+OVH+qReeovhn4bA=;
        b=H5WsEOkiDev2aqsN2Or6WPkLOllKjsh6yYbR8+QuQZ+qk8Spcbgb0HWshU0GXrTBtj
         +W+nEgn5ZYmjYhhAUTdFhZg0eFjYEwbezZExXshz3z5HqCJyLiY0A1s3hclMljmHxS0k
         sbZ3XsjSsEnLMwDp1JJuPI0knwB+s5rEb4yBIgXcv+yuKuj5yfGAlxYoPyYd7RPSLD1z
         xh+qaMnU8knFbgRICAxhoQjlwc5fWcB/JrAdlibxK3cVysL2uJ5jyUd+MZTmYMKORyMD
         0VoC/qXvEkTGXM+fcAuNL5rLvdecQD9TnidT8xeDnnO0eazn+xQUCCX1NAazysE0FHfA
         35uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792659056; x=1793263856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gArmKloCONmWsNnso4T8+VfV7ei+OVH+qReeovhn4bA=;
        b=a4er07Hj9hZny9+cf5BVJC4B+oQvOTcdcv7DB6No2pdJzcogLvBYFidcN1x8oSKt37
         5HLR+Gg7vDTwYx5ihCSJhr2//hCfHVkDlVqBUWC7NZngUUJc0+kiUBGf2/Lz7seBVsfe
         k4+Znot9aEsrgkoqtjmCeBMS83QAWCXrpixx2IyCsr24VjRMgX29AsTEFU6oL2QA31NO
         YsTouv06GQrccOg8uqD+PhweCHvw0L5k8ebwtyUbuv4j1/ulaPZFsE9lonm1wcqvCNoz
         lztPIVY2zxhuwW0qxg66TcUI9Qr8TEtYXoV8obOtM0sngMsr5YKMbypjckesUvCX43AN
         Q/lA==
X-Gm-Message-State: AFq9FYKX84iVxkU4NMstKgTa9GTB93m8v8t/vKdUQBZK41T2l/UR4WrA
	2n8JLOybJvbME0acs7YXhRitTkckho2AmRdjhLCeLU3Z1sEFkrEE1d3YmB6xEA==
X-Gm-Gg: AYBFou3xlr/2ZCsdRgDUramwvEJoVb1wggTsVzEFJkI0a//nhi0PnTXRfELpv1b8cCV
	BAnNF+ngpNe31FYvQtC3I73Fsln/Reiza2Pxhy20yY3b0q81LZBTx5g2gLPJLv6M+i9bcxhng6J
	trwwMGukJbRhaBsWOgwcXi4BCo3GEG4LhH6fjGBsEv0QKfRjtxCLTOtjIWpmKHJemmZC87rKptf
	eh5I83CQrgT3vS926fkcPcHJk+mrwekaZ5h0ajPOG4UJG2QrOrEgFGxmd3+YSYz6LztlculW9Fk
	0vS4KbBClqrilAQ4jx8M2PjitajxN2qXtBhr0DSmmLdbRym5YQXXmld1TPMocNMPkSUz4hWfMrT
	ctst25YCMh67QArS2iB48mTdd0S0DrFVKSpyI+NNH/09sxQj+m5zwwYJvRc0SXHWxMxUWv21FSE
	mkNcuCq6M5RhB0e24pdM5UaJyYV5KNky1un+n4qT/x/Tkn0iN1mS+fKZQfLrjvnDU9DlebsKbHP
	bK/d1ZuwiSWWaJm1cPPDxOVn29Fydkrf9Iz5wtZScTYdDxqafyeaY+Qxk8iBrwyulCFYdn+Ehq6
	E+ZyBQ==
X-Received: by 2002:a05:693c:42c9:b0:35c:e696:2d4a with SMTP id 5a478bee46e88-3674d347be8mr1064378eec.24.1792659055419;
        Thu, 22 Oct 2026 01:50:55 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e15353csm25343328eec.2.2026.10.22.01.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:50:55 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v6 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Thu, 22 Oct 2026 08:50:41 +0000
Message-ID: <20261022085041.211318-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022085041.211318-1-w453y.me@gmail.com>
References: <20261022085041.211318-1-w453y.me@gmail.com>
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

The "delete and re-add" test validates the removal and the re-addition
of the endpoint used by the initial subflow, but without the fullmesh
flag.

Do the same with the fullmesh flag: with a second subflow, after a reset
of the initial subflow, and with the initial subflow only, then re-adding
its endpoint or adding another one. Without the previous patch, no new
subflow is created, except when adding another endpoint.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 18ce7136a..52031288b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4445,6 +4445,123 @@ endpoint_tests()
 		chk_rm_nr 4 4
 	fi
 
+	# remove and re-add the endpoint of the initial subflow, with fullmesh
+	if reset_with_events "delete and re-add, fullmesh" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow,fullmesh
+		{ timeout_test=120 test_linkfail=128 speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		wait_mpj 1
+		chk_subflow_nr "before delete id 0" 2
+
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		sleep 0.5
+		chk_subflow_nr "after delete id 0" 1
+
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		wait_mpj 2
+		chk_subflow_nr "after re-add id 0" 2
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_join_nr 2 2 2
+		chk_rm_nr 1 1
+	fi
+
+	# same, but the initial subflow is reset before removing its endpoint
+	if reset_with_events "delete and re-add, fullmesh, after reset" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow,fullmesh
+		{ timeout_test=120 test_linkfail=128 speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		wait_mpj 1
+		chk_subflow_nr "before reset" 2
+
+		if ip netns exec "${ns1}" ${iptables} -A INPUT -s "10.0.1.2" \
+		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset; then
+			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+			ip netns exec "${ns1}" ${iptables} -F INPUT
+			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1 error 1
+
+			pm_nl_del_endpoint $ns2 1 10.0.1.2
+			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+			wait_mpj 2
+			chk_mptcp_info subflows 2 subflows 2
+			chk_join_nr 2 2 2
+		else
+			mark_as_skipped "unable to set the filter rules"
+		fi
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+	fi
+
+	# only the initial subflow: once its endpoint is removed, no live subflow
+	# is left to take the remote address from
+	if reset_with_events "delete and re-add, fullmesh, single subflow" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		{ timeout_test=120 test_linkfail=128 speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		# the ESTABLISHED event comes before the PM worker accounts the
+		# initial subflow endpoint: check the subflow is really gone
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+		chk_subflow_nr "after delete" 0
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		wait_mpj 1
+		chk_mptcp_info subflows 1 subflows 1
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_join_nr 1 1 1
+	fi
+
+	# same, but another endpoint is added after the removal
+	if reset_with_events "delete and add another, fullmesh, single subflow" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		{ timeout_test=120 test_linkfail=128 speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		# the ESTABLISHED event comes before the PM worker accounts the
+		# initial subflow endpoint: check the subflow is really gone
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+		chk_subflow_nr "after delete" 0
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow,fullmesh
+		wait_mpj 1
+		chk_mptcp_info subflows 1 subflows 1
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_join_nr 1 1 1
+	fi
+
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-- 
2.43.0

