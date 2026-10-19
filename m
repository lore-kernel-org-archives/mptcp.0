Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436125;
	b=Vk0UpIfL6f63h6f9CEbciTYm2JGC1AAzeDpuh7CCQC/QMCDKHiv13Ffb7OKp6q8dZd+y
	 1qVFtuJE16qCFm6bIgthGj6U4yim+F93fdzanpcR4aX7UxdN96KCjerkSrxWuiwDpeIQz
	 jBYMyEqlPR78LtK0pMD2gjk8H1ENdZ8JoABdchOT2hDjZAX5qjls/1bu2so9wvdClr3bi
	 KuxJXEp47gOjGBARA5aFQ35xv8adC+y92bEzWEn6ZqE2XOqEjHVv7tYkomgJ1wvLtWUXy
	 a1Vb7XXBgBFGn/PDqF/2TbLylGLJXQgw13b87Z4vcQPyULF/vj7FwHA1kOs/OaC5ddw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3LcyZcPyLsm5vLv8GmntQeIR91Jnxb10et9/VffjMj8=;
	b=FVB0ikALN/L97c2tM9FSB098KXwJW4I1m/p0YpN7ReChesZ8iklXdlxlWg0UVVzXhEZT
	 ZIfJTWf5TlYLyzEi1+cZPrIm8X5SboLDx3hqGW22cGxFDZceCNNZNo/YgB2542ETDqEby
	 iqFLM92t0RbCLZcZ9c4ow0XjF66kRXifciKe5zp7ugoOlC3uaLbBu1ON9To9/5muV9eJi
	 +9waVSNtm3n4gBOpXPXdwUKDjY4s4ddKFKgAZjdx1TU3R/LA5DqnR5Q2TrcsaKn4w5b/j
	 z9UhCA+eZwjzAownL0mxsOngfbdiTr8NcJJwPxelb+EeFdnyCW9abdv77czzfq9Njvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e8MBfLtf;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AD0606A322
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 18:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27AD0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e8MBfLtf
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35943f55c06so3648335eec.0
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792436123; x=1793040923; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3LcyZcPyLsm5vLv8GmntQeIR91Jnxb10et9/VffjMj8=;
        b=e8MBfLtfrHMGFg+Bh6j2DZbyXuqJbkoR9AqJgfzkwZnq0TWAABIEV4mcz6DOZfd49x
         IVnasZNYebOMx0PARq4/6e4tNER5RPdalaMg8XZA2WfKtQiUa3ZkLyt7CEfShHAftSE+
         rxf5zk54ESuixY+NshzlnuKSTM31xU15v8T0vJOnvShS9LC32pUORh5aiNEtoXfhxVLM
         QZPYywmMtH/YpvfzsZtdd+hQ/DSaSoR+rYW43oYvRTdpgYig8pFgrf0J9eU9gOwwtDd9
         PE1JPZCC57KudTGDL0U+41eCT5/2ytCWMpQdtzv+6h5otzjQitiKRn8Bs6Og7Q4tRAAC
         40Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436123; x=1793040923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3LcyZcPyLsm5vLv8GmntQeIR91Jnxb10et9/VffjMj8=;
        b=0dPBDcXB0JFkKOxoRGv3SjwYZxdMCC6hD1DOia+jQjoZMwnmL+SpaT+zTDxy7wBQvv
         J/A4CmEytvGxYHSL4zQ17hSRIqWub91Vinyrxm9jzSI+NWbhVKPyVubY3h9ZDMeWkx3K
         OVg/7v34c7hMOyuHQ7YYgkPejkeLYAHns3+NNYkRIxaPq5dqhiyGjDKdEJHjgUz5HKdh
         T06TyMPMg9hvxRjjE99AAOLxCsrhoMg+izj/YNh7Lc3ppcBa/Vf8z1eNYe+to8fyDbQj
         4QPcDKXQosV8gxewCVknvsi/vo4BLm5Uk9fRwx5t8l7Sq6dIpuOUQAREylmtLdvR7Zk5
         SeUg==
X-Gm-Message-State: AFq9FYJouSl4vOPAiVows3Uz/3nHzMnSqxcqnWBGor/Jp/d+B3Iz+n/G
	VjKw0/YGE757q25P682LToHHtlju2WLOW/x8m8p3DmRDw/gs6FYtKw4mF8V7qA==
X-Gm-Gg: AYBFou0TsEEo1ScbT6dyR7FkEtJzub0xjWqUlkwTEjY2knuoeCjxG9tX5gwRbekumpS
	1jgSi9YRHVD73i1Q92Flc3RZlnedCv79Juk7752yqgNjenOEvAIcPKf9L+F6xFsK+1KC+WBcCwq
	MR+vnj7xLk2adD7WS3yb78YdE7EuCaTrbo20PBFnK7VET4HXDlXTo8CzWbB6dG1BRU7SuMFi/9o
	9LHApICpQA9MEp5f5DXifsB0y3TbYpjwoK/Mw6UskvUMJX9PGrn050GNU24Al1Ghfjo9YVVXQQn
	O+orhUU+nT0rIHfhVQbvDOm4y7/HeJW0p3zJgGMSrwvpd7uKR3mWYbQQus/nnKjBjv+UROdw1XJ
	4/hrZd/eQ+B9g5Dwgt4K2w0Szf5IB4xFG9BWhwFrA49A5DIXa9nVIHcPxAmh7ri/Aw5tjCySkpq
	YeA7XAubhx7IIRfv5Sw3jqoHHcrXvwFtknSymQ+9UrYf68mq3Xv4z28HQMcFsxf+e5Us67EzTOR
	PBWwbphB0GLfZZJb79hu/3LY5JNmarSuj803A/Bd966vtmVBXN+16hflDrM6FkTdRR+UMy6d6Jl
	7UGd0CfXXv4=
X-Received: by 2002:a05:7300:e7a4:b0:353:5d7a:cabe with SMTP id 5a478bee46e88-365fad8dd2dmr5511eec.13.1792436123052;
        Mon, 19 Oct 2026 11:55:23 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6e33sm35749512eec.7.2026.10.19.11.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:55:22 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v3 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Mon, 19 Oct 2026 18:55:12 +0000
Message-ID: <20261019185512.458313-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019185512.458313-1-w453y.me@gmail.com>
References: <20261019185512.458313-1-w453y.me@gmail.com>
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

Do the same with the fullmesh flag, and also after a reset of the
initial subflow, before the removal of its endpoint. Without the
previous patch, no new subflow is created after the re-addition.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 18ce7136a..d2d105cef 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4445,6 +4445,68 @@ endpoint_tests()
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
+
+			pm_nl_del_endpoint $ns2 1 10.0.1.2
+			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+			wait_mpj 2
+			chk_mptcp_info subflows 2 subflows 2
+		fi
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

