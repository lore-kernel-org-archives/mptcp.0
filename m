Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D653B6BE8
	for <mptcp@lists.linux.dev>; Tue, 31 Mar 2026 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952922; cv=none; b=RJQG4Dwpmgt0y5TyoaBz7r3dVvgUWnAqeOnnlEp/SEJX3+kiPuEBr/FbguAgjvL+t0BpQ+goE9habrECR+2+2eGa4ya9VtlwKHCbcsB5rSSXQEZRKyE4D4tngNyGeDQSCYXnkoeeJwHiHo8ixn2MqEQs3yoviHW2XpFf/jFpX8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952922; c=relaxed/simple;
	bh=f1zqQP08G+WWiowLS75zCHHyO39CYJD/+34Vw/MQOXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPOCYq/KstUxXrDNiGLZZfJwjn4G3MxXYfr/edKW9eTFnWuKfINgq+R0Q0AZQsT8xnjbPimayoEw6UY5O8w1EhYH9vhYNdYkYPAvTv7y3Ia5sNvV60KkRZ/3q1ChC89818e23eptc4REH00p/SAEPlQhYLqQ9M+CbDzwlIBQ8/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeCJW3KF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeCJW3KF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72244C19423;
	Tue, 31 Mar 2026 10:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774952922;
	bh=f1zqQP08G+WWiowLS75zCHHyO39CYJD/+34Vw/MQOXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LeCJW3KFl/vRNtRnY9Abm2LzXCePFa9pPKy2FeUbmJ+TsElkDWPngHwdqIo3zn5Yj
	 V5CVx7j0tz6aqfWF9imTswTTA/vkBLBZZ+C4TAj+MHdl3VjpfejFDs3eBI6I2ZNnF9
	 EW6IOGoP3xqRhLBSmTcJivhVsQy0gFByK7aniC0tL358lMXCclh5i2CS5BkLbAkikh
	 lSThMGkiQ2Jcq010OqZhMFxhlp+u2/S4g8Nn5Sgfda0c0z+BaGJpLIZyay6s60/Wkv
	 l1Z1icd0O1CR99jPhwkEi9TWO1cpWFqIW42Wpd3/pxW8ExM/5UiiKd9TQqYrD4Yxd+
	 PDvkONDPIse9Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v7 2/7] nvmet-tcp: implement target mptcp sockops
Date: Tue, 31 Mar 2026 18:28:26 +0800
Message-ID: <08d0655c8758754aef67b9c9fa211664c2f6e73e.1774952107.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1774952107.git.tanggeliang@kylinos.cn>
References: <cover.1774952107.git.tanggeliang@kylinos.cn>
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

An MPTCP-specific version of struct nvmet_tcp_sockops is implemented,
and it is assigned to port->sockops when the transport type is MPTCP.

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
 drivers/nvme/target/tcp.c | 15 ++++++
 include/linux/nvme.h      |  1 +
 include/net/mptcp.h       | 20 ++++++++
 net/mptcp/sockopt.c       | 98 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 134 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc1207d96b30..8471b14a7ee8 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2052,6 +2052,17 @@ static const struct nvmet_tcp_sockops nvmet_tcp_sockops = {
 	.set_tos	= ip_sock_set_tos,
 };
 
+#ifdef CONFIG_MPTCP
+static const struct nvmet_tcp_sockops nvmet_mptcp_sockops = {
+	.proto		= IPPROTO_MPTCP,
+	.set_reuseaddr	= mptcp_sock_set_reuseaddr,
+	.set_nodelay	= mptcp_sock_set_nodelay,
+	.set_priority	= mptcp_sock_set_priority,
+	.no_linger	= mptcp_sock_no_linger,
+	.set_tos	= mptcp_sock_set_tos,
+};
+#endif
+
 static int nvmet_tcp_add_port(struct nvmet_port *nport)
 {
 	struct nvmet_tcp_port *port;
@@ -2078,6 +2089,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 
 	if (nport->disc_addr.trtype == NVMF_TRTYPE_TCP) {
 		port->sockops = &nvmet_tcp_sockops;
+#ifdef CONFIG_MPTCP
+	} else if (nport->disc_addr.trtype == NVMF_TRTYPE_MPTCP) {
+		port->sockops = &nvmet_mptcp_sockops;
+#endif
 	} else {
 		ret = -EINVAL;
 		goto err_port;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 655d194f8e72..8069667ad47e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -68,6 +68,7 @@ enum {
 	NVMF_TRTYPE_RDMA	= 1,	/* RDMA */
 	NVMF_TRTYPE_FC		= 2,	/* Fibre Channel */
 	NVMF_TRTYPE_TCP		= 3,	/* TCP/IP */
+	NVMF_TRTYPE_MPTCP	= 4,	/* Multipath TCP */
 	NVMF_TRTYPE_LOOP	= 254,	/* Reserved for host usage */
 	NVMF_TRTYPE_MAX,
 };
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
index de90a2897d2d..2ea2e46977b9 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1537,6 +1537,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
 	struct sock *sk = (struct sock *)msk;
 	bool keep_open;
+	u32 priority;
 
 	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
 	if (ssk->sk_prot->keepalive)
@@ -1586,6 +1587,11 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
 	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
+
+	ssk->sk_reuse = sk->sk_reuse;
+	priority = READ_ONCE(sk->sk_priority);
+	if (priority > 0)
+		sock_set_priority(ssk, priority);
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
@@ -1652,3 +1658,95 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
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
+	sock_set_reuseaddr(ssk);
+unlock:
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_reuseaddr);
+
+void mptcp_sock_set_nodelay(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	msk->nodelay = true;
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk))
+		goto unlock;
+	lock_sock(ssk);
+	__tcp_sock_set_nodelay(ssk, true);
+	release_sock(ssk);
+unlock:
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_nodelay);
+
+void mptcp_sock_set_priority(struct sock *sk, u32 priority)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	sock_set_priority(sk, priority);
+	ssk = msk->first;
+	if (IS_ERR(ssk))
+		goto unlock;
+	lock_sock(ssk);
+	sock_set_priority(ssk, priority);
+	release_sock(ssk);
+unlock:
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_priority);
+
+void mptcp_sock_no_linger(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	WRITE_ONCE(sk->sk_lingertime, 0);
+	sock_set_flag(sk, SOCK_LINGER);
+	ssk = msk->first;
+	if (IS_ERR(ssk))
+		goto unlock;
+	sock_no_linger(ssk);
+unlock:
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_no_linger);
+
+void mptcp_sock_set_tos(struct sock *sk, int val)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	__ip_sock_set_tos(sk, val);
+	ssk = msk->first;
+	if (IS_ERR(ssk))
+		goto unlock;
+	lock_sock(ssk);
+	__ip_sock_set_tos(ssk, val);
+	release_sock(ssk);
+unlock:
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_tos);
-- 
2.51.0

