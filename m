Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792840734;
	b=XIUftUZ3ZPuCwoRoK6ENvMjmcvFNZcc1uHk6FJbInUSzyJ7a3/W0w43kXCKrjj8gmS05
	 P9OG8PZqdBbkFqwiIfQ+IDcSz6rqgRozal5p7az5scJKjhrcByRMxQR0p/vDyf+i7Gb/d
	 JByoZYnBu3obvc22A7K4UmNElyYbEM65+RVerNnvxFUzhm0XS98xYKNdn9PRQPos3xIez
	 KSxrQSORBS9gC/ImsaI5EdVYQEyvYXr6/4GuKXy20Pfe0cU6pj2EK15NrnNknBuO4PMw4
	 LzlMk/iuGgUctIk+5lbObslf/gfgUNCt67v9nat3IbUf0viLsEisBAsTzNy1WySOtYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792840734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a5n0iRolx9qO6lWkQ1qQ0FT1Aj0ylHE72a9G8Xcc39s=;
	b=HIxKg2sM0cHgRrP7Uii9SO+LJSjuBPcUQLFqTily5c30vW0b/+Gh6C+DZc7q3tDicXT7
	 9APEKDKfS6scTKNkOsGmt4ce3bXebvCcw2QtERqBFHT32VMtGzZXECZNWNI3lU2NatLMk
	 9g6yl1f2vy5EzN42WmQXUuEC7ouie7hmQQaRY5+fATO8brQB9SvysC9KpahBlO9Ukz8mP
	 T6ILy0Iu6hosvCea3LOIoXqDVbtKziOMnKT/cpayEWHxmv0kFQF/gahnM+B/3zUljhiSZ
	 A07hKg0xkJMeIn6u6LwAjyFy+hJl1lbY4kZXY5ksq4mPH7kaI4hAuvPTld1Yf1i+6Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VUIMnH1T;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E118C606A31A
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 11:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E118C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VUIMnH1T
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35ef6b49813so2504446eec.0
        for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 04:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792840733; x=1793445533; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a5n0iRolx9qO6lWkQ1qQ0FT1Aj0ylHE72a9G8Xcc39s=;
        b=VUIMnH1TvuI/yNtzgagsV/YLMLeIizL4DnhAZoVfw2wN5DC/+2qoiDq+yAbYEFGEVU
         wQ0JtPSKql/C+PPIg1QrNUqd7Cc0CcimFLqv3x59nhxbURDvn0x5D/ZpSqTgn2tRkYQH
         Cp9Sj1FhAp/mk/mbZkQC+dLIRSSK/Rn9PdV5wOumYdnZBLrqa1HOnTq2h8kavPkj+sDJ
         T7QWp1Xv7G3cgBysWX19680DrxOOjbNMez4zmzEfPVyuZA6YzdkRcyu6T9ywdxuFyeVv
         DbEVuBmvb5SVHbk6xLjfHgMRsMhDzt8waJGy4y5ccivPWKTefDuGCadbCGRFWRJEm5qB
         CrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792840733; x=1793445533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a5n0iRolx9qO6lWkQ1qQ0FT1Aj0ylHE72a9G8Xcc39s=;
        b=rz32KbVrjAYBX06+qb37Oh9Mtu3LuQ7XFTYt/O2F9pukDaJb3L7+Jp1VN5vtZaNkmV
         4pqWjmRXzF6lhioYuHUhtLsAeYiu2SrGAZivSb0/ttGlcMM9hZb2Rs+/in1VJsnFBGc/
         4XMcWx0DVoYKKPlY5YEVw+SHonVG5SII8zDvRMdzP33E84f/JbRFmBumdQo0qne0UNMN
         w03eOQxfCBHTGv7gyrr4odFJVEYtaYAmokd75jTt4GXOpKNqbOxEnHHnLfZDaStOakYz
         ikWznvsFS5dZXx2cVAiEauRCUhwAHJa37alVTkvadMUU5g/NPob3+7mcTUfFULhZv9m+
         gfvg==
X-Gm-Message-State: AFq9FYI+rRtpnhZKOVBNdNKKXlrkxS7Xb9/f52nnjzkBMA6zIxRD3261
	E5kUdxItpnn6EWu4upX9GD1QuZuq7Tx+dLNcoOh5dn23w25vl5phaCdz/k7bVg==
X-Gm-Gg: AYBFou11twJMyVCrAV5adR3w9EyzVFiyOjs3WP4DHyq8ETrOQiDiH+L/0/iwMVgqaX5
	7dCNQloTBX7X66deGzOhZu0otBDDA8uiFkir3xnRfFPhwwoVtyzeh3cE1goOi/f6uDK+16iG9HK
	g0JpdfMsnlCV7ndAkKyWPfTChgzVzsXJhgkNmhckJd3i7spTrXVRlNnxGHw9Jch3cGedPkBHn2M
	EhJWsE+FP5iV+QN0SkSvK4qPlhtu694kTlPgZke2uDoHFBWFdyt9TjN19krHiUnlKnV9SXIjikf
	E9PZ/gUx9oO47HYp77/6K6FSM0KW9e7Echsg5/GWf4v2gG8QcZc6xFeqh70fUDM+TlapFS6tF7C
	iyk9nU13WVqR2XYAwHg8hs0bFDnFtrJ3A9ikn+AOfivKjokqP2V39HXvrLf8+aj3/81D7wSxW5b
	Gt+0itmcYmYEeAaeKEL8axMlp7BEUupVRoVl9dPyIkJhTYfDk37d3OinhcH2MbSHb90zKkDkfJP
	+lDpNEnXx7D8z24CgJIYNFq6ESz37O+K3SPjDqEZjyFbXPzSi1ljSQ/NvK9
X-Received: by 2002:a05:7300:fb01:b0:351:4a80:d94c with SMTP id 5a478bee46e88-369e862a0d5mr2640530eec.21.1792840732876;
        Sat, 24 Oct 2026 04:18:52 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8afd64fsm7458774eec.0.2026.10.24.04.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 04:18:52 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v8 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Sat, 24 Oct 2026 11:18:42 +0000
Message-ID: <20261024111842.1069878-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024111842.1069878-1-w453y.me@gmail.com>
References: <20261024111842.1069878-1-w453y.me@gmail.com>
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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f4d8afaeda4f..65ba01356112 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4424,6 +4424,139 @@ endpoint_tests()
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
+		# the PM worker accounts the initial subflow endpoint after the
+		# ESTABLISHED event, in the same run where it creates the subflows:
+		# a join on another endpoint shows it is done, then remove it
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 dev ns2eth3 flags subflow
+		wait_mpj 1
+		pm_nl_del_endpoint $ns2 3 10.0.3.2
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		sleep 0.5
+		chk_subflow_nr "after delete" 0
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		wait_mpj 2
+		chk_mptcp_info subflows 1 subflows 1
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_join_nr 2 2 2
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
+		# the PM worker accounts the initial subflow endpoint after the
+		# ESTABLISHED event, in the same run where it creates the subflows:
+		# a join on another endpoint shows it is done, then remove it
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 dev ns2eth3 flags subflow
+		wait_mpj 1
+		pm_nl_del_endpoint $ns2 3 10.0.3.2
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		sleep 0.5
+		chk_subflow_nr "after delete" 0
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow,fullmesh
+		wait_mpj 2
+		chk_mptcp_info subflows 1 subflows 1
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_join_nr 2 2 2
+	fi
+
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-- 
2.43.0

