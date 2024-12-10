Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40931ACECB
	for <mptcp@lists.linux.dev>; Tue, 10 Dec 2024 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801527; cv=none; b=OSElqon3I7EG4lUmTD+mxISkUdqm/71Ytb5aiDXi9+Zm27K4Lnm2uTiVYVROCtnjr9qHWRldu8hqH7e/xOMR6P33t+NCgWT7p2f1MoK3E9aUcRlTHZCEIXxDfgbiiQz1lCdTWihV3Ak4OoVaFP5vXNxuZN1pfW79bDkH6Rwm/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801527; c=relaxed/simple;
	bh=+0+LegOoavcu/Ao/6seLEq8YpRAosj+5JYBPDWdjb9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2t5aj4T1zFQA5mAv2JOf4j3MMBBqDzj3h+eR9YaZo4EvZunmd0lYaI+UEIygqe3PwYgwuFBjUM+uzRlXg99bgVO7gPVRLQlOuhJREz/VHDGGq/WVscYtHhcNvnDCGxUU2rttszjElfRHBZLSywE+s/elRsmQvgnkQ8WlV3n+P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFlSLTjT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFlSLTjT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FC1C4CED6;
	Tue, 10 Dec 2024 03:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733801526;
	bh=+0+LegOoavcu/Ao/6seLEq8YpRAosj+5JYBPDWdjb9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FFlSLTjTVHd6AptkOblXDe+qvHidlIc2RkD3nWkRw+Z/oppa5JNd5BJF5AqO3fC+c
	 m6W9EVLvNLzfTv4TtqzoLodIl+qsMwrfKNyrcq0QyAs1cczYdfmoLrl5COgUv2Cdys
	 bbaucSkOOD/REvwWB5K0CQOFUZRYU+xd6MTrnbLskPtRUHqXcVSVoKuGxvoz6/GbAM
	 XwwLjGf+yIETmr2GaOSoCAID4vYvhXBp5NraNBAbdU8Hn6HdAKwJsBe8C9mjKBh/JV
	 707JKdc7+6QA3DIujVvlseKd++Bjcj2flF1bu4gqc8j9kFL2/5MrX0xS9QACsD7BOB
	 jd/T4QdtoAieA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 1/9] bpf: Add bpf_mptcp_send_info_to_ssk
Date: Tue, 10 Dec 2024 11:31:38 +0800
Message-ID: <7e18b01d07f005b4934deeaf5af677d26a783680.1733800334.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733800334.git.tanggeliang@kylinos.cn>
References: <cover.1733800334.git.tanggeliang@kylinos.cn>
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

