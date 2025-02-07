Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E2C2B9B9
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925382; cv=none; b=flrwW4+9mVuQQOJX1Jxc192TA3JJhxUCFt6p7ldA9bI3Gryu8zwaiC3wWMocHZj8TYqqJdFSzSTg7zeaqEzEdRhaQQGQg/wiFbl/r9QNohVKVkzurjZHLQArfb175l3w8G2/MuYu8RkuuCNxijorNMwlPaR2h/zehQRqxSxxriw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925382; c=relaxed/simple;
	bh=TAluxb8dZGbKvspSdFH8CgVcZECfYCHygPJpm7dANwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9pyT1CC6fydFwgE1VBsayOoG0IhRXc9o+Hmn1tyDCvrEQ8G4C7VVCjB1kopXx6//1ShnKQAoPhbvXoCZ+eHJ3M2wpKvQKDPouNVBNvaz27+wFhtBzvoiYkSJETU5Dz1B57nuElFgpYu0XIqLS7FpR2SZj4O0lKdJM5Pr5gNVWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0x5rh3X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0x5rh3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCD9C4CED6;
	Fri,  7 Feb 2025 10:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738925382;
	bh=TAluxb8dZGbKvspSdFH8CgVcZECfYCHygPJpm7dANwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k0x5rh3XoOMr/lJwpk7uDWbHO0UVVMSti9XYJRvJHWdaS4kwkopPnwpwYF+hWlM0D
	 hTsCAUYyjjnCa2R0mUwQkFMDmIkNqOMDXj8+FDZjxnfZUBTcjgGVMHX6TphLdjRPp5
	 /Fv3g+RMfzHNYD2+rY1J6f3b4H6K4PjGkTlt+15fkaSGdo5O+9CqFnxcPEr5olGK0h
	 ii9r9fQSsrwoI7NH42IoVoE/Hp+HIuT3VKvszuUQrTsPONg9EEV3kYqJprOgawyfOP
	 bu2a2rqX9X21t9WLdmkklSkMp/4IA8ajK9z2ACz0OUVk6/hd/36mc8tnOLXUrlqNPK
	 E0RQNPlvLfJIQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 4/5] selftests/bpf: Implement mptcp pm helpers in BPF
Date: Fri,  7 Feb 2025 18:49:27 +0800
Message-ID: <174476b578f6665cc96d03f30ae8b440b84b8b07.1738924875.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738924875.git.tanggeliang@kylinos.cn>
References: <cover.1738924875.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch implements MPTCP path manager helpers mptcp_pm_copy_addr(),
mptcp_pm_copy_entry(), ipv6_addr_equal(), mptcp_addresses_equal() and
mptcp_pm_find_ssk() in BPF.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 5e29ac93d823..816917e59995 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -3,6 +3,7 @@
 #define __MPTCP_BPF_H__
 
 #include "bpf_experimental.h"
+#include "bpf_tracing_net.h"
 
 /* mptcp helpers from include/net/mptcp.h */
 #define MPTCP_SUBFLOWS_MAX 8
@@ -36,6 +37,11 @@ static inline int list_is_head(const struct list_head *list,
 #define mptcp_for_each_subflow(__msk, __subflow)			\
 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
 
+/* errno macros from include/uapi/asm-generic/errno-base.h */
+#define	ESRCH		3	/* No such process */
+#define	ENOMEM		12	/* Out of Memory */
+#define	EINVAL		22	/* Invalid argument */
+
 static __always_inline struct sock *
 mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 {
@@ -62,4 +68,108 @@ extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 extern struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
 
+/* reimplemented BPF helpers */
+static __always_inline void
+mptcp_pm_copy_addr(struct mptcp_addr_info *dst,
+		   struct mptcp_addr_info *src)
+{
+	dst->id = src->id;
+	dst->family = src->family;
+	dst->port = src->port;
+
+	if (src->family == AF_INET) {
+		dst->addr.s_addr = src->addr.s_addr;
+	} else if (src->family == AF_INET6) {
+		dst->addr6.s6_addr32[0] = src->addr6.s6_addr32[0];
+		dst->addr6.s6_addr32[1] = src->addr6.s6_addr32[1];
+		dst->addr6.s6_addr32[2] = src->addr6.s6_addr32[2];
+		dst->addr6.s6_addr32[3] = src->addr6.s6_addr32[3];
+	}
+}
+
+static __always_inline void
+mptcp_pm_copy_entry(struct mptcp_pm_addr_entry *dst,
+		    struct mptcp_pm_addr_entry *src)
+{
+	mptcp_pm_copy_addr(&dst->addr, &src->addr);
+
+	dst->flags = src->flags;
+	dst->ifindex = src->ifindex;
+}
+
+#define inet_sk(ptr) container_of(ptr, struct inet_sock, sk)
+
+#define ipv6_addr_equal(a, b)	((a).s6_addr32[0] == (b).s6_addr32[0] &&	\
+				 (a).s6_addr32[1] == (b).s6_addr32[1] &&	\
+				 (a).s6_addr32[2] == (b).s6_addr32[2] &&	\
+				 (a).s6_addr32[3] == (b).s6_addr32[3])
+
+static __always_inline bool
+mptcp_addresses_equal(const struct mptcp_addr_info *a,
+		      const struct mptcp_addr_info *b, bool use_port)
+{
+	bool addr_equals = false;
+
+	if (a->family == b->family) {
+		if (a->family == AF_INET)
+			addr_equals = a->addr.s_addr == b->addr.s_addr;
+		else
+			addr_equals = ipv6_addr_equal(a->addr6, b->addr6);
+	}
+
+	if (!addr_equals)
+		return false;
+	if (!use_port)
+		return true;
+
+	return a->port == b->port;
+}
+
+static __always_inline struct sock *
+mptcp_pm_find_ssk(struct mptcp_sock *msk,
+		  const struct mptcp_addr_info *local,
+		  const struct mptcp_addr_info *remote)
+{
+	struct mptcp_subflow_context *subflow;
+
+	if (local->family != remote->family)
+		return NULL;
+
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		const struct inet_sock *issk;
+		struct sock *ssk;
+
+		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
+		if (!ssk)
+			continue;
+
+		if (local->family != ssk->sk_family)
+			continue;
+
+		issk = bpf_core_cast(inet_sk(ssk), struct inet_sock);
+
+		switch (ssk->sk_family) {
+		case AF_INET:
+			if (issk->inet_saddr != local->addr.s_addr ||
+			    issk->inet_daddr != remote->addr.s_addr)
+				continue;
+			break;
+		case AF_INET6: {
+			if (!ipv6_addr_equal(local->addr6, issk->pinet6->saddr) ||
+			    !ipv6_addr_equal(remote->addr6, ssk->sk_v6_daddr))
+				continue;
+			break;
+		}
+		default:
+			continue;
+		}
+
+		if (issk->inet_sport == local->port &&
+		    issk->inet_dport == remote->port)
+			return ssk;
+	}
+
+	return NULL;
+}
+
 #endif
-- 
2.43.0

