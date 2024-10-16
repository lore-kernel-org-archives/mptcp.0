Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8906A1C07E7
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071242; cv=none; b=HKPv+KTaSlPPH9bWuyIIyzrEY6tT8NWiTsTwIMMhZxeY0AEFuHBPLgP2BdHe3hQeCny/WQaCU19sPnf6rS3WapjKMJi+8gAGZh8bddkOKdrWuP1tFIUb2kZa1tjy/o9corgO9Qeqrf58bs1+tPRQoXWd2K8m0UH6nnqFbpXCGiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071242; c=relaxed/simple;
	bh=Utn5Dy0UyeKR/dvlbz7Vc2G7oDOPq7AWnlJpMCXlohk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjCOMZwEGvAjAgUO2+Wv1ApQD2DXA1Wr8kFNQeQbEvvwaz/1OeApIn2TdOyMxytiaRy7hXJMTjzKhtxejsi6m8zhsmAG0BpUXtC/DKJkhsfv91cl8ufHVuDww/pfTUmHVjFe4J4IcBqkJ4N4R397F7kYTYwZPm62THgyOJA2Ue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6lcEFJA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6lcEFJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF439C4CEC5;
	Wed, 16 Oct 2024 09:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729071242;
	bh=Utn5Dy0UyeKR/dvlbz7Vc2G7oDOPq7AWnlJpMCXlohk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6lcEFJAeyGqrDrFfLVnEOVlcewqXwsKBJSCo1GRIgSCOY2og7IjdhLkVr7onXoLJ
	 PeDIqss+PLiMoZtXMoLbbEXkoZk1OnAnS9u3Cpwmix3hR2a8JHUOFs22JjHQJLmM/D
	 QLxQdZs2UKjiNmgIYTUT2J5CpynfTviwof5CtYdc2PsdUXDbk6mCk5aG7yjMQTHBqS
	 IcuO3L5GIUd21m0ceL5rgqHeXDqZ6fNjJbomSsHzJq5g+Ts2PasmHzefqc1ckWWQPu
	 7OSOhLWG2CQRb45gFSXrqiG10Si1P2jbWMHv7Ij0qMv92R5PpKOTbYv/abmsm7Q95h
	 c2qiNUlLFGmag==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 02/10] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Wed, 16 Oct 2024 17:33:38 +0800
Message-ID: <eabb0268eb16719b459ccc1d351d743e646583a5.1729070999.git.tanggeliang@kylinos.cn>
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

Please update the subject to

	bpf: Add mptcp packet scheduler struct_ops

Drop mptcp_sock_type and mptcp_subflow_type.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index bca8b5332737..9f264b37ca94 100644
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

