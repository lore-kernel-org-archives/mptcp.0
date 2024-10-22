Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40484127E37
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583564; cv=none; b=hkw8//BowM3aWBUAQXH5Qt9MGQ0cpoxljqkQ9+kpSUEv+5uSZMeiDdxI0otnLiIyWW10Y//FUYezU+KTS5BpR5cZDioCzCwmEZRQBy/IBgmGFYas36gL84Wqg20ysgDbd8kEcDtEFxnaRXf4ZyWvJnBXjLMWOHlahjriZj+VIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583564; c=relaxed/simple;
	bh=Im3omfG89LYGFOkjuGgqpEJyEMP6QwgSILEx9wbbmDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtI0opSoNNk/P92H0VRwtV8a4XEZz7zzmbfLbOugvUy+Q9N6p7o6wGOtCf1XssmGS7GWEPL58ObFOXKSiuU47u6m4RUakekY+AP+C3aB7jyXGxW4I/ZC8WUNR6YzmG3haylTXnHOTAlKDRjjKdndISPz8MeV4wO7qIoeARG1PtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYRSiHV6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYRSiHV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DACC4CEC3;
	Tue, 22 Oct 2024 07:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729583564;
	bh=Im3omfG89LYGFOkjuGgqpEJyEMP6QwgSILEx9wbbmDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MYRSiHV6QC1fn9hwGDfZ0rykVwe1MKPtml7/jtO9BJE7zJs54wutWNU9FCb8CWxKv
	 UDqh7gUllt6LZEg1wLeMoQoYbSpIfjzHymhKsJ3MqueJ34i0M4lASWWgPSZqsBwd5O
	 F+glaS5UZp+svD5m3dOJBPm+Wk3wXn8j421+1H+hXEaqoAfl3IYb7I6d1OG1wMkp0C
	 ypk+pL65CQJPrC3+LKsYIEd1hW6m8gYV3eGS/VMF/ef5ybUdXzpwNDQBvBwyXhtnW1
	 4Rk4eGfouWbZQb6Uo4HRo5zNiDs1NhaEXGcvnJAWqBedHXuMRrvu/eYIIQj96e25EN
	 IaCLhBjTYm6Mg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 5/5] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Tue, 22 Oct 2024 15:52:29 +0800
Message-ID: <47d89319cf58196896a25ae6b3199b27ad73fe97.1729583414.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729583414.git.tanggeliang@kylinos.cn>
References: <cover.1729583414.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added bpf_for_each() helper to walk the conn_list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       |  3 ---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 10 ++++++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 376979a9c4f0..52bc8ac03508 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -60,7 +60,4 @@ extern bool bpf_ipv6_addr_v4mapped(const struct mptcp_addr_info *a) __ksym;
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
-extern struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
-
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index d57399b407a7..f2f9e66455b6 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -20,11 +20,17 @@ SEC("struct_ops")
 int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0), true);
+	struct mptcp_subflow_context *subflow;
+
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		mptcp_subflow_set_scheduled(subflow, true);
+		break;
+	}
+
 	return 0;
 }
 
-SEC(".struct_ops")
+SEC(".struct_ops.link")
 struct mptcp_sched_ops first = {
 	.init		= (void *)mptcp_sched_first_init,
 	.release	= (void *)mptcp_sched_first_release,
-- 
2.45.2

