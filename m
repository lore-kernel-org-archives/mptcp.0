Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CED1D0F51
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268660; cv=none; b=IEqvis1wEyeKi/O9JZoEiA/cOdZVrgaXktTH6VWHVNjfcZGjCYvw/X0XP51mSYo81e+bQl/U0mthr/9QRtGIVT0+wMRHhfZszHL/jaGXR6uuYINf+OCvgwe6Xq70AtCacO4P6hb9/Ihqd87Plk+KQT1hUkwW79c2SOWF8IfRHKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268660; c=relaxed/simple;
	bh=dJcPCgbGiTa4yy5psNCb78HvU99dRnZgn8tP3b+U/b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVK9+Y3E+X8KF4cc9ti9Mg2nN5/rwzitXQ44+4wCoFQvogy4K4ohnHLekxsIP0050pW/IRsux3uoAS/SdBHVccvGSaL38VnQiiTubCvKVJSCTH+Mp+L1KCAtJnwuRIKfnJ5MvoVFiwnsFXkvxdjlu6kvlJJ2niHaRNgqsIx3JHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4S1GwW+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4S1GwW+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1C8C4CEE5;
	Wed, 30 Oct 2024 06:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730268660;
	bh=dJcPCgbGiTa4yy5psNCb78HvU99dRnZgn8tP3b+U/b0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4S1GwW+Stb+68YU6Nm7QF+/p0iAPDrLdQR5H2VXYfLxCn+Pih7hx0G+5LcbI6JAv
	 o2FiWvj1M9EtYOHl2tOSYQ1WwgBMbtL+SJOdP3dtSF5OAkxWVeodkMAo+EDGYQWWc5
	 N2aas+DrMNKOcHwDwVs2mjEdxbnmSn2pQD+jBDGP3PtI28cX8iESDuRD3Id7dmfuPN
	 QSBKmjWvNVc5RJxppSnjuHn1Ggh7Y88R5X2n3X0++qjqnsZ7CFZ/8CVvVc4vOtx/4o
	 3ipjnNd8pYH7vEvFapRdM48ABWgmwQW8XqZazTIqbgE8HHMtGGZDHyNUj5wlSKsNRG
	 PXsoS5YMUtLLw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 04/13] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Wed, 30 Oct 2024 14:10:28 +0800
Message-ID: <9bd1f2cf77ff6be354c89f37cefb37bf981ee1e9.1730268415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730268415.git.tanggeliang@kylinos.cn>
References: <cover.1730268415.git.tanggeliang@kylinos.cn>
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

1. validate interface is added in bpf_struct_ops by commit 68b04864ca42
("bpf: Create links for BPF struct_ops maps."), implement it in
mptcp_sched_ops.

2. Drop mptcp_sched_find. This part of mptcp_sched_find() code comes from
bpf_tcp_ca_init_member, but it was recently deleted by commit 68b04864ca42.

3. Add write access for scheduled of mptcp_subflow_context.

4. Drop mptcp_sock_type and mptcp_subflow_type.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e9db856972cb..c6d2efc6cf0e 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -18,8 +18,10 @@
 
 #ifdef CONFIG_BPF_JIT
 static struct bpf_struct_ops bpf_mptcp_sched_ops;
-static const struct btf_type *mptcp_sock_type, *mptcp_subflow_type __read_mostly;
-static u32 mptcp_sock_id, mptcp_subflow_id;
+static u32 mptcp_sock_id,
+	   mptcp_subflow_id;
+
+/* MPTCP BPF packet scheduler */
 
 static const struct bpf_func_proto *
 bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
@@ -43,12 +45,10 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
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
@@ -58,11 +58,14 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 				off);
 			return -EACCES;
 		}
-	} else if (t == mptcp_subflow_type) {
+	} else if (id == mptcp_subflow_id) {
 		switch (off) {
 		case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
 			end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
 			break;
+		case offsetof(struct mptcp_subflow_context, scheduled):
+			end = offsetofend(struct mptcp_subflow_context, scheduled);
+			break;
 		default:
 			bpf_log(log, "no write support to mptcp_subflow_context at off %d\n",
 				off);
@@ -75,7 +78,7 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 
 	if (off + size > end) {
 		bpf_log(log, "access beyond %s at off %u size %u ended at %zu",
-			t == mptcp_sock_type ? "mptcp_sock" : "mptcp_subflow_context",
+			id == mptcp_sock_id ? "mptcp_sock" : "mptcp_subflow_context",
 			off, size, end);
 		return -EACCES;
 	}
@@ -113,7 +116,6 @@ static int bpf_mptcp_sched_init_member(const struct btf_type *t,
 	const struct mptcp_sched_ops *usched;
 	struct mptcp_sched_ops *sched;
 	u32 moff;
-	int ret;
 
 	usched = (const struct mptcp_sched_ops *)udata;
 	sched = (struct mptcp_sched_ops *)kdata;
@@ -124,12 +126,7 @@ static int bpf_mptcp_sched_init_member(const struct btf_type *t,
 		if (bpf_obj_name_cpy(sched->name, usched->name,
 				     sizeof(sched->name)) <= 0)
 			return -EINVAL;
-
-		rcu_read_lock();
-		ret = mptcp_sched_find(usched->name) ? -EEXIST : 1;
-		rcu_read_unlock();
-
-		return ret;
+		return 1;
 	}
 
 	return 0;
@@ -144,18 +141,21 @@ static int bpf_mptcp_sched_init(struct btf *btf)
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
 
+static int bpf_mptcp_sched_validate(void *kdata)
+{
+	return mptcp_validate_scheduler(kdata);
+}
+
 static int __bpf_mptcp_sched_get_subflow(struct mptcp_sock *msk,
 					 struct mptcp_sched_data *data)
 {
@@ -183,6 +183,7 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops = {
 	.check_member	= bpf_mptcp_sched_check_member,
 	.init_member	= bpf_mptcp_sched_init_member,
 	.init		= bpf_mptcp_sched_init,
+	.validate	= bpf_mptcp_sched_validate,
 	.name		= "mptcp_sched_ops",
 	.cfi_stubs	= &__bpf_mptcp_sched_ops,
 };
-- 
2.45.2

