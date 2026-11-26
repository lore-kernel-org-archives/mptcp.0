Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688311;
	b=bPW7DY2B2XtLuG1eTuasfJPFaR5p43+jjZb+UB4GtkJM+YGO1mCwDhuzWu828ARwhez6
	 XshUZ14fmjWDgQ0VwX3J6ljB7ASTUjJ+RP6Qls5t+8wYuFMpLnO3HcCGWAlCO/MpxtKo0
	 209fbXSTVPBcZNG4vq4sw0/rs5jt9aM3Gtx+EvuDvFHN/QXlSZqO5WmNzW0vf89IdrPxF
	 zoyQ25wLytpXBmJt6Eao4X74YB7JGCGVgt0NzQ7wums8Qs05fTYcvThxcptWFd+dfNfRZ
	 hQVgwvg+1n1k97IhwlbWJc27dtQ1dmEhw6rBPps3RWC0/nD+T4YpMf7WkwLb9BxovbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ugE/krQOnUdasnCh/aZgODTXRFrG9aKhHyU/6uxiQCo=;
	b=eiQApCpssl/Pp3jzE6/pz7bM+PDc6RgL2ctuxD1FfixEWKy+IklvAMRYXhpOMgy9Eo1c
	 V2JSJMYTxE6Fzvs8HuKmLY9elyvjbBrNTukO80DMJNqGF3hgSlaM64CyNdWvPHr87PJ9u
	 DiRqkCJF6GtAqheFf04h3fQtA7OHk2qaCh4Lk6mc8WVnggosqrcjMU7FQ/jSkW/9Lm85W
	 kPG4ETkLF6hihLVRPnnkNJIy71t5p6l0Ay7Lx9T1pcFYROkS2GMkMBmSKAw7SCLXYDdsl
	 W9KfA6gPwy+XWgyW4dxCacFwTpgyEHxhtbCFr3KHC2oVCaaL8OXdQtYK6Ufktc6NQcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="TaQLn/Pd";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D26606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 10:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25D26606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TaQLn/Pd
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3863db981d4so9643511eec.0
        for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 02:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795688310; x=1796293110; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ugE/krQOnUdasnCh/aZgODTXRFrG9aKhHyU/6uxiQCo=;
        b=TaQLn/PdPJw7zDn69+FwlLlkmuSlT2bnj7iKuLtYzb7w0x7JsZr3wYLiJq64EJg1A4
         GA51BPUqYSD3ThZQ2YpYU1NqRKfRigAhkPu7B/hZsByeuRNDdQVJqj4WyXMPcLX3w8dZ
         Q1hxEmvtZZJd6UhOrkEbJMFVqS6VW1TtJZ8W09XOcoA++sCObYomt1PmkevKdCIUSyfo
         fDpyI5Lt7rlyX0NMzsBNskSlO9gvEns9CmazcG3WdAQeCt9O1sV5MtWZwvvCt3eVZyX7
         n9uVTa7ppcB9l0Hg8T4FU/kBrwaABIJfh2B9hz+LFt1bmGCGXdmXN9Khur+zCNKeond3
         wNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795688310; x=1796293110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ugE/krQOnUdasnCh/aZgODTXRFrG9aKhHyU/6uxiQCo=;
        b=vLNFqm0TFCv6AtMlhaH1SfUHsyD5drx+E/9mHDxywKjIR/Jj+otWiccZzczijb3vRD
         jpjNcqyO6weLYBrcS1LwBI0kHfr9b4yScpsuggBELJCceqMGoGqeh1sfU2+s+ZrIK6of
         uqOoL9KnUR4qgpdBRVDVGeQLQurppfeSCx1CqBwhCJ4n5Pl666Kia96t7JdH0TJeuVic
         RQSEh7VwLjbUCGnN9xpDHz0RwpTr3JH6zAEKBzeiAeY/igTIjm1mCWi/Dy26F/dAbHlz
         H9IGPc1yYZQINv1ni3XL2kxOG4We+pG7n9ndt3VAwqjOpQyO2DxFnvoaRTLgcSFr2sQ8
         L65Q==
X-Gm-Message-State: APuU4Z+lyf81uqDW17NasE2aml0gJha3pALjkKwjlIhpjF32ayd7Jg/W
	5abPd1IgesXRx8D9sWimXdGwFGBdqFaf1Hj9qN3ZEGFBNGd45y0ZFX6Zxv5ZUQ==
X-Gm-Gg: AZFdTZf2YXkgoizDDoOJz1s2TQHoB6GVUWU5EOOWIQM3vf5wpXvhXwnvdVDa1B3NUko
	Igea7cTghDGIio7rL4qhNrCXj7Wh+ptSYOOS6p2ots7mSMxr2qeftvZtR88kYu0ads7hjUykSLq
	nLaVYAOjygRIUpWVH9P5yHN4n7LDwh9JeK664/ii52dXD5zEqAQAcwmZMXoL8Y1AyyMOqJWVzWN
	CwuQ9+JC0u9YRMrKmQu2+rZRQX2Zvmld6+rp1KRqjILtaJIBNG1XlesYjXvbIdAkEcCknitnl6g
	toRHv5fs/0UCfTO3WabrVQBhnAIqzjLXof2JpRcmMFndCQU2q/DcoxXERXToN+JB69v5Agem8Dq
	0Oi+WcNy6KR2TUZah7cPbgAL+lAdinhVuQcg9WwCvA+O/Eg1Ein2v+Y2LWQCzExuuTRQ6sbc0J8
	RRP0XBY1aV8jrWoPXI4MlYeqUh/P01dDPEYPvDUeCHU3n7XGHFfloU60CG8TacppHCR+TwrkVTR
	3oNk3Dtt/Btj4vk+M5p1LCDOiT8mNhHHlMhA+YppuSEGcRJsRj38cbFKtyx+n8N//uI6RQZpYg8
	S+FgN4JE1kmDH8GHMFIgKuWcCV/IOZpSWvs=
X-Received: by 2002:a05:7301:6181:10b0:386:b2ac:1f17 with SMTP id 5a478bee46e88-386b2ac2832mr12047770eec.7.1795688310218;
        Thu, 26 Nov 2026 02:18:30 -0800 (PST)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm74221227eec.10.2026.11.26.02.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:18:29 -0800 (PST)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v9 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Thu, 26 Nov 2026 10:18:18 +0000
Message-ID: <20261126101818.3916631-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126101818.3916631-1-w453y.me@gmail.com>
References: <20261126101818.3916631-1-w453y.me@gmail.com>
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

Do the same with the fullmesh flag: with a second subflow, then once no
subflow is left, and after a reset of the initial subflow. Without the
previous patch, no new subflow is created.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f4d8afaeda4f..05572c97ff48 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4424,6 +4424,85 @@ endpoint_tests()
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
+		# no live subflow left to take the remote address from
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		wait_rm_addr $ns1 1
+		pm_nl_del_endpoint $ns2 2 10.0.2.2
+		sleep 0.5
+		chk_subflow_nr "after delete all" 0
+
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		wait_mpj 3
+		chk_subflow_nr "after re-add id 0 alone" 1
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_join_nr 3 3 3
+		chk_rm_nr 3 3
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
+		local filtered=0
+		init_nftables
+		if ip netns exec "${ns1}" nft add rule ip filter INPUT \
+				ip saddr "10.0.1.2" meta l4proto tcp \
+				tcp option mptcp exists reject with tcp reset; then
+			filtered=1
+			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+			ip netns exec "${ns1}" nft flush chain ip filter INPUT
+			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1 error 1
+
+			pm_nl_del_endpoint $ns2 1 10.0.1.2
+			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+			wait_mpj 2
+			chk_mptcp_info subflows 2 subflows 2
+			chk_join_nr 2 2 2
+		fi
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+		# after the cleanup: this exits when all features are expected
+		[ "${filtered}" = 1 ] || mark_as_skipped "unable to set the filter rules"
+	fi
+
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-- 
2.43.0

