Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B24C12C491
	for <mptcp@lists.linux.dev>; Wed, 10 Jul 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619180; cv=none; b=KSlq1LFcV9TAam9MsLuWaiofw62l0kpzirkBqGwrH4yZsf0f8nahBM4RuulCsugdWdO17hM24M+rp3quza8ZW/PtvqoGMSTZvKYJTdIzANL9X+k4aIk2fVZGdbg62E6IzgRrTPX4zVa+Ql/oQdFvwq9z7u8lTUBROjMQFV5celw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619180; c=relaxed/simple;
	bh=+wNpVZ//fjsbp+H6wYeowUBjVIXrTK3pBNkIT+DURHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQzub5xXA06tCfFmk/WrCytgez7D0Z5Cc1xq/cB2osevLTnP/odq+8b/DEatRyOyMkCUgZgvQOWA/g40H7q19+HvpghU5z766ljY269tDTbrwGLWU32daVPPTLqnfZWeU0mcXyjndyAptlDQWCrK4xWrKauA9IP3ktYdo77yRRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFEWm/p4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFEWm/p4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43009C32782;
	Wed, 10 Jul 2024 13:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720619180;
	bh=+wNpVZ//fjsbp+H6wYeowUBjVIXrTK3pBNkIT+DURHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nFEWm/p4vRlYFSAJRAXclPwWtT+MIegZsVTD9oVFZfg9MP0QzSoGMTEZ3uIvsHz2C
	 XmBmS41wS0Ho8MXi/UZX7qBUw1IDd7/O03soyRE5YRJekdDC2y8hLYGCEQSzcvhaLc
	 /NNiaeMAPKWbjIbnrk3YRqYLbQlCYiKW33c0jbaIGL21So+YOREMls6gGGyUo7pCfJ
	 5cFJSsxsp8AiyDGttvzzucprq5bgaIk2YwmIhVpiDWn7XT3N186uA11eOnA43sR96m
	 L28lKzTrj4CwzKHCu/zV6vQzEWJraJt0cGAgshyZR4GPxN7gm/zCLOH2DZmOFecVkF
	 2eqhpjEs56xGQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/3] Squash to "selftests/bpf: Add bpf_burst scheduler"
Date: Wed, 10 Jul 2024 21:46:11 +0800
Message-ID: <eadf5ef3c615ebecadcfed6cabf1f5f41157164a.1720618186.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720618186.git.tanggeliang@kylinos.cn>
References: <cover.1720618186.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

Use mptcp_snd_nxt in bpf_burst.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 0026587a94df..a8506cddcefe 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -19,6 +19,7 @@ struct bpf_subflow_send_info {
 extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_set_timeout(struct sock *sk) __ksym;
 extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
+extern __u64 mptcp_snd_nxt(const struct mptcp_sock *msk) __ksym;
 extern bool tcp_stream_memory_free(const struct sock *sk, int wake) __ksym;
 extern bool bpf_mptcp_subflow_queues_empty(struct sock *sk) __ksym;
 extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
@@ -121,7 +122,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	if (!ssk || !sk_stream_memory_free(ssk))
 		return -1;
 
-	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
+	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - mptcp_snd_nxt(msk));
 	wmem = ssk->sk_wmem_queued;
 	if (!burst)
 		goto out;
-- 
2.43.0

