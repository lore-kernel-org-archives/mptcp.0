Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A98E1D0F62
	for <mptcp@lists.linux.dev>; Tue, 10 Dec 2024 03:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801536; cv=none; b=p9G7qYOXILevFSWusSrb8Lrqms/gUmZHlqWglZxsqtLesUhGGZhTmxqbCeuHT3AArj1I6ZgnFlvX/oYtqSmLFJFFmDo8bD7NFwa9S8nqbH8E+mvDsP44SLa5ddRdn9pkpnj/dTfm/VS6qsj1UxQhgcTSwhNtKIjb0TbNPuL4kXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801536; c=relaxed/simple;
	bh=c/nN0hAnbFaNg1uFbuo4jdpJfRpzQ9T6ME6dElk9r44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTHk4hYdTPLmVeWPcM5kHIgwsvoomZ+BS6ef3+hv6CPuByY3MeaeD2FTRsbuS7K+HHKoTVE2iPRd/u7+hVojV+wHleUCN2oXs5YcIakrMXS/8VCuN6HnLXs+tKUfwyWbe6Chwsa/fLk0P4r88hgDT+7mCjSJm/8tu8pTRhrj4hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s69GF1WU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s69GF1WU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0B3C4CEDE;
	Tue, 10 Dec 2024 03:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733801535;
	bh=c/nN0hAnbFaNg1uFbuo4jdpJfRpzQ9T6ME6dElk9r44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s69GF1WU25fasAihX/St29JQNPod3eOZQJMZVNyQc1SvCNq4TpSlnTL0l+leo7CaG
	 9UMp+qsGw8zfrGA35N+JG/tqEI8vEZDDc740PkJMNcP1OkFm4hT4IIHsHxSoB5rTjS
	 OjjV1mKfybhqXujBEV2fRSfmKkcdoVLgI3zgyqh7z+b7wIbSOtsi8YykTeRbBl+VKm
	 NXW6HLxbWdwqcZab9e9QgIFtyFz+n6EZSGVoVm6Bm2/+nBgy2jPAPJxnCVlJVvAeps
	 myoby5Ye4YukKscdeHWQzflyYdCiZaRTj+4/BRSFp+ry+/I99zo/O4p+z93Naysw5k
	 6l5b1DUr3nFTw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 6/9] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Tue, 10 Dec 2024 11:31:43 +0800
Message-ID: <c8900fe53cba45c2fde6671a0192e5a4f70c9064.1733800335.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733800334.git.tanggeliang@kylinos.cn>
References: <cover.1733800334.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added bpf_for_each() helper to walk the conn_list.

Drop bpf_mptcp_subflow_ctx_by_pos declaration.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       | 3 ---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 8 +++++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 3b20cfd44505..c393176496f0 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -55,7 +55,4 @@ bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
-extern struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
-
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index d57399b407a7..00cb4953c487 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -20,7 +20,13 @@ SEC("struct_ops")
 int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0), true);
+	struct mptcp_subflow_context *subflow;
+
+	subflow = bpf_mptcp_subflow_ctx(msk->first);
+	if (!subflow)
+		return -1;
+
+	mptcp_subflow_set_scheduled(subflow, true);
 	return 0;
 }
 
-- 
2.45.2

