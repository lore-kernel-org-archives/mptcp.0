Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DB92207A
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734948380; cv=none; b=VFsbZop126QDLDiD+HIyVkQqvEBWg/HOIq+5JU4TgcVc1O9P3bSYI/LrQhb4vAPbWYZBs6GG5THWzOlUxeNbYnSSZ/i+YqOEn8nreHbQhHworqIQH37zCGVCodNjzw28PuZcRRTFPDOY80hoYIy2wVUSj9mmtXez7nLhwyNHAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734948380; c=relaxed/simple;
	bh=oR0peKmfqca0fvKExvf8faZVSJRPeERCeeaXqBeiE2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCM3nxKXxRqe12vdJCbP9HYhgvKPZ2/p9f0wF22ai2En8Y7299+0URnVQhOOGFGW83yEr4PxKucwXAHB6RaFTzdBeN8icM1ngAhjYjMauQR/ezFBcPP1Lm0Tb6yILNCSJAxHoRmTjxIRdkUicJosopB9zdIPS+k29xxbIimtQL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmO3NjFz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmO3NjFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDEFC4CED3;
	Mon, 23 Dec 2024 10:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734948379;
	bh=oR0peKmfqca0fvKExvf8faZVSJRPeERCeeaXqBeiE2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TmO3NjFzwi6q4R4SWeXcFHmWoO79C1b2SJ8BBCJhTQEmYOxI/Xb/GZFS6I8HvR5nW
	 LvCWhYs8bKdSOtF0JqYjIwlN3ksM3NnIWqnHkU41IFV9UK0CdiyH02kjjx74P0WYpi
	 4dzaTYM6CZL8Noo50VjrKIRbkn0e13uvoW+guddGJdpngLtDHVlmOnMDMPswFNN6HQ
	 8tL3c/nA27jW+O3r03OztpVE1mtXuWHxH83G9MULBBRCkbI8IA+UDriYdtE6c+9e0Z
	 MpxIBS+DOLIu0s1Ae6xpDc9GXfnjgBpYRuSAU2i+JN0mY1uUt45UTzwBuA/XNx7qb4
	 DB3/9RFxZLFbQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 08/10] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Mon, 23 Dec 2024 18:05:50 +0800
Message-ID: <b9a7658cfddcefb24ae877d826fdabeff736c2ea.1734947922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734947922.git.tanggeliang@kylinos.cn>
References: <cover.1734947922.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 34 ++++++++-----------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 405e96c116d5..88abe7a0c391 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -31,41 +31,37 @@ void BPF_PROG(mptcp_sched_rr_release, struct mptcp_sock *msk)
 }
 
 SEC("struct_ops")
-int BPF_PROG(bpf_rr_get_send, struct mptcp_sock *msk,
-	     struct mptcp_sched_data *data)
+int BPF_PROG(bpf_rr_get_send, struct mptcp_sock *msk)
 {
-	struct mptcp_subflow_context *subflow;
+	struct mptcp_subflow_context *subflow, *next;
 	struct mptcp_rr_storage *ptr;
-	struct sock *last_snd = NULL;
-	int nr = 0;
 
 	ptr = bpf_sk_storage_get(&mptcp_rr_map, msk, 0,
 				 BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!ptr)
 		return -1;
 
-	last_snd = ptr->last_snd;
+	next = bpf_mptcp_subflow_ctx(msk->first);
+	if (!next)
+		return -1;
 
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!last_snd || !subflow)
-			break;
+	if (!ptr->last_snd)
+		goto out;
 
-		if (mptcp_subflow_tcp_sock(subflow) == last_snd) {
-			if (i + 1 == MPTCP_SUBFLOWS_MAX ||
-			    !bpf_mptcp_subflow_ctx_by_pos(data, i + 1))
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		if (mptcp_subflow_tcp_sock(subflow) == ptr->last_snd) {
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
+out:
+	mptcp_subflow_set_scheduled(next, true);
+	ptr->last_snd = mptcp_subflow_tcp_sock(next);
 	return 0;
 }
 
-- 
2.45.2

