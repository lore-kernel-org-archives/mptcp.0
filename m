Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10CB39F168
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294521; cv=none; b=n6/Krr2lce3vTL6ITeNKOdTXXGjl0sLhZ/pWzJQG7J+tcMjivCSbEEn+MPc+H6SmHXZK7cs6zIhEz/ypeW2udpdpyU6KMlaie0rlqTmzQOBycT/0tMR7P7Rq9Rr95FU2ecrkScE7ez2ijA1TWAbcaKb4oFUFaYCcev3BMmsnCik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294521; c=relaxed/simple;
	bh=IhGxWJ+FTY+0ahv8lZfYgUdZHU0zvCR8CqNF4te/ZYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrfZako4e0rGOhqdR1aZNdPAGjz60eqk3PDUUe+GQkv+BMcPBR8n0C9+WebP9WOzkgb+t7ubNdSzn+gNYpDeslcyn2iRKecoopFEjCVIOBPXVInHMlO7zlL8uvLGZNMqrOj0IUSa9/+806dOfm9oqIgxZOJEcEKX7x72xSTpdpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihktVzRV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihktVzRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47691F000FF;
	Sun, 13 Sep 2026 10:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789294519;
	bh=wX5klhHYwyrBMg+hgAgC1bIWrCwyKCypeqmLKLavp0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ihktVzRVve5LECV3QNLLI2NAzeAP4OKHeEDJk4MH5lSOLkKIAjBkotWtRSGGsJ3fi
	 sUJR+OMYL8O3GDo04Ipl0tIDIeTrg87lNuYqiNRj1xMPM6D814frenuqt/zfxQRbdG
	 /F9hlXaSamYpQABqKeEBX0pM+r3b7pMvtj0FqJfC3ytrwm+NKDgNuDZMqFmP7oFWRv
	 iJcTzEFcw3BJ60Uu3NGFnk6aZbyQzD/76+KH8CHqfA/7WGI106krJcjEzWVD29dLqK
	 a0GsPrQmJTk/c7+OPPvYG9iM58IprpfFeokpXu+DFmeAnCtyB49XzO+dOPjcAqLVFM
	 7H4sr0IftTcjw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 07/16] mptcp: add sock_map_update BPF helper
Date: Sun, 13 Sep 2026 18:14:46 +0800
Message-ID: <393478c81ea50e72c49041752385e9b4fc82d469.1789294365.git.tanggeliang@kylinos.cn>
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

Add a BPF helper bpf_mptcp_sock_map_update() that allows sockops programs
running on MPTCP subflows to insert the parent MPTCP socket into a sockmap
or sockhash. When called from a sockops callback on a subflow, it resolves
the parent MPTCP socket via bpf_mptcp_sock_from_subflow() and validates
that the subflow is the first subflow (msk->first) before inserting the
MPTCP socket into the map via sock_map_update_common().

Export sock_map_update_common() from sock_map.c and register the helper in
the BPF function mapper (id 212) with corresponding verifier compatibility
checks.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/linux/bpf.h      |  7 +++++++
 include/uapi/linux/bpf.h | 10 ++++++++++
 kernel/bpf/verifier.c    |  2 ++
 net/core/filter.c        | 18 ++++++++++++++++++
 net/core/sock_map.c      |  4 ++--
 net/mptcp/bpf.c          | 20 ++++++++++++++++++++
 6 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e57af902560c..ecb53a7ad0e8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4022,6 +4022,13 @@ u32 bpf_xdp_sock_convert_ctx_access(enum bpf_access_type type,
 				    struct bpf_insn *insn_buf,
 				    struct bpf_prog *prog,
 				    u32 *target_size);
+
+int sock_map_update_common(struct bpf_map *map, u32 idx,
+			   struct sock *sk, u64 flags);
+
+#ifdef CONFIG_MPTCP
+u64 mptcp_sock_map_update(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
+#endif
 #else
 static inline bool bpf_tcp_sock_is_valid_access(int off, int size,
 						enum bpf_access_type type,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 732b35cc08d1..41eecb8622ac 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5998,6 +5998,15 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_mptcp_sock_map_update(struct bpf_sock_ops *skops, struct bpf_map *map, void *key, u64 flags)
+ *	Description
+ *		MPTCP-aware variant of **bpf_sock_map_update**\ ().
+ *		When called from a sockops callback on an MPTCP subflow,
+ *		it resolves to the parent MPTCP socket before inserting
+ *		it into the *map*.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6212,6 +6221,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(mptcp_sock_map_update, 212, ##ctx)		\
 	/* This helper list is effectively frozen. If you are trying to	\
 	 * add a new helper, you should add a kfunc instead which has	\
 	 * less stability guarantees. See Documentation/bpf/kfuncs.rst	\
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 72a3f5998dd2..c58c2ba87d26 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9066,6 +9066,7 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_msg_redirect_map &&
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&
+		    func_id != BPF_FUNC_mptcp_sock_map_update &&
 		    !may_update_sockmap(env, func_id))
 			goto error;
 		break;
@@ -9075,6 +9076,7 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_msg_redirect_hash &&
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&
+		    func_id != BPF_FUNC_mptcp_sock_map_update &&
 		    !may_update_sockmap(env, func_id))
 			goto error;
 		break;
diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e753552..0b4fec5a8848 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8830,6 +8830,10 @@ xdp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 const struct bpf_func_proto bpf_sock_map_update_proto __weak;
 const struct bpf_func_proto bpf_sock_hash_update_proto __weak;
 
+#if IS_ENABLED(CONFIG_MPTCP)
+static const struct bpf_func_proto mptcp_sock_map_update_proto;
+#endif
+
 static const struct bpf_func_proto *
 sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -8850,6 +8854,10 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sock_map_update_proto;
 	case BPF_FUNC_sock_hash_update:
 		return &bpf_sock_hash_update_proto;
+#if IS_ENABLED(CONFIG_MPTCP)
+	case BPF_FUNC_mptcp_sock_map_update:
+		return &mptcp_sock_map_update_proto;
+#endif
 	case BPF_FUNC_get_socket_cookie:
 		return &bpf_get_socket_cookie_sock_ops_proto;
 	case BPF_FUNC_perf_event_output:
@@ -11790,6 +11798,16 @@ static const struct bpf_func_proto sk_select_reuseport_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
+static const struct bpf_func_proto mptcp_sock_map_update_proto = {
+	.func		= mptcp_sock_map_update,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_CONST_MAP_PTR,
+	.arg3_type	= ARG_PTR_TO_MAP_KEY,
+	.arg4_type	= ARG_ANYTHING,
+};
+
 BPF_CALL_4(sk_reuseport_load_bytes,
 	   const struct sk_reuseport_kern *, reuse_kern, u32, offset,
 	   void *, to, u32, len)
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index ca49bc7f8687..3e3e85e3bd54 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -467,8 +467,8 @@ static int sock_map_get_next_key(struct bpf_map *map, void *key, void *next)
 	return 0;
 }
 
-static int sock_map_update_common(struct bpf_map *map, u32 idx,
-				  struct sock *sk, u64 flags)
+int sock_map_update_common(struct bpf_map *map, u32 idx,
+			   struct sock *sk, u64 flags)
 {
 	struct bpf_stab *stab = container_of(map, struct bpf_stab, map);
 	struct sk_psock_link *link;
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 662b80ce2cf6..7ecafbf51fa0 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -490,3 +490,23 @@ static int __init mptcp_bpf_v4_build_proto(void)
 	return 0;
 }
 late_initcall(mptcp_bpf_v4_build_proto);
+
+BPF_CALL_4(mptcp_sock_map_update, struct bpf_sock_ops_kern *, sops,
+	   struct bpf_map *, map, void *, key, u64, flags)
+{
+	struct sock *sk = sops->sk;
+	struct mptcp_sock *msk;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	msk = bpf_mptcp_sock_from_subflow(sk);
+	if (msk) {
+		if (sk != READ_ONCE(msk->first))
+			return -EINVAL;
+
+		sk = (struct sock *)msk;
+	}
+
+	return sock_map_update_common(map, *(u32 *)key, sk, flags);
+}
+EXPORT_SYMBOL_GPL(mptcp_sock_map_update);
-- 
2.53.0

