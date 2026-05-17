Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B630F53C
	for <mptcp@lists.linux.dev>; Sun, 17 May 2026 06:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778997985; cv=none; b=W2u33n/zjf9FnZW2tHods/sr0s/Z1KLnsiiPMkPtuXAD9ng7MneXRnDaSlOr6OrEOiuAucQoGTiUaYMmFJZB1L5dOErSwokH+ZNzxjMWiMN3sDl8bRqN/7n4YOPz4z+SyeX5vokzs+PvyupeAn51oip3P5jFxdB8q7QQnwDPiLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778997985; c=relaxed/simple;
	bh=NANwvxTErmry8dk3Xd3VQYsWQrDkX/ywYJHByWbhowc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYCi5uyDvlf7GsaStX2R2xpDOvD6OH+MP7p26FWKUbTOVkzwWxRENN5pTXpKN7uZOGkh6X++6O8y5iRPuvfCMHOEaoGHmkGXPvU3KS3z//h9SheJg3q9kPDhJylzN/O+dkOSEB2eItgUQIRb4pfDXS5HRntV/CbgNLtt14VQn7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIj7BLmH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIj7BLmH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D5BC2BCB3;
	Sun, 17 May 2026 06:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778997985;
	bh=NANwvxTErmry8dk3Xd3VQYsWQrDkX/ywYJHByWbhowc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sIj7BLmHuZgjSoaCge0fw8eyJspIFfsoC47vjthG4U3YOFoZuqCUwsRKIUBbl0SM7
	 /KWse9W0w/rVWK7TLy8Ui7XUNrvFR8TcwKUhwEjr/imb5RRa1b23ChhqJTuqDPExWv
	 0gkSPwkTMV17Qw5NAG5szxs/ydXDmwkLzlclAEcN9x/Y07k9kWLWcrTBJ7h627K6dD
	 uCPf4iEE+DZfBk+qA8TVG4hsKP49cKvelJgZzRNGogmYTECaSiQhEMAHQ+DU3hEwLS
	 aqKB0XRJlchrHpRUGDYv6eEn1tjlOGQTmtzp2fCcXjeaL9IyN95dck2En4RkBlOweq
	 UQx+Cs79Cj9LA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v11 05/10] nvmet-tcp: implement target mptcp proto
Date: Sun, 17 May 2026 14:05:09 +0800
Message-ID: <d48ff5da132c5a56d1f92ff28ee7d6b43ab2b131.1778997507.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778997507.git.tanggeliang@kylinos.cn>
References: <cover.1778997507.git.tanggeliang@kylinos.cn>
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
and it is assigned to port->proto when the transport type is MPTCP.

Dedicated MPTCP helpers are introduced for setting socket options. These
helpers set the values on the first subflow socket of an MPTCP connection.
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
 drivers/nvme/target/tcp.c |  19 ++++++
 include/net/mptcp.h       |  20 ++++++
 net/mptcp/sockopt.c       | 125 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 3ff5deac6779..eff713ba5338 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -224,6 +224,9 @@ static DEFINE_MUTEX(nvmet_tcp_queue_mutex);
 
 static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
+#ifdef CONFIG_MPTCP
+static const struct nvmet_fabrics_ops nvmet_mptcp_ops;
+#endif
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
 
@@ -2117,6 +2120,18 @@ static const struct nvmet_tcp_proto nvmet_tcp_proto = {
 	.ops		= &nvmet_tcp_ops,
 };
 
+#ifdef CONFIG_MPTCP
+static const struct nvmet_tcp_proto nvmet_mptcp_proto = {
+	.protocol	= IPPROTO_MPTCP,
+	.set_reuseaddr	= mptcp_sock_set_reuseaddr,
+	.set_nodelay	= mptcp_sock_set_nodelay,
+	.set_priority	= mptcp_sock_set_priority,
+	.no_linger	= mptcp_sock_no_linger,
+	.set_tos	= mptcp_sock_set_tos,
+	.ops		= &nvmet_mptcp_ops,
+};
+#endif
+
 static int nvmet_tcp_add_port(struct nvmet_port *nport)
 {
 	struct nvmet_tcp_port *port;
@@ -2143,6 +2158,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 
 	if (nport->disc_addr.trtype == NVMF_TRTYPE_TCP) {
 		port->proto = &nvmet_tcp_proto;
+#ifdef CONFIG_MPTCP
+	} else if (nport->disc_addr.trtype == NVMF_TRTYPE_MPTCP) {
+		port->proto = &nvmet_mptcp_proto;
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
index 87b5796d0135..08c8aafa73b7 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1547,6 +1547,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
 	struct sock *sk = (struct sock *)msk;
 	bool keep_open;
+	u32 priority;
 
 	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
 	if (ssk->sk_prot->keepalive)
@@ -1596,6 +1597,11 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
 	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
+
+	ssk->sk_reuse = sk->sk_reuse;
+	priority = READ_ONCE(sk->sk_priority);
+	if (priority >= 0)
+		sock_set_priority(ssk, priority);
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
@@ -1662,3 +1668,122 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
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
+			/*
+			 * sock_hold is required here because the subflow
+			 * socket could be closed concurrently by another
+			 * thread, and lock_sock(sk) only protects the
+			 * subflow list, not the subflow socket itself.
+			 */
+			sock_hold(ssk);
+			lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+			__tcp_sock_set_nodelay(ssk, true);
+			release_sock(ssk);
+			sock_put(ssk);
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
+			sock_hold(ssk);
+			lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+			sock_set_priority(ssk, priority);
+			release_sock(ssk);
+			sock_put(ssk);
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
+			sock_hold(ssk);
+			lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+			WRITE_ONCE(ssk->sk_lingertime, 0);
+			sock_set_flag(ssk, SOCK_LINGER);
+			release_sock(ssk);
+			sock_put(ssk);
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
+			sock_hold(ssk);
+			lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+			__ip_sock_set_tos(ssk, val);
+			release_sock(ssk);
+			sock_put(ssk);
+		}
+	}
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_tos);
-- 
2.53.0

