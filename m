Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F522ED84A
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779087709; cv=none; b=hSj0W3JgRpP4FlYrx7ked1LlplWGBE/OjjB97jEBnvw6ShyCHo9hzfEBrR9bQNUmglerBbg8BNZTF22JT8b77RoC6KWSc0Cif6gfOVO2xoH96QWBSq893qBAVUnumvvxECNzASpxxD9XV0kfPQmDYAMc9ymdni89cAMpKbce+XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779087709; c=relaxed/simple;
	bh=LX+iS0XDWy8NS6c2f39Ze+NUQqdhEOxQmiSXB3pORT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdFyaEoSIDdkxGYBdHjzJcPus8PH+l1PGy3wCrfpxCztAVTWvZ4cPfxPacfw5qS6OFXxHJrtm0ZiMjJuLdMm8HddSzpBgiWN0B7PvXtxIjVLtkcFtQGov/N1FjHx2K57Y+hv9TIj9pTd5aos6oxTch1tCfRcLjPPqQxQEnZacbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+NlRt6k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+NlRt6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC97DC2BCB7;
	Mon, 18 May 2026 07:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779087709;
	bh=LX+iS0XDWy8NS6c2f39Ze+NUQqdhEOxQmiSXB3pORT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l+NlRt6kNpBoQHKmS2PaFnpb3QXc5Lojaq2w/EZjeMxalD784Pv111GjI2FzejYRd
	 MJ0l0a22+Qcn5WvVWNEZT/PxuGIfLP+KXkSZmI5j5VOYhYzDWdzG59KY7JSlU8y5kc
	 GQc32LoUQcGQ8Hj4EyLptFEibDpW7BmliEWC1K5znE+VcJjr//7rSFqh0pUHFDEAcY
	 xuClA1VS2W4OV1OzloS1d4TxYK4dmDoSYZ8spUtre94NZdBhc69rDMO3jTEyeBwq+E
	 TuGkL1beWWOtcgWPD1AiLhpfQbwWvnFZhW4UdW/0PHyt5ip/rsIGjzyyvPr8W21Ow7
	 mX3w3OCW3Vplw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v12 04/11] nvmet-tcp: implement target mptcp proto
Date: Mon, 18 May 2026 15:01:23 +0800
Message-ID: <a5f910e7b16300032859c72a7e7a2c9c05d4ce3a.1779087443.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779087443.git.tanggeliang@kylinos.cn>
References: <cover.1779087443.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch introduces a new NVMe target transport type NVMF_TRTYPE_MPTCP
to support MPTCP.

An MPTCP-specific version of struct nvmet_tcp_proto is implemented,
and it is assigned to queue->proto when the transport type is MPTCP
(based on port->sock->sk->sk_protocol).

Dedicated MPTCP helpers are introduced for setting socket options. These
helpers set the values on all existing subflows of an MPTCP connection.
The values are then synchronized to other newly created subflows in
sync_socket_options().

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c |  19 +++++++
 include/net/mptcp.h       |  20 +++++++
 net/mptcp/sockopt.c       | 107 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 858d62e4ceab..a987e0613485 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1923,6 +1923,17 @@ static const struct nvmet_tcp_proto nvmet_tcp_proto = {
 	.set_tos	= ip_sock_set_tos,
 };
 
+#ifdef CONFIG_MPTCP
+static const struct nvmet_tcp_proto nvmet_mptcp_proto = {
+	.protocol	= IPPROTO_MPTCP,
+	.set_reuseaddr	= mptcp_sock_set_reuseaddr,
+	.set_nodelay	= mptcp_sock_set_nodelay,
+	.set_priority	= mptcp_sock_set_priority,
+	.no_linger	= mptcp_sock_no_linger,
+	.set_tos	= mptcp_sock_set_tos,
+};
+#endif
+
 static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		struct socket *newsock)
 {
@@ -1944,6 +1955,10 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	queue->nr_cmds = 0;
 	if (port->sock->sk->sk_protocol == IPPROTO_TCP) {
 		queue->proto = &nvmet_tcp_proto;
+#ifdef CONFIG_MPTCP
+	} else if (port->sock->sk->sk_protocol == IPPROTO_MPTCP) {
+		queue->proto = &nvmet_mptcp_proto;
+#endif
 	} else {
 		ret = -EINVAL;
 		goto out_free_queue;
@@ -2093,6 +2108,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 
 	if (nport->disc_addr.trtype == NVMF_TRTYPE_TCP) {
 		proto = &nvmet_tcp_proto;
+#ifdef CONFIG_MPTCP
+	} else if (nport->disc_addr.trtype == NVMF_TRTYPE_MPTCP) {
+		proto = &nvmet_mptcp_proto;
+#endif
 	} else {
 		ret = -EINVAL;
 		goto err_port;
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4cf59e83c1c5..91ce7b9b639d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -237,6 +237,16 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 }
 
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
+
+void mptcp_sock_set_reuseaddr(struct sock *sk);
+
+void mptcp_sock_set_nodelay(struct sock *sk);
+
+void mptcp_sock_set_priority(struct sock *sk, u32 priority);
+
+void mptcp_sock_no_linger(struct sock *sk);
+
+void mptcp_sock_set_tos(struct sock *sk, int val);
 #else
 
 static inline void mptcp_init(void)
@@ -323,6 +333,16 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
+
+static inline void mptcp_sock_set_reuseaddr(struct sock *sk) { }
+
+static inline void mptcp_sock_set_nodelay(struct sock *sk) { }
+
+static inline void mptcp_sock_set_priority(struct sock *sk, u32 priority) { }
+
+static inline void mptcp_sock_no_linger(struct sock *sk) { }
+
+static inline void mptcp_sock_set_tos(struct sock *sk, int val) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 87b5796d0135..6100aa58a061 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1596,6 +1596,8 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
 	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
+
+	ssk->sk_reuse = sk->sk_reuse;
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
@@ -1662,3 +1664,108 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
 	}
 	return 0;
 }
+
+void mptcp_sock_set_reuseaddr(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	sk->sk_reuse = SK_CAN_REUSE;
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk))
+		goto unlock;
+	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	ssk->sk_reuse = SK_CAN_REUSE;
+	release_sock(ssk);
+unlock:
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_reuseaddr);
+
+void mptcp_sock_set_nodelay(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	msk->nodelay = true;
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (ssk) {
+			lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+			__tcp_sock_set_nodelay(ssk, true);
+			release_sock(ssk);
+		}
+	}
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_nodelay);
+
+void mptcp_sock_set_priority(struct sock *sk, u32 priority)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	sock_set_priority(sk, priority);
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (ssk) {
+			lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+			sock_set_priority(ssk, priority);
+			release_sock(ssk);
+		}
+	}
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_priority);
+
+void mptcp_sock_no_linger(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	WRITE_ONCE(sk->sk_lingertime, 0);
+	sock_set_flag(sk, SOCK_LINGER);
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (ssk) {
+			lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+			WRITE_ONCE(ssk->sk_lingertime, 0);
+			sock_set_flag(ssk, SOCK_LINGER);
+			release_sock(ssk);
+		}
+	}
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_no_linger);
+
+void mptcp_sock_set_tos(struct sock *sk, int val)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	__ip_sock_set_tos(sk, val);
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (ssk) {
+			lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+			__ip_sock_set_tos(ssk, val);
+			release_sock(ssk);
+		}
+	}
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_tos);
-- 
2.53.0

