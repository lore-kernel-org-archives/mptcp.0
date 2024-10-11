Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB83804
	for <mptcp@lists.linux.dev>; Fri, 11 Oct 2024 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638861; cv=none; b=A2NMFwjxoT1jGz103mvZuhFjX00kBpLH1OnuyP5h2CNYTyIvNrvHJ92aiWyEUuyM4KVPwpgEaCgfyMVtTKwejeo0YisnUOL/XLM4F6742zB8uBh4fkbHprykSGg1lkXYKdiu/W9oybZ44UACAHq0P4WE8Sh5MWEfLUxDUfHky+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638861; c=relaxed/simple;
	bh=GWK8Emu7Xenj6RbjmBgCMLp8+y4zcVDWsQH+sR0uMj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssX2hb0TUbx9oNSbTOjkV8mfP3MLe2DOo9GRjLoxRAmk5Zikg7asJ2p8je0WPID1+VolsbiAKumbFKF5i/RQtzYTxD2orW7G4g49RA0s0GfKtwbzbrEopwGnsW1JQn9CUc/hcElfeevjnaa/RDyuKLM4fExmqfj2OUvpKB9T4vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzmKKxZn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzmKKxZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC239C4CEC3;
	Fri, 11 Oct 2024 09:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728638859;
	bh=GWK8Emu7Xenj6RbjmBgCMLp8+y4zcVDWsQH+sR0uMj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzmKKxZnJ2mYegez/LQdDDlkdzxOlqi624g8uxumoj91mG5DlFACa7n8VrSG2wMp2
	 ceoZXIjK7ad7zcmEYHZLRrLezcrMmH7uODnnvvQXv6cVdD8NO7vGIFrXcLEDWJPPlE
	 FpXzi4Dm2UZThkECeYh50EXq6ZGDH3rk5ODQ2xQGeTULTlFGzDBsygPDQbqZUCP34l
	 kEmHY+FrW0Ls1aLizAvOYrKMb08ObBdIpMatv65Oz0OJ3AalXkx3bWt38s4keNitJS
	 vCqvr4IYSIoFTO4ksauDg8xLcGv1R7XLYpW7sN/ciOwvU5GwiBVecVdNgNoISsgiYM
	 Q71LnmW2rm7WA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 06/11] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Fri, 11 Oct 2024 17:27:18 +0800
Message-ID: <bebb06ead4dfb460b23391533ac93a81b9f76b89.1728638310.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728638310.git.tanggeliang@kylinos.cn>
References: <cover.1728638310.git.tanggeliang@kylinos.cn>
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

