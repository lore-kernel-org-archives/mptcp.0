Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B34155C94
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170130; cv=none; b=c6iVjYSxkb9oelgXC1J3qFiduAs2jgCU75rA/RhfscmcP9jyGMAULoGEnYeDVJEXD3gf+55E7MkFoBqqFsCS3NEO1Xevw9nTuRI1RxclAO0AMAUoc1fu+u26Uckf/Fq3YT6S9R3I3H1ZMGjn92YhG9dgdPaOXFXralg3sWac8Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170130; c=relaxed/simple;
	bh=Ai/q76HOqa2HACWLQwQsXfDegewKiziuCZeR/XPXRpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnRaw40j0wGL0RsSjZJdAijasW5HNwuoEchNAHeSKHrLoIokEm89B2tYyXWfPbIrETujFJVUNAGCIbNRMOyfBaFa1rT/aS49+aEdgiUSLdSDGa1fwwzNSP0gOymcnmfzXyXozrhU1jYlSEaUICR50zWBncdSmEy2NsK51Uk+ZvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLxUaUxz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLxUaUxz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E01C4CEC4;
	Tue, 24 Sep 2024 09:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727170130;
	bh=Ai/q76HOqa2HACWLQwQsXfDegewKiziuCZeR/XPXRpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZLxUaUxzAJq+v+lp4Keg2+UV8dlPMOF5UTn66ZIQ6RNOb9AUS6OFhnihL0l3Qr47i
	 KhYki4BbhqANwMDs9lqhtx2d5F3fCfL0EzmwIWG1y273zZtINbCRRswPyTSEigeYcT
	 avjd1OVHKbv/oxmOiouBsXV06Ut0+YEQFNWORnckk9OtGuzRXPagsUmxDfrO3WMo6h
	 APj/GFRE6eMf9+NSpGZrp0AUMznsm0kIn0xa8tb5yiDV0X7XC9wAYZifSnwwr0I2TI
	 5wP0zJiYrzBRrCti5KmHBv+V4r2jVDjFsW7PS9CM/qY/4qbKIQKr+Ght/UU0a17p3B
	 gma7vtXWpqXoQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 5/8] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Tue, 24 Sep 2024 17:28:33 +0800
Message-ID: <b47b7a3efea25e42271928d6e2a93b913c893b96.1727169534.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727169534.git.tanggeliang@kylinos.cn>
References: <cover.1727169534.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/bpf/progs/mptcp_bpf_rr.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 638ea6aa63b7..c0b30733d987 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -37,7 +37,7 @@ int BPF_PROG(bpf_rr_get_subflow, struct mptcp_sock *msk,
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_rr_storage *ptr;
 	struct sock *last_snd = NULL;
-	int nr = 0;
+	int id = 1;
 
 	ptr = bpf_sk_storage_get(&mptcp_rr_map, msk, 0,
 				 BPF_LOCAL_STORAGE_GET_F_CREATE);
@@ -46,22 +46,24 @@ int BPF_PROG(bpf_rr_get_subflow, struct mptcp_sock *msk,
 
 	last_snd = ptr->last_snd;
 
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!last_snd || !subflow)
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		if (!last_snd)
 			break;
 
 		if (mptcp_subflow_tcp_sock(subflow) == last_snd) {
-			if (i + 1 == MPTCP_SUBFLOWS_MAX ||
-			    !bpf_mptcp_subflow_ctx_by_pos(data, i + 1))
+			struct mptcp_subflow_context *next;
+
+			next = bpf_core_cast(list_next_entry(subflow, node),
+					     struct mptcp_subflow_context);
+			if (list_entry_is_head(next, &msk->conn_list, node))
 				break;
 
-			nr = i + 1;
+			id = next->subflow_id;
 			break;
 		}
 	}
 
-	subflow = bpf_mptcp_subflow_ctx_by_pos(data, nr);
+	subflow = bpf_mptcp_lookup_subflow_by_id(msk, id);
 	if (!subflow)
 		return -1;
 	mptcp_subflow_set_scheduled(subflow, true);
-- 
2.43.0

