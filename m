Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCCC2EDD6B
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701623; cv=none; b=q4HNULs1fdRlhVg5n2lUGgxijFDoxvu3E1KsE6OdRtIxLO3XyBCf+oEaMk4BhcapYj10HF0ZU9xZR5HqdOxgAabp9j+w0KeF7C+Z9Ur44ZJ2pNOa7bu7wArYCKAiqmJthrYQWQ4tnYZa3+MyVQOANMp7vtAfbLuhQVdpEF3eI9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701623; c=relaxed/simple;
	bh=YODsaQYjIS6/4RbiVa0XNbpK1NJfiCzwAF97dLWyydA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/0ZGHyYUMuwnZESKNWgP70jiT4oYTRS/CQ7sRxBKT5kxXJe5My9bwR1yivDBfjFCTQDbGSR10qb41KTru2lL63pX3nLD09zqGtUosGhSg0owyBDZVSSN200sDFsgpjhEm/GyEN1QQ70zaxRtQn0aUrLKdP0Stfe2chGtBp5Ut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAFKydaG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAFKydaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F021F00A3C;
	Mon, 25 May 2026 09:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779701621;
	bh=dGGQYA+Y4NUxLZuyhMds8AqzLpchfr8cleqaxv/yrUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lAFKydaG57K0SxTTIoOrW6FZumFdha/20AFWUG5IYqzE7qFu17zlBqoy9VocPr4xX
	 bDv91EGZnJXOoTQRXT8gaFjtxwsnG6FxzyUaCsaIYvJgDIRDXYw86znRpntQaRvyWN
	 erjmqHdOhTxr1KHkFB6AHIAztry3daGioufP89kyTTDplzVMpC0/TgfErQkmEu+SbK
	 vZmppyZAYfsCTaIXnfp/sGBe6SRIKMQSuk1VASyFDJIsuQPZvq0KqIAEVRodqet4lL
	 2LvWHGT9FkTYnwUxV0pEW6CSHpHKeugQJ7N5G9XnwoR6Gs4/Hfl/jn9iBEoIgpJS6+
	 z9AmU7YsougQA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v17 03/14] nvmet-tcp: implement mptcp listen socket ops
Date: Mon, 25 May 2026 17:32:58 +0800
Message-ID: <85d313f78c4515c34c144448f7ddb6598d9aae88.1779701391.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779701391.git.tanggeliang@kylinos.cn>
References: <cover.1779701391.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

An MPTCP-specific version of struct nvmet_tcp_proto_ops is implemented
for listen sockets. It is assigned to port->proto_ops when the transport
type is MPTCP.

Dedicated MPTCP helpers are introduced for setting listen socket options.
The set_nodelay and set_priority helpers set the values on all existing
subflows using mptcp_for_each_subflow(). The set_reuseaddr helper only
applies to the first subflow. The values are then synchronized to other
newly created subflows in sync_socket_options().

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 13 ++++++++
 include/net/mptcp.h       | 12 ++++++++
 net/mptcp/sockopt.c       | 63 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index fa4053cfed12..7093faf3e985 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2057,6 +2057,15 @@ static const struct nvmet_tcp_proto_ops nvmet_tcp_proto_ops = {
 	.set_priority	= sock_set_priority,
 };
 
+#ifdef CONFIG_MPTCP
+static const struct nvmet_tcp_proto_ops nvmet_mptcp_proto_ops = {
+	.protocol	= IPPROTO_MPTCP,
+	.set_reuseaddr	= mptcp_sock_set_reuseaddr,
+	.set_nodelay	= mptcp_sock_set_nodelay,
+	.set_priority	= mptcp_sock_set_priority,
+};
+#endif
+
 static int nvmet_tcp_add_port(struct nvmet_port *nport)
 {
 	const struct nvmet_tcp_proto_ops *ops;
@@ -2084,6 +2093,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 
 	if (nport->disc_addr.trtype == NVMF_TRTYPE_TCP) {
 		ops = &nvmet_tcp_proto_ops;
+#ifdef CONFIG_MPTCP
+	} else if (nport->disc_addr.trtype == NVMF_TRTYPE_MPTCP) {
+		ops = &nvmet_mptcp_proto_ops;
+#endif
 	} else {
 		ret = -EINVAL;
 		goto err_port;
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4cf59e83c1c5..555af4022741 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -237,6 +237,12 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 }
 
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
+
+void mptcp_sock_set_reuseaddr(struct sock *sk);
+
+void mptcp_sock_set_nodelay(struct sock *sk);
+
+void mptcp_sock_set_priority(struct sock *sk, u32 priority);
 #else
 
 static inline void mptcp_init(void)
@@ -323,6 +329,12 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
+
+static inline void mptcp_sock_set_reuseaddr(struct sock *sk) { }
+
+static inline void mptcp_sock_set_nodelay(struct sock *sk) { }
+
+static inline void mptcp_sock_set_priority(struct sock *sk, u32 priority) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 87b5796d0135..9be1105a1ec2 100644
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
@@ -1662,3 +1664,64 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
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
-- 
2.53.0

