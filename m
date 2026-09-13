Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDBA232395
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294531; cv=none; b=TR52SwGdqmLvjlvclWWogMCN/gJciJdhUJCaISyGLO8N48vSGwvLV462GDSI4daJZyeyOquAygGtNDpy+EhEHC1BCvpwF8cmH3B3wwcYflyhdb0fc2xtFsfPHnVjPuJ3gapoKcnqY05o0IQK6zZChgnHuAHrfAwf9ST2Foc9cVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294531; c=relaxed/simple;
	bh=W9HGCG3ybaj9jWkMrMSfDjEK5CWytb8aKSuWxwhQGBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y51rQjaOi8uYyUfTrnPUMcWnlT7dAeAT2pJRYWHdngiHoDYNW23XajoihKL7SDzXuSCcSZbOqlNhTrFezlUS/3u/q58kJlOSHDIB0HxSdmysI8h+0sv8SmIy5dFvBdT5m70pzAvTcvZbAGVOduubqaJiHmvTNy+02KawKuQ9eQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJRscfNp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJRscfNp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF11D1F00893;
	Sun, 13 Sep 2026 10:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789294529;
	bh=lY+E/NXB2Mb5QJ8FTBLpZqVD6HSvK2dD7vPaQWVmz7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AJRscfNpVDSAy130lhOoigTeGXRG8XsGRLnLWI9oTtubmABZmGGhaQJHhHWKpLwow
	 wTvdU1vJvuE2iqCCWUyRKDpKNFcEMiBqLE7p7L0RW2RBznNUTzRV8lcnPOAxeZ0MJM
	 LP3dKr7XbedqUbURMuyI5x3c2aFKiI/PwTgVgvKOT+OnoE7bBlwDqnnD4lHDzYXtMK
	 AzZZ7QOqy+U2xOT7r9soPlFwNuJs3kYahmOBXwMM39YDGBXm4ybIkBmQb4c9w7PSpK
	 jwF8fN/608xB2fTgETv9SR0pg9t2nEFl4nnc76teura+Im3SipL6UWDP6H5li9l0ca
	 RtyCx2iMim3kg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 15/16] mptcp: add sk_select_reuseport BPF helper
Date: Sun, 13 Sep 2026 18:14:54 +0800
Message-ID: <fdea25aa5bdb8c4a03b5b84a0a593cea93063e9f.1789294365.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add an MPTCP-aware variant of bpf_sk_select_reuseport() (helper id 213).
When the map contains an MPTCP parent socket, it resolves to the first
subflow (msk->first) before selecting it for reuseport dispatch.

Refactor sk_select_reuseport() to extract the core selection logic into
sk_select_reuseport_lookup(), which is reused by the MPTCP variant.
Register the helper for both sock_ops and sk_reuseport BPF program types
with corresponding verifier compatibility checks.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/linux/bpf.h      |  6 ++++++
 include/uapi/linux/bpf.h |  9 +++++++++
 kernel/bpf/verifier.c    |  6 +++++-
 net/core/filter.c        | 42 +++++++++++++++++++++++++++++++++-------
 net/mptcp/bpf.c          | 22 +++++++++++++++++++++
 5 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ecb53a7ad0e8..00061ef54d57 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4026,8 +4026,14 @@ u32 bpf_xdp_sock_convert_ctx_access(enum bpf_access_type type,
 int sock_map_update_common(struct bpf_map *map, u32 idx,
 			   struct sock *sk, u64 flags);
 
+int sk_select_reuseport_lookup(struct sk_reuseport_kern *reuse_kern,
+			       struct sock *selected_sk,
+			       struct bpf_map *map);
+
 #ifdef CONFIG_MPTCP
 u64 mptcp_sock_map_update(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
+
+u64 mptcp_sk_select_reuseport(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 #endif
 #else
 static inline bool bpf_tcp_sock_is_valid_access(int off, int size,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 41eecb8622ac..b44450a3e7ae 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6007,6 +6007,14 @@ union bpf_attr {
  *		it into the *map*.
  *	Return
  *		0 on success, or a negative error in case of failure.
+ *
+ * long bpf_mptcp_sk_select_reuseport(struct sk_reuseport_md *reuse, struct bpf_map *map, void *key, u64 flags)
+ *	Description
+ *		MPTCP-aware variant of **bpf_sk_select_reuseport**\ ().
+ *		When the *map* contains an MPTCP parent socket, it
+ *		resolves to the first subflow before selecting it.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6222,6 +6230,7 @@ union bpf_attr {
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
 	FN(mptcp_sock_map_update, 212, ##ctx)		\
+	FN(mptcp_sk_select_reuseport, 213, ##ctx)	\
 	/* This helper list is effectively frozen. If you are trying to	\
 	 * add a new helper, you should add a kfunc instead which has	\
 	 * less stability guarantees. See Documentation/bpf/kfuncs.rst	\
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c58c2ba87d26..33a36afd0eaf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9067,6 +9067,7 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&
 		    func_id != BPF_FUNC_mptcp_sock_map_update &&
+		    func_id != BPF_FUNC_mptcp_sk_select_reuseport &&
 		    !may_update_sockmap(env, func_id))
 			goto error;
 		break;
@@ -9077,11 +9078,13 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&
 		    func_id != BPF_FUNC_mptcp_sock_map_update &&
+		    func_id != BPF_FUNC_mptcp_sk_select_reuseport &&
 		    !may_update_sockmap(env, func_id))
 			goto error;
 		break;
 	case BPF_MAP_TYPE_REUSEPORT_SOCKARRAY:
-		if (func_id != BPF_FUNC_sk_select_reuseport)
+		if (func_id != BPF_FUNC_sk_select_reuseport &&
+		    func_id != BPF_FUNC_mptcp_sk_select_reuseport)
 			goto error;
 		break;
 	case BPF_MAP_TYPE_QUEUE:
@@ -9191,6 +9194,7 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 			goto error;
 		break;
 	case BPF_FUNC_sk_select_reuseport:
+	case BPF_FUNC_mptcp_sk_select_reuseport:
 		if (map->map_type != BPF_MAP_TYPE_REUSEPORT_SOCKARRAY &&
 		    map->map_type != BPF_MAP_TYPE_SOCKMAP &&
 		    map->map_type != BPF_MAP_TYPE_SOCKHASH)
diff --git a/net/core/filter.c b/net/core/filter.c
index 0b4fec5a8848..f1415ff42a51 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8832,6 +8832,7 @@ const struct bpf_func_proto bpf_sock_hash_update_proto __weak;
 
 #if IS_ENABLED(CONFIG_MPTCP)
 static const struct bpf_func_proto mptcp_sock_map_update_proto;
+static const struct bpf_func_proto mptcp_sk_select_reuseport_proto;
 #endif
 
 static const struct bpf_func_proto *
@@ -8857,6 +8858,8 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 #if IS_ENABLED(CONFIG_MPTCP)
 	case BPF_FUNC_mptcp_sock_map_update:
 		return &mptcp_sock_map_update_proto;
+	case BPF_FUNC_mptcp_sk_select_reuseport:
+		return &mptcp_sk_select_reuseport_proto;
 #endif
 	case BPF_FUNC_get_socket_cookie:
 		return &bpf_get_socket_cookie_sock_ops_proto;
@@ -11738,15 +11741,14 @@ struct sock *bpf_run_sk_reuseport(struct sock_reuseport *reuse, struct sock *sk,
 		return ERR_PTR(-ECONNREFUSED);
 }
 
-BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
-	   struct bpf_map *, map, void *, key, u32, flags)
+int sk_select_reuseport_lookup(struct sk_reuseport_kern *reuse_kern,
+			       struct sock *selected_sk,
+			       struct bpf_map *map)
 {
 	bool is_sockarray = map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY;
 	struct sock_reuseport *reuse;
-	struct sock *selected_sk;
 	int err;
 
-	selected_sk = map->ops->map_lookup_elem(map, key);
 	if (!selected_sk)
 		return -ENOENT;
 
@@ -11781,10 +11783,20 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
 
 	return 0;
 error:
-	/* Lookup in sock_map can return TCP ESTABLISHED sockets. */
-	if (sk_is_refcounted(selected_sk))
-		sock_put(selected_sk);
+	return err;
+}
+EXPORT_SYMBOL(sk_select_reuseport_lookup);
+
+BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
+	   struct bpf_map *, map, void *, key, u32, flags)
+{
+	struct sock *selected_sk;
+	int err;
 
+	selected_sk = map->ops->map_lookup_elem(map, key);
+	err = sk_select_reuseport_lookup(reuse_kern, selected_sk, map);
+	if (unlikely(err) && selected_sk && sk_is_refcounted(selected_sk))
+		sock_put(selected_sk);
 	return err;
 }
 
@@ -11798,6 +11810,7 @@ static const struct bpf_func_proto sk_select_reuseport_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
+#if IS_ENABLED(CONFIG_MPTCP)
 static const struct bpf_func_proto mptcp_sock_map_update_proto = {
 	.func		= mptcp_sock_map_update,
 	.gpl_only	= false,
@@ -11808,6 +11821,17 @@ static const struct bpf_func_proto mptcp_sock_map_update_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
+static const struct bpf_func_proto mptcp_sk_select_reuseport_proto = {
+	.func           = mptcp_sk_select_reuseport,
+	.gpl_only       = true,
+	.ret_type       = RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type      = ARG_CONST_MAP_PTR,
+	.arg3_type      = ARG_PTR_TO_MAP_KEY,
+	.arg4_type	= ARG_ANYTHING,
+};
+#endif
+
 BPF_CALL_4(sk_reuseport_load_bytes,
 	   const struct sk_reuseport_kern *, reuse_kern, u32, offset,
 	   void *, to, u32, len)
@@ -11851,6 +11875,10 @@ sk_reuseport_func_proto(enum bpf_func_id func_id,
 	switch (func_id) {
 	case BPF_FUNC_sk_select_reuseport:
 		return &sk_select_reuseport_proto;
+#if IS_ENABLED(CONFIG_MPTCP)
+	case BPF_FUNC_mptcp_sk_select_reuseport:
+		return &mptcp_sk_select_reuseport_proto;
+#endif
 	case BPF_FUNC_skb_load_bytes:
 		return &sk_reuseport_load_bytes_proto;
 	case BPF_FUNC_skb_load_bytes_relative:
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index f6fd610f7077..fe10c5ed28f0 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -511,3 +511,25 @@ BPF_CALL_4(mptcp_sock_map_update, struct bpf_sock_ops_kern *, sops,
 	return sock_map_update_common(map, *(u32 *)key, sk, flags);
 }
 EXPORT_SYMBOL_GPL(mptcp_sock_map_update);
+
+BPF_CALL_4(mptcp_sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
+	   struct bpf_map *, map, void *, key, u32, flags)
+{
+	struct sock *sk, *selected_sk;
+
+	sk = map->ops->map_lookup_elem(map, key);
+	if (!sk)
+		return -ENOENT;
+
+	selected_sk = READ_ONCE(mptcp_sk(sk)->first);
+	if (!selected_sk) {
+		if (sk_is_refcounted(sk))
+			sock_put(sk);
+		return -ENOENT;
+	}
+
+	if (sk_is_refcounted(sk))
+		sock_put(sk);
+	return sk_select_reuseport_lookup(reuse_kern, selected_sk, map);
+}
+EXPORT_SYMBOL_GPL(mptcp_sk_select_reuseport);
-- 
2.53.0

