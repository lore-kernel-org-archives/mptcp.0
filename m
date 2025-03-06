Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B282907
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227349; cv=none; b=KADGRKjzJzFOSgFvHAiPHF/mZc/rhfSiZJ9JHY84kIjMEPK1rovBpXeOixCusBchhpazFHBgLTPZ9w5Op1EsISGk7vBzUYwRkMKk0UkHVOfMeyRA3j9pftN/h3jknAz4R7yLuw3WM8i8J/TgRcojZlyzVlcbwGe8BStSrxaetTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227349; c=relaxed/simple;
	bh=IF97BrkMdqIdzqcF0hZf7lBR8CNdxW4nEkpFPFUYqm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lA0aw7VLbtun6PvRV7pQbuY4lkW33AtKSyIZb3HO6DkR+D9n2mSp8aOoavjbJZ+u7b3b7KsnrQQmYoHDht0kwkVZ+A+iDdrdJAMiWKoCAE/Ohd451CZz5QeyGBqq2gHPiYaqRP3TaXLO0n34rdbFMGFhnvc0wnVBvPotv58xd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cu1+HWYC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cu1+HWYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1637AC4CED1;
	Thu,  6 Mar 2025 02:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741227349;
	bh=IF97BrkMdqIdzqcF0hZf7lBR8CNdxW4nEkpFPFUYqm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cu1+HWYCRJAGAYijKc0hq+FXZqGLXW860C4wcXt1X4MowMPveH34UMVucqBZMTZHY
	 SXrqUbBhJY5np1Tzjug2LWLi0O4OAnwbDHUDUMNqLEcBqbATE8fW6Dyrx30npYp9eq
	 E9fpCUPYa/Jw+FNO36UFX8OMBmtYnxCy8wwJ5oApOw//h7/meUAQfIYATmGGLXgtnC
	 NyBYlx903n/42e7ZYuxpgp6M24g9pG9vHn3/6o4SaYx58JFQjikrr0hynncpu0VIDA
	 hQjvv6alom9EScgQAdVjxux9Jkgm0wdgTApf3xs/AFuHIjMgLaLMN3LgaKxftJj4An
	 XKx1Df+XIAMKA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 2/8] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Thu,  6 Mar 2025 10:15:34 +0800
Message-ID: <fabe763eaf0b808c90a537aa246899d5b2441bbb.1741226722.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741226722.git.tanggeliang@kylinos.cn>
References: <cover.1741226722.git.tanggeliang@kylinos.cn>
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

3. Drop mptcp_sock_type and mptcp_subflow_type.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index c0da9ac077e4..2b0cfb57df8c 100644
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
@@ -58,7 +58,7 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 				off);
 			return -EACCES;
 		}
-	} else if (t == mptcp_subflow_type) {
+	} else if (id == mptcp_subflow_id) {
 		switch (off) {
 		case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
 			end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
@@ -75,7 +75,7 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 
 	if (off + size > end) {
 		bpf_log(log, "access beyond %s at off %u size %u ended at %zu",
-			t == mptcp_sock_type ? "mptcp_sock" : "mptcp_subflow_context",
+			id == mptcp_sock_id ? "mptcp_sock" : "mptcp_subflow_context",
 			off, size, end);
 		return -EACCES;
 	}
@@ -113,7 +113,6 @@ static int bpf_mptcp_sched_init_member(const struct btf_type *t,
 	const struct mptcp_sched_ops *usched;
 	struct mptcp_sched_ops *sched;
 	u32 moff;
-	int ret;
 
 	usched = (const struct mptcp_sched_ops *)udata;
 	sched = (struct mptcp_sched_ops *)kdata;
@@ -124,12 +123,7 @@ static int bpf_mptcp_sched_init_member(const struct btf_type *t,
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
@@ -144,18 +138,21 @@ static int bpf_mptcp_sched_init(struct btf *btf)
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
 static int __bpf_mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	return 0;
@@ -188,6 +185,7 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops = {
 	.check_member	= bpf_mptcp_sched_check_member,
 	.init_member	= bpf_mptcp_sched_init_member,
 	.init		= bpf_mptcp_sched_init,
+	.validate	= bpf_mptcp_sched_validate,
 	.name		= "mptcp_sched_ops",
 	.cfi_stubs	= &__bpf_mptcp_sched_ops,
 };
-- 
2.43.0

