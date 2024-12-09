Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348C215F60
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 09:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737774; cv=none; b=im/Z1mRFGszMY1Uq0FXrUXNX9vjDOzcAwAUIs4PSz/Qdzz2MFMzGEGuVhT0tbHRnucIeAH6U9J1qbK3nVLCpRNYTT5mhrxoaAMkKZl6B/2FekBxctjbSO1Nae9CPtYvSfR9Cui9TqPzlP2DrVuQ9bgodCQ+tAZ4Ppmh2BFONrQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737774; c=relaxed/simple;
	bh=+0+LegOoavcu/Ao/6seLEq8YpRAosj+5JYBPDWdjb9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnaVZftqyXSK2TBmb6nwqjgvYMdiEqrf70KY3GAczJ3p4y92uKPERUwKvBcVVssPGuomgHKPMFg92m5Hi90/fdwwhbAyJzS/Ez7OFYf5bi6fc4T/oq/wMoar8mXq5/uef05uLPVzSnLc009uiJK9fJYR/IArQ98gjrfDXIRnAVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWKOJC/r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWKOJC/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0643BC4CED1;
	Mon,  9 Dec 2024 09:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733737774;
	bh=+0+LegOoavcu/Ao/6seLEq8YpRAosj+5JYBPDWdjb9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IWKOJC/rodNwNGEMFfszSoaF+KOZoFYHafj+mWS5ELze+ZBajpETuun1mBLcWGQ9y
	 YCuggKhnerccxFDDCi3Jr92KYaHuiTkehhCR8g3m/IDrrdqiEKQ7VkhxT8JNzMolGV
	 5OjNY2wo8B+RqYshyIuwRZ+Cze4CNUSzeXet8G5KsMuPoLotQ3gaH9WnRowIHY4cwc
	 Q1kJJMjW/9fjqQ3FXt94zTGpGKs3zODmOp1s8LwLni35AiVIheum9fS2KXWDv5KQI3
	 bEBFF5iaQDAOSQHbwvvMGhMt4pz7xB4K8fswFbH6wHrWfq0P7na1ZIhElDJpOrbduE
	 StN2DuFxImcCA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 1/9] bpf: Add bpf_mptcp_send_info_to_ssk
Date: Mon,  9 Dec 2024 17:49:17 +0800
Message-ID: <593a41dd7a57de0933b55bb42f8faef577c9d75d.1733737459.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733737459.git.tanggeliang@kylinos.cn>
References: <cover.1733737459.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Burst scheduler needs to allocate an array of struct subflow_send_info
on the stack and then select a subflow to send data. In order to implement
burst scheduler in BPF, this patch adds a new bpf_mptcp_send_info_to_ssk()
helper to get ssk from subflow_send_info and sets its parameter type as
ARG_PTR_TO_STACK.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/uapi/linux/bpf.h       |  7 +++++++
 net/mptcp/bpf.c                | 22 ++++++++++++++++++++++
 net/mptcp/protocol.c           |  5 -----
 net/mptcp/protocol.h           |  5 +++++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 5 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4162afc6b5d0..0d7a5846bd77 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5795,6 +5795,12 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * void *bpf_mptcp_send_info_to_ssk(void *info)
+ *	Description
+ *		Dynamically cast a *info* pointer to a *sock* pointer.
+ *	Return
+ *		*info* if casting is valid, or **NULL** otherwise.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6009,6 +6015,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(mptcp_send_info_to_ssk, 212, ##ctx)			\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e9db856972cb..10d3db6323dc 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -21,6 +21,26 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops;
 static const struct btf_type *mptcp_sock_type, *mptcp_subflow_type __read_mostly;
 static u32 mptcp_sock_id, mptcp_subflow_id;
 
+BPF_CALL_1(bpf_mptcp_send_info_to_ssk, struct subflow_send_info *, info)
+{
+	BTF_TYPE_EMIT(struct sock);
+
+	if (info && info->ssk && sk_fullsock(info->ssk) &&
+	    info->ssk->sk_protocol == IPPROTO_TCP &&
+	    sk_is_mptcp(info->ssk))
+		return (unsigned long)info->ssk;
+
+	return (unsigned long)NULL;
+}
+
+static const struct bpf_func_proto bpf_mptcp_send_info_to_ssk_proto = {
+	.func		= bpf_mptcp_send_info_to_ssk,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_BTF_ID_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_STACK,
+	.ret_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
+};
+
 static const struct bpf_func_proto *
 bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
 			       const struct bpf_prog *prog)
@@ -34,6 +54,8 @@ bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
 		return &bpf_skc_to_tcp6_sock_proto;
 	case BPF_FUNC_skc_to_tcp_sock:
 		return &bpf_skc_to_tcp_sock_proto;
+	case BPF_FUNC_mptcp_send_info_to_ssk:
+		return &bpf_mptcp_send_info_to_ssk_proto;
 	default:
 		return bpf_base_func_proto(func_id, prog);
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f768aa4473fb..791c1c0149ee 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1387,11 +1387,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 					 sizeof(struct ipv6hdr) - \
 					 sizeof(struct frag_hdr))
 
-struct subflow_send_info {
-	struct sock *ssk;
-	u64 linger_time;
-};
-
 void mptcp_subflow_set_active(struct mptcp_subflow_context *subflow)
 {
 	if (!subflow->stale)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 19a811220621..78a7cfb84c69 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -598,6 +598,11 @@ mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
 	WRITE_ONCE(subflow->local_id, -1);
 }
 
+struct subflow_send_info {
+	struct sock *ssk;
+	u64 linger_time;
+};
+
 /* Convert reset reasons in MPTCP to enum sk_rst_reason type */
 static inline enum sk_rst_reason
 sk_rst_convert_mptcp_reason(u32 reason)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4162afc6b5d0..0d7a5846bd77 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5795,6 +5795,12 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * void *bpf_mptcp_send_info_to_ssk(void *info)
+ *	Description
+ *		Dynamically cast a *info* pointer to a *sock* pointer.
+ *	Return
+ *		*info* if casting is valid, or **NULL** otherwise.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6009,6 +6015,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(mptcp_send_info_to_ssk, 212, ##ctx)			\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
-- 
2.45.2

