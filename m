Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E213FBB4E
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106084; cv=none; b=M/uhtzgyYxhSHAzyl4LfDcKotLvS0V48NuygDyNCMm+4SqgXsiiprfBXU2kttKfIqgj/+o5qmuyoFHSyC8DN4BB9OCKO+AwCxzHJyoUf0Hx2IMtofxbnr1JZlJnn8YoMbmYz3Ly8KCl8Rx56UT8dO8nyLgFfi3hPd/UfdOL4nJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106084; c=relaxed/simple;
	bh=9HbGYzw9yj0MAog2AYmMzk08rWJqwlnr2j5Z7TMhZoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8+TjiFYN+CswE/oq26BAzbaPLDWltNgvCv7rajmokFfN+QfuzHv0NN2/2YTDqbDF1HYS0/ZXnRjWcCBRAxLoCt07wthSW31zh2jRxkSmDZR9kZ973qkEjj9kmhiDMTaggE5oVBI12Z05/N9eUORypC0r1cRYylLepRALy1gsu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inYTiKK7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inYTiKK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87865C2BCC6;
	Mon, 18 May 2026 12:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779106083;
	bh=9HbGYzw9yj0MAog2AYmMzk08rWJqwlnr2j5Z7TMhZoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=inYTiKK7wLBQmDoYTJOgfaPj88VL+Pv2Pl0Ny2yOjg+5+qZjZ2JcdNFIqbbBuOK63
	 GkiLiOdtuWgfCSgpRY/cANQYueNcluFmjIowrljsTsSJxEXOEbgdApG5CMP64UEWSd
	 V+IN6QWtBmXXIDte6SZtTiBtACoFUKSSslHo4M4iahnQI+WdLjb/KJBVPbqfK4WqYY
	 ERbiXIdSgyZs6Akjq9/bG4ileAc+Jn5ysZuEOut/aVu19WZL2JrsGBe9W9UPKM+TJk
	 4YO1zn8VJzDcUnGWUl1ZATP7xBPEYihkTl2dwnDWGFMDqCE3cbSwWr7VwXxXSyrm4k
	 ll4T/OzD0MxYQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v13 04/12] nvmet-tcp: implement target mptcp proto
Date: Mon, 18 May 2026 20:07:29 +0800
Message-ID: <a707c71aecbfc573bad42074237b005874b96708.1779104752.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779104752.git.tanggeliang@kylinos.cn>
References: <cover.1779104752.git.tanggeliang@kylinos.cn>
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

Dedicated MPTCP helpers are introduced for setting socket options. Most
of these helpers (set_nodelay, set_priority, no_linger, set_tos) set the
values on all existing subflows using mptcp_for_each_subflow(). The
set_reuseaddr helper only applies to the first subflow. The values are
then synchronized to other newly created subflows in sync_socket_options().

Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c |  15 ++++
 include/net/mptcp.h       |  20 +++++
 net/mptcp/sockopt.c       | 153 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 745c939498fa..73afaf3562a6 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2091,6 +2091,17 @@ static const struct nvmet_tcp_proto nvmet_tcp_proto = {
 	.set_tos	= tcp_sock_set_tos,
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
 static int nvmet_tcp_add_port(struct nvmet_port *nport)
 {
 	struct nvmet_tcp_port *port;
@@ -2119,6 +2130,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 
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
index 4cf59e83c1c5..8eacb9424b37 100644
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
+void mptcp_sock_set_tos(struct sock *sk);
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
+static inline void mptcp_sock_set_tos(struct sock *sk) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 87b5796d0135..be245babef30 100644
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
@@ -1662,3 +1664,154 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
 	}
 	return 0;
 }
+
+void mptcp_sock_set_reuseaddr(struct sock *sk)
+{
+	struct mptcp_sock *msk;
+	struct sock *ssk;
+
+	if (sk->sk_protocol != IPPROTO_MPTCP)
+		return;
+
+	msk = mptcp_sk(sk);
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
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk;
+	struct sock *ssk;
+
+	if (sk->sk_protocol != IPPROTO_MPTCP)
+		return;
+
+	msk = mptcp_sk(sk);
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
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk;
+	struct sock *ssk;
+
+	if (sk->sk_protocol != IPPROTO_MPTCP)
+		return;
+
+	msk = mptcp_sk(sk);
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
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk;
+	struct sock *ssk;
+
+	if (sk->sk_protocol != IPPROTO_MPTCP)
+		return;
+
+	msk = mptcp_sk(sk);
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
+static void __mptcp_sock_set_tos(struct sock *sk, int val)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk;
+	struct sock *ssk;
+
+	if (sk->sk_protocol != IPPROTO_MPTCP)
+		return;
+
+	msk = mptcp_sk(sk);
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
+
+void mptcp_sock_set_tos(struct sock *sk)
+{
+	struct mptcp_sock *msk;
+	struct sock *ssk;
+	int val = 0;
+
+	if (sk->sk_protocol != IPPROTO_MPTCP)
+		return;
+
+	msk = mptcp_sk(sk);
+
+	lock_sock(sk);
+	ssk = msk->first;
+	if (ssk && ssk->sk_state == TCP_ESTABLISHED)
+		val = inet_sk(ssk)->rcv_tos;
+	release_sock(sk);
+
+	if (val > 0)
+		__mptcp_sock_set_tos(sk, val);
+}
+EXPORT_SYMBOL(mptcp_sock_set_tos);
-- 
2.53.0

