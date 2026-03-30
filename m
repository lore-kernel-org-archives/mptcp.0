Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6327FD6D
	for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863948; cv=none; b=LzDgZldMooeTpCqFAXVO919pCmk+ic/+Y2syf0SX61/irqB2IUj3qfj4mzSgGYScToXmrBzyR++xaANnRgteaXlbbfU5z/qUN3jofFKavJklqf2qc6kqcCHMeS4iOXl61vzfqk6FULVlDDOYckz5vIHEk6cHfwAWpfjB52z2CKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863948; c=relaxed/simple;
	bh=AGPsuqvGzES3JEcto12OU21fYprkgl+WW+bx3Cax1Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vD1d/EFJ6l/WvxLbi+t8XxH9J6aREll8UC1AiRSwoLmpFUCEEf0EYiJk4E1epDp7G1+/sunRBN7zmCmyJcljo0xau1IuFWl9GWbKcLo82VDKVYLUwY2Wl2j+bbQ5ax9CrFyNKQhqqyMROSKv16ghbnn4XL6ZPDuGnY0QNwbgl+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Emq+zEfo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Emq+zEfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437ABC4CEF7;
	Mon, 30 Mar 2026 09:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774863947;
	bh=AGPsuqvGzES3JEcto12OU21fYprkgl+WW+bx3Cax1Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Emq+zEfo997HczMO1lxM82g2jHzZBpv9z7YRDrdtloEnHK+Nvdan1ZNi/V3yMm+6w
	 7ENMNgInhN5ESHjPfsrNp+W2SZL/ckAeFjx1fqEr91zMUzGJ0DUAl1DnI1L9hywkVL
	 RN/KQqJrys2Qtl7+cPgP6xB4s1moHif7CBeZsesqqXHuX65QYI75vk/cSlGaG7F2KX
	 WNB7J6cOoQXj28nvKLH8xwahQwM0zvSphvh71S6l+XOqgs+3B6vpnkQGrUOOtm33Zq
	 iXSeXeLpngD5494Exba9RUcof2qIT9Y2kGnkVTr0xHRW3BdOFndkB/1nl2b83EA2f+
	 X0DIh9NKgwsAg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v6 5/7] nvme-tcp: implement host mptcp sockops
Date: Mon, 30 Mar 2026 17:43:30 +0800
Message-ID: <df749b8c8c9a9851d7af4518ee110680f7e157a0.1774862875.git.tanggeliang@kylinos.cn>
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

An MPTCP-specific version of struct nvme_tcp_sockops is implemented,
and it is assigned to ctrl->sockops when the transport string is "mptcp".

The socket option setting logic is similar to the target side, except that
mptcp_sock_set_syncnt is newly defined for the host side.

It sets the value on the first subflow socket of an MPTCP connection.
The value is then synchronized to other newly created subflows in
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
 drivers/nvme/host/tcp.c | 13 +++++++++++++
 include/net/mptcp.h     |  7 +++++++
 net/mptcp/protocol.h    |  1 +
 net/mptcp/sockopt.c     | 22 ++++++++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 910c4186eb3b..cf80f9354471 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2906,6 +2906,15 @@ static const struct nvme_tcp_sockops nvme_tcp_sockops = {
 	.set_tos	= ip_sock_set_tos,
 };
 
+static const struct nvme_tcp_sockops nvme_mptcp_sockops = {
+	.proto		= IPPROTO_MPTCP,
+	.set_syncnt	= mptcp_sock_set_syncnt,
+	.set_nodelay	= mptcp_sock_set_nodelay,
+	.no_linger	= mptcp_sock_no_linger,
+	.set_priority	= mptcp_sock_set_priority,
+	.set_tos	= mptcp_sock_set_tos,
+};
+
 static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
@@ -2982,6 +2991,10 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 
 	if (!strcmp(ctrl->ctrl.opts->transport, "tcp")) {
 		ctrl->sockops = nvme_tcp_sockops;
+#ifdef CONFIG_MPTCP
+	} else if (!strcmp(ctrl->ctrl.opts->transport, "mptcp")) {
+		ctrl->sockops = nvme_mptcp_sockops;
+#endif
 	} else {
 		ret = -EINVAL;
 		goto out_kfree_queues;
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6eca3ff13324..d4bc9bde2256 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -247,6 +247,8 @@ void mptcp_sock_set_priority(struct sock *sk, u32 priority);
 void mptcp_sock_no_linger(struct sock *sk);
 
 void mptcp_sock_set_tos(struct sock *sk, int val);
+
+int mptcp_sock_set_syncnt(struct sock *sk, int val);
 #else
 
 static inline void mptcp_init(void)
@@ -343,6 +345,11 @@ static void mptcp_sock_set_priority(struct sock *sk, u32 priority) { }
 static inline void mptcp_sock_no_linger(struct sock *sk) { }
 
 static void mptcp_sock_set_tos(struct sock *sk, int val) { }
+
+static inline int mptcp_sock_set_syncnt(struct sock *sk, int val)
+{
+	return 0;
+}
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f5d4d7d030f2..84e80816b2a4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -335,6 +335,7 @@ struct mptcp_sock {
 	int		keepalive_idle;
 	int		keepalive_intvl;
 	int		maxseg;
+	int		icsk_syn_retries;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index c6a2ccab7049..df1b6d2c4d7e 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1592,6 +1592,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	priority = READ_ONCE(sk->sk_priority);
 	if (priority > 0)
 		sock_set_priority(ssk, priority);
+	tcp_sock_set_syncnt(ssk, msk->icsk_syn_retries);
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
@@ -1750,3 +1751,24 @@ void mptcp_sock_set_tos(struct sock *sk, int val)
 	release_sock(sk);
 }
 EXPORT_SYMBOL(mptcp_sock_set_tos);
+
+int mptcp_sock_set_syncnt(struct sock *sk, int val)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk;
+
+	if (val < 1 || val > MAX_TCP_SYNCNT)
+		return -EINVAL;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	msk->icsk_syn_retries = val;
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk))
+		goto unlock;
+	tcp_sock_set_syncnt(ssk, val);
+unlock:
+	release_sock(sk);
+	return 0;
+}
+EXPORT_SYMBOL(mptcp_sock_set_syncnt);
-- 
2.51.0

