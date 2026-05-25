Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371553537ED
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701629; cv=none; b=qRRuVChYVgfgy1uCVNjUZ7jdJ58ra/EebilwDcw+s5mIJx9DoegtHg5XOy3A1fDAI2WXhC7AC8m6vkvfZoyDOP7GbXwMGzTCGg6glh5t5rFNApVKlmwYGiLLz+CbXvwcSJwNSfesOFz44Em4+LTUHPCdbffd0NxB9WUI6lfGEVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701629; c=relaxed/simple;
	bh=A8nnQQI4TIxfp9jQwvsbI67wPHSH2Yh64EHndVLZtfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njAGF5Y87SMgNVISxuZI4bBPLAb8tBtJlEWGtCX715uowshPQVQ+WXlps/1nwY13nRI7hDrFDBzH9LxXSP31GUKstJXilc9Cq/zuFo5My4oVxiiSyTqXe8zooCxy8RIWcrnUlvaXohpq7VEuxIxBbQXPd3SliFwiivZv4IcyqU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJCM6Lo1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJCM6Lo1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988921F00A3A;
	Mon, 25 May 2026 09:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779701627;
	bh=Gmm6CS87D26VCwE2dTWGXMlYPrNFPESKbdWi2JjmXNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dJCM6Lo1Qe4K/c3c3UOCB8AOS9BzCmHf+nD5TZQuvIJLqLyFvrT1Q1qN2kPfWoqCq
	 kEEEtGuQWtlI2Tprb7HwgSS63gN3YAf/BEmLg7Ung8cLFHHSreikxBdEe6Jg8xOxq9
	 tJ+PcDtLZEVc979Hy1KlEXpPL/o21VUX7dvO5Jp1uEPiVZPMwsoRjObMMC+JyoLojc
	 i8TZXcTQ5R1NCC99cdsVm9UO7uXJ6axcTHXJd57L8daM9bNlwwGVla5C0uFdpNyQoT
	 F21S+zi9jWMHfPpm3KkxJy8syHG8Y3n6fuBTGN15jsFCgg6npONrdluALDN/hF8bHq
	 VMMkB2g87qVKw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v17 05/14] nvmet-tcp: implement accept mptcp proto
Date: Mon, 25 May 2026 17:33:00 +0800
Message-ID: <df7873bbc1817c54e0f3742fea5832bb11140b7c.1779701391.git.tanggeliang@kylinos.cn>
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

An MPTCP-specific version of struct nvmet_tcp_proto is implemented for
accept sockets. It is assigned to queue->proto when the accepted socket
protocol is IPPROTO_MPTCP.

Dedicated MPTCP helpers are introduced for setting accept socket options.
These helpers (no_linger, set_priority, set_tos) set the values on all
existing subflows using mptcp_for_each_subflow(). The values are then
synchronized to other newly created subflows in sync_socket_options().

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 16 +++++++++++
 include/net/mptcp.h       |  8 ++++++
 net/mptcp/sockopt.c       | 58 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4c198be45bef..8c2dc4bcbcd3 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -220,6 +220,9 @@ static DEFINE_MUTEX(nvmet_tcp_queue_mutex);
 
 static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
+#ifdef CONFIG_MPTCP
+static const struct nvmet_fabrics_ops nvmet_mptcp_ops;
+#endif
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
 
@@ -1928,6 +1931,15 @@ static const struct nvmet_tcp_proto nvmet_tcp_proto = {
 	.ops		= &nvmet_tcp_ops,
 };
 
+#ifdef CONFIG_MPTCP
+static const struct nvmet_tcp_proto nvmet_mptcp_proto = {
+	.no_linger	= mptcp_sock_no_linger,
+	.set_priority	= mptcp_sock_set_priority,
+	.set_tos	= mptcp_sock_set_tos,
+	.ops		= &nvmet_mptcp_ops,
+};
+#endif
+
 static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		struct socket *newsock)
 {
@@ -1947,6 +1959,10 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	queue->sock = newsock;
 	if (newsock->sk->sk_protocol == IPPROTO_TCP) {
 		queue->proto = &nvmet_tcp_proto;
+#ifdef CONFIG_MPTCP
+	} else if (newsock->sk->sk_protocol == IPPROTO_MPTCP) {
+		queue->proto = &nvmet_mptcp_proto;
+#endif
 	} else {
 		ret = -EINVAL;
 		goto out_free_queue;
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 555af4022741..8eacb9424b37 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -243,6 +243,10 @@ void mptcp_sock_set_reuseaddr(struct sock *sk);
 void mptcp_sock_set_nodelay(struct sock *sk);
 
 void mptcp_sock_set_priority(struct sock *sk, u32 priority);
+
+void mptcp_sock_no_linger(struct sock *sk);
+
+void mptcp_sock_set_tos(struct sock *sk);
 #else
 
 static inline void mptcp_init(void)
@@ -335,6 +339,10 @@ static inline void mptcp_sock_set_reuseaddr(struct sock *sk) { }
 static inline void mptcp_sock_set_nodelay(struct sock *sk) { }
 
 static inline void mptcp_sock_set_priority(struct sock *sk, u32 priority) { }
+
+static inline void mptcp_sock_no_linger(struct sock *sk) { }
+
+static inline void mptcp_sock_set_tos(struct sock *sk) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 9be1105a1ec2..730e945bf8cd 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1725,3 +1725,61 @@ void mptcp_sock_set_priority(struct sock *sk, u32 priority)
 	release_sock(sk);
 }
 EXPORT_SYMBOL(mptcp_sock_set_priority);
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
+static void __mptcp_sock_set_tos(struct sock *sk, int val)
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
+
+void mptcp_sock_set_tos(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	int val = 0;
+
+	lock_sock(sk);
+	if (msk->first)
+		val = inet_sk(msk->first)->rcv_tos;
+	release_sock(sk);
+
+	if (val > 0)
+		__mptcp_sock_set_tos(sk, val);
+}
+EXPORT_SYMBOL(mptcp_sock_set_tos);
-- 
2.53.0

