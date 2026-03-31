Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983553EFD21
	for <mptcp@lists.linux.dev>; Tue, 31 Mar 2026 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952929; cv=none; b=BluW0O9U1KOnegnfnRcRtASXWh18l/Jd8F6zVn/CMvuwKCHS7lRknu3urRxd8ZMGOQqhdUzG/WvCB4cugY7nVEYLE+5pWmEX8uqye2g3cTmdn16HukZ2Ef4cpX3+IkVEnqphzyD31Jy0kSE7wQwecAquIw6CtZVhpQ/eOfi7ccI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952929; c=relaxed/simple;
	bh=L+JVOydn3eZ7Nv0hZnbVuP7CPTy2AU5s5xYCzb8pOwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOo6vN2fFzLSQEUH03SS7jCDmurLa26CoY19DmSQgE7ngAnAlAgw0V6HggIi5lsElnjkn00dcGajPa+nruR0qsMbVblgrvZoyGjpQA3uCuHf1MPZ/vqyQB31o5Ujhu1+G6cx1PjXUEwdW2hDYQWa9uzfh6jAgW4aWIj3lzkMhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOUYa6bh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOUYa6bh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9590C19423;
	Tue, 31 Mar 2026 10:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774952929;
	bh=L+JVOydn3eZ7Nv0hZnbVuP7CPTy2AU5s5xYCzb8pOwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oOUYa6bhLxlfdQ1h6kzxBb5RrkNo/LlYu61tm925cf6sxq+YlvVmpf1vGZO1JY2g+
	 uluEqJwoonJL9wt49acYVGGnpvXumwrtp9n9D/NtgHrSJSPCuDDkcoEU2B1rcc9WNC
	 DFyOHaDiw89LubqJBGhsSCD4/JWx7TPhD2+kwwRP6d7a2hx+pWVeSZPwBNYxbSIczN
	 XTcHI1D2FD5nvNuDA45Q58C1YKRs8tsT4RH1JsSwwJbg2T8Nwa17hJGr8T17RuB91i
	 LN1C4vULTJH+0d+hgn8FVRlKJcvNR+Ll6vkzSzAE6LEn/OS8EHjL0qrA547YDdfz0J
	 ksIM3URTMavDQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v7 5/7] nvme-tcp: implement host mptcp sockops
Date: Tue, 31 Mar 2026 18:28:29 +0800
Message-ID: <e5489a96b8b3bb00d215e71f5911c6bbaa7240ec.1774952107.git.tanggeliang@kylinos.cn>
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
 drivers/nvme/host/tcp.c | 15 +++++++++++++++
 include/net/mptcp.h     |  7 +++++++
 net/mptcp/protocol.h    |  1 +
 net/mptcp/sockopt.c     | 22 ++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1f45f388b9c1..f0ce09b0c142 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2906,6 +2906,17 @@ static const struct nvme_tcp_sockops nvme_tcp_sockops = {
 	.set_tos	= ip_sock_set_tos,
 };
 
+#ifdef CONFIG_MPTCP
+static const struct nvme_tcp_sockops nvme_mptcp_sockops = {
+	.proto		= IPPROTO_MPTCP,
+	.set_syncnt	= mptcp_sock_set_syncnt,
+	.set_nodelay	= mptcp_sock_set_nodelay,
+	.no_linger	= mptcp_sock_no_linger,
+	.set_priority	= mptcp_sock_set_priority,
+	.set_tos	= mptcp_sock_set_tos,
+};
+#endif
+
 static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
@@ -2972,6 +2983,10 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 
 	if (!strcmp(ctrl->ctrl.opts->transport, "tcp")) {
 		ctrl->sockops = &nvme_tcp_sockops;
+#ifdef CONFIG_MPTCP
+	} else if (!strcmp(ctrl->ctrl.opts->transport, "mptcp")) {
+		ctrl->sockops = &nvme_mptcp_sockops;
+#endif
 	} else {
 		ret = -EINVAL;
 		goto out_free_ctrl;
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 91ce7b9b639d..49031a111e69 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -247,6 +247,8 @@ void mptcp_sock_set_priority(struct sock *sk, u32 priority);
 void mptcp_sock_no_linger(struct sock *sk);
 
 void mptcp_sock_set_tos(struct sock *sk, int val);
+
+int mptcp_sock_set_syncnt(struct sock *sk, int val);
 #else
 
 static inline void mptcp_init(void)
@@ -343,6 +345,11 @@ static inline void mptcp_sock_set_priority(struct sock *sk, u32 priority) { }
 static inline void mptcp_sock_no_linger(struct sock *sk) { }
 
 static inline void mptcp_sock_set_tos(struct sock *sk, int val) { }
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
index 2ea2e46977b9..489558b3797c 100644
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

