Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46F1865E5
	for <mptcp@lists.linux.dev>; Sat, 12 Oct 2024 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740556; cv=none; b=eX379By8oFbVpEm8kUoBr2ALoi+xXyW7mZhdyAv31xdlZPX7VOfL6ALFVf3MSs1UPDw1fZxd7uZuh7EyFN8UrgD3Gbl3nEvKDanBG8IufTV2T3UmeehI2Vume4XqCuAT4WqxH4RXiTvav21qDXQFL7AOoTdrJBPoCJHgJ2WAE+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740556; c=relaxed/simple;
	bh=tLz3h6JC/9VO1Qru+mk3weujBMDZhxQqWeB1BJ6+7LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObgQT8JCNEICQVbzH9+ZLaCQzqduyStpGmtm85DFf7C8ftH/nSrzm8gE5E5UvFenJ8DSQfBWCSvzwHPEMXJ5LvTM19o/hYiHC8WscDtMDBiZNwgifmWKCWtnftEsk1hU8egQeZ5fcot+mYQ114zWFYBktAeosZbdBewjpSXju3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cw3y8nvJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cw3y8nvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BB9C4CEC6;
	Sat, 12 Oct 2024 13:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728740556;
	bh=tLz3h6JC/9VO1Qru+mk3weujBMDZhxQqWeB1BJ6+7LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cw3y8nvJEnOnsLzPFGYXr4zQqWskfy/+1ugiuS9MajXVWS/tuVxZGYC02+TmIaUGk
	 NbhNiIcIdXjP3KE37g7X33Y5lydirLGEsafoDPrzgNUGpsaph+kr210RNvsqnqLmQQ
	 SYmgnjTz2RTaUpa8sxg71R7QsyW6K168nHVW8hbCBTtFItIm1b5YrSxac0j/jweuw/
	 R12zDJjOoyXNxZfAefr2eEwk7YLWCvoUTwlv+mFvST2I5j4PJGgorM6GeTpFDzBt47
	 eGpD2AGQfM6U0ax/S6BBB3CcjXibfojB3Io4CBrdc1XIDijElPCdHBbmiBlDA7IeEa
	 5Os/+6pOPtmvw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 02/11] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Sat, 12 Oct 2024 21:42:07 +0800
Message-ID: <648049ee03650e648cd0426c2430ebe1f191aa0b.1728738220.git.tanggeliang@kylinos.cn>
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

Please update the subject to

	bpf: Add mptcp packet scheduler struct_ops

Drop mptcp_sock_type and mptcp_subflow_type.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 681a76f7c6a8..3be587c7b21e 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -18,9 +18,10 @@
 
 #ifdef CONFIG_BPF_JIT
 static struct bpf_struct_ops bpf_mptcp_sched_ops;
-static const struct btf_type *mptcp_sock_type, *mptcp_subflow_type __read_mostly;
 static u32 mptcp_sock_id, mptcp_subflow_id;
 
+/* MPTCP BPF packet scheduler */
+
 static const struct bpf_func_proto *
 bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
 			       const struct bpf_prog *prog)
@@ -43,12 +44,10 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 					     const struct bpf_reg_state *reg,
 					     int off, int size)
 {
-	const struct btf_type *t;
+	u32 id = reg->btf_id;
 	size_t end;
 
-	t = btf_type_by_id(reg->btf, reg->btf_id);
-
-	if (t == mptcp_sock_type) {
+	if (id == mptcp_sock_id) {
 		switch (off) {
 		case offsetof(struct mptcp_sock, snd_burst):
 			end = offsetofend(struct mptcp_sock, snd_burst);
@@ -58,7 +57,7 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 				off);
 			return -EACCES;
 		}
-	} else if (t == mptcp_subflow_type) {
+	} else if (id == mptcp_subflow_id) {
 		switch (off) {
 		case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
 			end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
@@ -75,7 +74,7 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 
 	if (off + size > end) {
 		bpf_log(log, "access beyond %s at off %u size %u ended at %zu",
-			t == mptcp_sock_type ? "mptcp_sock" : "mptcp_subflow_context",
+			id == mptcp_sock_id ? "mptcp_sock" : "mptcp_subflow_context",
 			off, size, end);
 		return -EACCES;
 	}
@@ -140,14 +139,12 @@ static int bpf_mptcp_sched_init(struct btf *btf)
 	if (type_id < 0)
 		return -EINVAL;
 	mptcp_sock_id = type_id;
-	mptcp_sock_type = btf_type_by_id(btf, mptcp_sock_id);
 
 	type_id = btf_find_by_name_kind(btf, "mptcp_subflow_context",
 					BTF_KIND_STRUCT);
 	if (type_id < 0)
 		return -EINVAL;
 	mptcp_subflow_id = type_id;
-	mptcp_subflow_type = btf_type_by_id(btf, mptcp_subflow_id);
 
 	return 0;
 }
-- 
2.43.0

