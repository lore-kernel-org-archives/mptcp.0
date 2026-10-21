Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566218;
	b=DucmjjjQutoprHtd2wtyCCT0yx8YlW1y1+LPbAokTpLLdSZZOy7VxP+rYFuh2Yss7IfA
	 gRNm9nWKE2w4c4FcKYw/B1J1GzqnRYtelK4r2/5kitX7x6StpojdhMLlbnpUGgPcqypa0
	 4EE2LrcGuZRxQ4C2NhOwdxYpLKmi6V+IOoSGk4pm+LzqehyZ8zebj/KAP39onARh58LzD
	 gQt21NIDVOEkSYF5A/nEp8FtrEKSxBR+It8kWEAxowLGDba2Coxz73gi6UIEsODaDRs72
	 Pq7Bi0GND51gwPZvnFw3p9Sz3r69ak3f1GxC+fbIWX/JxQqAwR2ZQPzw/tmHtpCQMUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OTuelo28LtKtv9zZAt0jyN4R/II6FPUmb0zaJoxGTxs=;
	b=ylfZUb9BFuoxJWH7mFb8FAGru72Ga6onCgfaAQqbaq2J7bFx7hmUnubEpPqeZ51IA/+G
	 tgwuiPMVIne+z2lqRcsFQ7zZ1wMA8mAKCIIi36qwDtsWI/Ji0Wlt9kiNS+aGAQaZ1Hlij
	 cAeh9hXa3rA1836QAd9udfpg0C+XOjtsD83bFJBOwd8YdQuoW75XWOftQZFPgBndqz6De
	 QiWLVYMt4gM8CxdmSPLJQATm+jgX98mP+ybRFj3SQF5xjbPjvLhE7nOmrd+GJJysmH1qJ
	 SU382gYKM8cs3mXz4NvOu1fn8kZBTZdpXSXa7VjZKmdW0u+rGsP3cYuaDOVNBzFissQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rKcSH33b;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1FE606A31D
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 07:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE1FE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rKcSH33b
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3535a54bed9so507139eec.1
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 00:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792566217; x=1793171017; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OTuelo28LtKtv9zZAt0jyN4R/II6FPUmb0zaJoxGTxs=;
        b=rKcSH33b65GBlXGG07Wfg38dCH5W4Lb+E5y/wgBDGw7t5c7KJDRP98jBBJUcPnIPsK
         J7V3TyCH0jdumKACP/NPQe4XT0OKMeW6QWy2Ate8gR0Fg1YD91tNHFjj/pBWOtxATu6v
         5F9ykdQZ4PeiDmnv/nFAWh2pe3NOUFIdimA+bg4ioLDjhUpkOzEj5EJAOTcVdrK6fERz
         hiVjPGja8RdObr/hr1D8OAiGX0pcD6606Q+ZG8kVEk2IBn91P8qqkJNxXSdxUtf2Lq1Q
         cPyeMxCVeAzEn9GpfhFFNIOcxc0DV7TyKBETvLkWLEvHQJQS9XQVlP1Bqm6Y3aPQLM0A
         hrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792566217; x=1793171017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OTuelo28LtKtv9zZAt0jyN4R/II6FPUmb0zaJoxGTxs=;
        b=IE6uU/pL7SqIFitr0gXtVo3Xhq2sOHb3s4rbKQBbJL1G6HJjVsFJqbOE1usK5iJ7Nz
         s+DIcGuXPkSQEcQbEbzHnx7vb7UVTezhVmQfpJi65VMCfqnTpHvVIWg5dh99TJaHbp01
         ZccX4iemYEYwTipaLH5XEqY9Z6gZrH4JNxvtVrOU+W8vCz4zUsRbX7y5IzB9JPvxPZFd
         K/0wXbB9pzJXxaNUcP19vp2KbYU2sKCnpEUkjc9SqAEeUlz4NzywFvVxvQi7zeE7hNii
         /bUyolP6KoJipPqusCEaEy7CtP240rJPn3OAtR3jWEE5vm6ifWtPzoCePhT8zOPT8FI0
         QwQw==
X-Gm-Message-State: AFq9FYLsYqcWe22Uz/oICSPXSa6pflb8zosG2xU7UeLgpcDwd+pVCb6a
	UCYr5OzW+MwogtJQiaFuoeUoaEicnWDzsgq34aSfpyCq5f3jkiUiZ63DkcUXCA==
X-Gm-Gg: AYBFou3ym3dkWltBbwdRGS9q7/QQP/C/Raa3exb+JzO/+f0omwTyq2sp8pgAQo0/s73
	CaWSEnbp21GgH7ri+CJ1OzCxc+APBHsujtzvKFcd031yaH7Bq33kn8Ksp37830mdb7m7V4F4M8j
	ffgluFdoCdKOe7p2EFT6uVvPjasJiEOTcymF2NSmwuuMXZXI3FgB5i4cr4Yk9Odwvalx4If0VnI
	PwCwfR26zYj8fmNSDiwu/pX8wSXXMwPNGWl9GWMtkTSNONh1mP5ajUdqcW3TXq3noPy7MYkGr93
	91zMcBIhTMQb81MojqnxsVtFbWCJU9u1/tnRIGa8gzj4LZD5MFyJLG6D4TkQZ55RRnQUoMWKHow
	0+O36vuECTzG6/zCckM06oWAi+KYWjfQKFHRSyh2lkEy+hpekDGuSoYrNaoj4WIPjQMWiopsjhM
	Mx5wIHtqcNbZkTZVq1Mzx868JnwUwr17L8sI39BwAAgdBpl31j9eOKQbi9tyFLjXXimJhbQOyi2
	/IQWFra5tEzNwLEFpv5Xk45cBA3L+wlyaQnw6iGDmtoi5t6Ic+trtYo5j/ph8kCw+WzNMYBLSxG
	ygzuOmU=
X-Received: by 2002:a05:7301:8615:b0:359:8492:20ff with SMTP id 5a478bee46e88-3674c43a7a8mr2023878eec.12.1792566216610;
        Wed, 21 Oct 2026 00:03:36 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1d8sm6468910eec.24.2026.10.21.00.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:03:36 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v5 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Wed, 21 Oct 2026 07:03:24 +0000
Message-ID: <20261021070324.50533-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021070324.50533-1-w453y.me@gmail.com>
References: <20261021070324.50533-1-w453y.me@gmail.com>
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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 18ce7136a..6d2cc01ac 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4445,6 +4445,114 @@ endpoint_tests()
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
+			chk_join_nr 2 2 2
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
+		sleep 0.5
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
+		sleep 0.5
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

