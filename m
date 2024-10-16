Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF041C07E7
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071255; cv=none; b=fRrcRJYbQjsQEeYtxZ/Axw1887hjuMix3vBfHP9jkYrKb92r5sMgq2t+CFeTLuXd4rQmeSYfe99JeFvm3aXPq03Xcs1BF0jX9nTBNRkTnyv21KID2FFKiIhhFltI69u54FrmLK0oDKhow7/5aPt21jduIKFrZrS28gOT2nsTsrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071255; c=relaxed/simple;
	bh=GWK8Emu7Xenj6RbjmBgCMLp8+y4zcVDWsQH+sR0uMj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfoKJUzTy2FXT9ezU/VZ/yavdjyseMxkGMkGmv6EG+PqJYrpwHee6eJS0HdNCzfcjoBPPr0q7ivNJVAtfdnbqEsKXvFiIr5j6s4d051jx8z0+2NW3G3sqLS5eK04pJ/MjIOqo4tEcGwemysquCPWdtjnN0imGH7bKa6ZPviCJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+5MAHaS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+5MAHaS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEC4C4CEC5;
	Wed, 16 Oct 2024 09:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729071254;
	bh=GWK8Emu7Xenj6RbjmBgCMLp8+y4zcVDWsQH+sR0uMj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+5MAHaSplilkRFF4wwu2IEhrNcSNrw5cHQddEpPiXXDM42IBUgo3xmA6jiMaz2T/
	 WCpYpGbxRr7PaK8lpAxNRplFaRA4jy8SZY98q39G/zA+scXCMt3a70BoHRI9Uic2I6
	 jRqSop1qjXEgjXUVyj6yRLYPyOXtzvZePjZqQYNnbM9FyxWzjG6a4O9B5E6d89SywG
	 m3alQ1akT8DrbPzIOmMXq/fGSxQ7QjRSY7DXZjh2NkinjqQsBmquszi9JGA33iLOHl
	 7bPP50Kr4syfwuHtuCYL8OblB+A4JfWrpbUHse7pYmUsexMe0JxN1eQUzfWq90GGxV
	 9lHN8CLpEm5hA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 06/10] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Wed, 16 Oct 2024 17:33:42 +0800
Message-ID: <dda2905cc41f6473bea5f172f5bd331f0cee4603.1729070999.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729070999.git.tanggeliang@kylinos.cn>
References: <cover.1729070999.git.tanggeliang@kylinos.cn>
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

