Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4743B387370
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768295370; cv=none; b=c2DtZmsMJj+bfZbCVz1OX8gdNJ1K5oSTm/OfhJdM4Q+fYN/q80yXiJvv0jgVw42PduTFIduxzMvBj6kwmz2s89SUXEOUZ+4D4+qJ/Q+nPj1HgStpRbkeSPgvMJVPEAR56HSDxbmeD19LBc0HaBhQP2X736D4s0bdBXxtxS3/V6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768295370; c=relaxed/simple;
	bh=/POyJlwe/PXLa9O/e5at4Mlm9gFzE6S9sUvtynzRHP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T94EyQau4hDaImW+9DILAbGURt1oIZ+iZqu7e3tP9BBct6W1M58bF2+bjr3D4cMISzGXuOy1T/Ma/PVSFnWs9TcAjIHQfN8uzukuc/5Ca16fvHuZNoa2EwFhKTwrkG0NzErhvckqSqvczRACDH44fF+5SlpSN61iScVUs0eLwdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pG8V1QMd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pG8V1QMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FDEC19423;
	Tue, 13 Jan 2026 09:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768295369;
	bh=/POyJlwe/PXLa9O/e5at4Mlm9gFzE6S9sUvtynzRHP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pG8V1QMdP0SakAOsKjxMyvYaeQucaUU/j0co4nW2odJktI269nKQvJhR3sY7wUPbm
	 8wEXb4fxMQqu0ZLTtHhptAqRwjQYJuPzHalNkcUZU1mlFh1fEr2cKqtPrNuNn5avfz
	 PqolhGpguZr9MX3nmUg/jqGBs0l0MlLrtTgKKaxlytm6BN58/oXJUV+J+xDP0/6mN8
	 nWU8RyVPLLtumHfQBn7u7QueVXzAlz0dZeIOCa16uZu7C8FhEnh0lODNCkv3PGmSqp
	 cOE0duSsD/5hWgcoRb50wj24Wj7d5Z/oqC21QJ752RkJBMO+Ks95hbQ3oIf+geUBHl
	 3anEE199ofg1Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v8 2/9] tls: introduce struct tls_prot_ops
Date: Tue, 13 Jan 2026 17:09:10 +0800
Message-ID: <40823b25823b8467a99c942d08d9415d7c8ca7fe.1768294706.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768294706.git.tanggeliang@kylinos.cn>
References: <cover.1768294706.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To extend MPTCP support based on TCP TLS, a tls_prot_ops structure has
been introduced for TLS, encapsulating TCP-specific helpers within this
structure.

Add registering, validating and finding functions for this structure to
add, validate and find a tls_prot_ops on the global list tls_prot_ops_list.

Register TCP-specific structure tls_tcp_ops in tls_init().

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h  | 18 ++++++++++++
 net/tls/tls_main.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..5f730fb6e801 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -220,6 +220,24 @@ struct tls_prot_info {
 	u16 tail_size;
 };
 
+struct tls_prot_ops {
+	int			protocol;
+	struct module		*owner;
+	struct list_head	list;
+
+	int (*inq)(struct sock *sk);
+	int (*sendmsg_locked)(struct sock *sk, struct msghdr *msg, size_t size);
+	struct sk_buff *(*recv_skb)(struct sock *sk, u32 seq, u32 *off);
+	void (*read_done)(struct sock *sk, size_t len);
+	u32 (*get_skb_seq)(struct sk_buff *skb);
+	int (*read_sock)(struct sock *sk, read_descriptor_t *desc,
+			 sk_read_actor_t recv_actor);
+	__poll_t (*poll)(struct file *file, struct socket *sock,
+			 struct poll_table_struct *wait);
+	bool (*epollin_ready)(const struct sock *sk, int target);
+	void (*check_app_limited)(struct sock *sk);
+};
+
 struct tls_context {
 	/* read-only cache line */
 	struct tls_prot_info prot_info;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 56ce0bc8317b..525f0641d3d0 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -128,6 +128,24 @@ static struct proto_ops tls_proto_ops[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CON
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 			 const struct proto *base);
 
+static DEFINE_SPINLOCK(tls_prot_ops_lock);
+static LIST_HEAD(tls_prot_ops_list);
+
+/* Must be called with rcu read lock held */
+static struct tls_prot_ops *tls_prot_ops_find(int protocol)
+{
+	struct tls_prot_ops *ops, *ret = NULL;
+
+	list_for_each_entry_rcu(ops, &tls_prot_ops_list, list) {
+		if (ops->protocol == protocol) {
+			ret = ops;
+			break;
+		}
+	}
+
+	return ret;
+}
+
 void update_sk_prot(struct sock *sk, struct tls_context *ctx)
 {
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
@@ -1236,6 +1254,58 @@ static struct tcp_ulp_ops tcp_tls_ulp_ops __read_mostly = {
 	.get_info_size		= tls_get_info_size,
 };
 
+static int tls_validate_prot_ops(const struct tls_prot_ops *ops)
+{
+	if (!ops->inq || !ops->sendmsg_locked ||
+	    !ops->recv_skb || !ops->read_done ||
+	    !ops->get_skb_seq || !ops->read_sock ||
+	    !ops->poll || !ops->epollin_ready ||
+	    !ops->check_app_limited) {
+		pr_err("%d does not implement required ops\n", ops->protocol);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tls_register_prot_ops(struct tls_prot_ops *ops)
+{
+	int ret;
+
+	ret = tls_validate_prot_ops(ops);
+	if (ret)
+		return ret;
+
+	spin_lock(&tls_prot_ops_lock);
+	if (tls_prot_ops_find(ops->protocol)) {
+		spin_unlock(&tls_prot_ops_lock);
+		return -EEXIST;
+	}
+	list_add_tail_rcu(&ops->list, &tls_prot_ops_list);
+	spin_unlock(&tls_prot_ops_lock);
+
+	pr_debug("tls_prot_ops %d registered\n", ops->protocol);
+	return 0;
+}
+
+static u32 tcp_get_skb_seq(struct sk_buff *skb)
+{
+	return TCP_SKB_CB(skb)->seq;
+}
+
+static struct tls_prot_ops tls_tcp_ops = {
+	.protocol		= IPPROTO_TCP,
+	.inq			= tcp_inq,
+	.sendmsg_locked		= tcp_sendmsg_locked,
+	.recv_skb		= tcp_recv_skb,
+	.read_done		= tcp_read_done,
+	.get_skb_seq		= tcp_get_skb_seq,
+	.read_sock		= tcp_read_sock,
+	.poll			= tcp_poll,
+	.epollin_ready		= tcp_epollin_ready,
+	.check_app_limited	= tcp_rate_check_app_limited,
+};
+
 static int __init tls_register(void)
 {
 	int err;
@@ -1254,6 +1324,8 @@ static int __init tls_register(void)
 
 	tcp_register_ulp(&tcp_tls_ulp_ops);
 
+	tls_register_prot_ops(&tls_tcp_ops);
+
 	return 0;
 err_strp:
 	tls_strp_dev_exit();
-- 
2.51.0

