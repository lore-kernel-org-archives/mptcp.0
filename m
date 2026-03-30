Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0702DF136
	for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863940; cv=none; b=SHuaAZOTAVBvCCtL4dZaw70qaleiOY3y7flK1ir3FaQldfzhcixPtHV4iB8R+EQr5l8uDvE4HHd2qCXRWmxo6qWIgo4gsBUMPx3KveGOoJ/BgonpqK/HKbucL3uMkrenaYLCkZARm3H3H+9Xf4IvH1Ko+tRgOtweFei5kzxjb0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863940; c=relaxed/simple;
	bh=/PZQFCXDulJ8vLfSgkMtQ6gYJ90ctQj+2kufTur7CVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0ipSKpG4Mqu7Lgjhyr5MvrB2fWkrPturJJzmoIWSziBzOade8yyn0QOOdnXe80oWAVnkmvlrjaHzwx4nNiCZ3D6tzt99tcjUvqyjZ9JHznE3/OtMQf/0oo5Wc2KLN9NdW02weg0U+xpPpA7XSrPwPwl1c+cp9ujtEGQ9dNMwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsyIUSzb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsyIUSzb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0383C4CEF7;
	Mon, 30 Mar 2026 09:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774863940;
	bh=/PZQFCXDulJ8vLfSgkMtQ6gYJ90ctQj+2kufTur7CVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TsyIUSzbKV2+iKuAeJ+E1n6wKWuuBAIKY/n2Mi4aFfmNWT69X9EfbBJKXRWfFGsf8
	 wKIaduAH0tKAMUnCTkdYoxaYPYVWOwKxH2q8VnwONCgEBsGosOv+R6wTfZjFb3DsjE
	 ihQVJMUM9bUZ5bzqgyZtMm8PzFUBin0YvM/+A0WdNOwBE1MY9WIrn80+LHA7NHhf8m
	 BPD0uIe6azLrCH+sXGAUMRTviBDzRmltDz0vCtQwUg98lNe1pQ8MyBARoO1LBvvKwe
	 6iV4xEWc8tejuo4ccfS4UbOHStJDPi+kT+1gVsNvRn/S8Ltqw6AfSfmxJ6OdMeNvcI
	 JnqxG/U/3e0LA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v6 2/7] nvmet-tcp: implement target mptcp sockops
Date: Mon, 30 Mar 2026 17:43:27 +0800
Message-ID: <d7afdc0639d6aadcb50579f8e52221ed5d404af6.1774862875.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1774862875.git.tanggeliang@kylinos.cn>
References: <cover.1774862875.git.tanggeliang@kylinos.cn>
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
 drivers/nvme/target/tcp.c | 13 ++++++
 include/linux/nvme.h      |  1 +
 include/net/mptcp.h       | 20 ++++++++
 net/mptcp/sockopt.c       | 98 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index b20adfb10737..03f876440f6d 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2049,6 +2049,15 @@ static const struct nvmet_tcp_sockops nvmet_tcp_sockops = {
 	.set_tos	= ip_sock_set_tos,
 };
 
+static const struct nvmet_tcp_sockops nvmet_mptcp_sockops = {
+	.proto		= IPPROTO_MPTCP,
+	.set_reuseaddr	= mptcp_sock_set_reuseaddr,
+	.set_nodelay	= mptcp_sock_set_nodelay,
+	.set_priority	= mptcp_sock_set_priority,
+	.no_linger	= mptcp_sock_no_linger,
+	.set_tos	= mptcp_sock_set_tos,
+};
+
 static int nvmet_tcp_add_port(struct nvmet_port *nport)
 {
 	struct nvmet_tcp_port *port;
@@ -2075,6 +2084,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 
 	if (nport->disc_addr.trtype == NVMF_TRTYPE_TCP) {
 		port->sockops = nvmet_tcp_sockops;
+#ifdef CONFIG_MPTCP
+	} else if (nport->disc_addr.trtype == NVMF_TRTYPE_MPTCP) {
+		port->sockops = nvmet_mptcp_sockops;
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
index 4cf59e83c1c5..6eca3ff13324 100644
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
+static void mptcp_sock_set_priority(struct sock *sk, u32 priority) { }
+
+static inline void mptcp_sock_no_linger(struct sock *sk) { }
+
+static void mptcp_sock_set_tos(struct sock *sk, int val) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index de90a2897d2d..c6a2ccab7049 100644
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
+	ssk = __mptcp_nmpc_sk(msk);
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
+	ssk = __mptcp_nmpc_sk(msk);
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
+	ssk = __mptcp_nmpc_sk(msk);
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

