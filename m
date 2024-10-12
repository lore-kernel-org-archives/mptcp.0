Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD54A1E511
	for <mptcp@lists.linux.dev>; Sat, 12 Oct 2024 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740562; cv=none; b=cRL3AKCmEpnSqudusGoVC2KvV+ISZqPR1YeDKrgljefgNgmDThLM9ZkLXy5yks5oxdt+gE22jhbviNoIgZqqyFt527Z+T5Li4WuESHRqjVwy/OGeE2k9ww9twd6iBScWjyT99ir6z8SlUoHtux02x2rftcwbdM3qfPUES1m+p3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740562; c=relaxed/simple;
	bh=GWK8Emu7Xenj6RbjmBgCMLp8+y4zcVDWsQH+sR0uMj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CO0yvz+IqBQh+mL23UeoJlO6Tz8Blb8JkMr/ku5bsrUiBhrTsJwazwhW0pWBhxz2I4uuDUSg4BzYb4YcbgOkTnESCO3Bj2Q1HL0rbYebQw59qTm0iYwaJR9nseK+zOWTcaN/TbeTC2XCiFp2CN59f9i3uujqlhIT4Ro5eFDhMhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaUk6lqG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaUk6lqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015A6C4CEC6;
	Sat, 12 Oct 2024 13:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728740562;
	bh=GWK8Emu7Xenj6RbjmBgCMLp8+y4zcVDWsQH+sR0uMj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qaUk6lqGrOO9odqH0BuGF+F1INtbzb6isQvxROnA8+KwrB7mO6cvXZC6vc41Sm/L6
	 rK4B+GzXIlXSVn6Mucz50WrakjiIz7pDBPt5zsfSZMJSZ+jKjw+WrMY2nFR9AzPYp6
	 AdUJVfYEDqiv1AMuljdokLVLomFgEgkJxauC9Z9BYYr/vNeuZGY76h8jTEFnlp+aVG
	 BQyTCPyFVhEGSZyY+xxZ/8MIqRUlt4uEZ18lDL+QwfBPk0C9FgzVd3FyYgTZEt20Fn
	 WKdRhIrkPAXRy0G3BBKSix+/DioF18LoXszo+AtDLBFcB6K0izUq+YXDnOTuth2S1g
	 jW6MVn+Aw/4VQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 07/11] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Sat, 12 Oct 2024 21:42:12 +0800
Message-ID: <5cebb011be66d4ea383b457fb212c7e5ce4eeea0.1728738220.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728738219.git.tanggeliang@kylinos.cn>
References: <cover.1728738219.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 638ea6aa63b7..0e806caa10df 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -34,10 +34,9 @@ SEC("struct_ops")
 int BPF_PROG(bpf_rr_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	struct mptcp_subflow_context *subflow;
+	struct mptcp_subflow_context *subflow, *next;
 	struct mptcp_rr_storage *ptr;
 	struct sock *last_snd = NULL;
-	int nr = 0;
 
 	ptr = bpf_sk_storage_get(&mptcp_rr_map, msk, 0,
 				 BPF_LOCAL_STORAGE_GET_F_CREATE);
@@ -45,27 +44,24 @@ int BPF_PROG(bpf_rr_get_subflow, struct mptcp_sock *msk,
 		return -1;
 
 	last_snd = ptr->last_snd;
+	next = bpf_mptcp_subflow_ctx(msk->first);
 
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!last_snd || !subflow)
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		if (!last_snd)
 			break;
 
-		if (mptcp_subflow_tcp_sock(subflow) == last_snd) {
-			if (i + 1 == MPTCP_SUBFLOWS_MAX ||
-			    !bpf_mptcp_subflow_ctx_by_pos(data, i + 1))
+		if (bpf_mptcp_subflow_tcp_sock(subflow) == last_snd) {
+			subflow = bpf_iter_mptcp_subflow_next(&___it);
+			if (!subflow)
 				break;
 
-			nr = i + 1;
+			next = subflow;
 			break;
 		}
 	}
 
-	subflow = bpf_mptcp_subflow_ctx_by_pos(data, nr);
-	if (!subflow)
-		return -1;
-	mptcp_subflow_set_scheduled(subflow, true);
-	ptr->last_snd = mptcp_subflow_tcp_sock(subflow);
+	mptcp_subflow_set_scheduled(next, true);
+	ptr->last_snd = bpf_mptcp_subflow_tcp_sock(next);
 	return 0;
 }
 
-- 
2.43.0

