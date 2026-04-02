Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85F428690
	for <mptcp@lists.linux.dev>; Thu,  2 Apr 2026 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116078; cv=none; b=QypzhRSJts6Zl3brOSRdDnljiN0+Awr9Com94ehpRzDJ+j4cmNEVV9P5TdNblw+mr2/Zw9dciR6Dii0w+JEap0lFKtIUzqj+9GciI7wzu54HoMTG/RfdMiXu7q27AxSDtKvB58A68E+v87dTUa7Qm5Mlg+NOihUtuqn5pLrdbfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116078; c=relaxed/simple;
	bh=JVurSmLyeZMlXBj4E7l1+mJJMl9u3MQsQjPhcbMEW8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1AkaRUmwGIU0plZ3O0jARqWs18+FdGsUneARj18NSG65MJYuVHGIBbd1kmRaijWPagVGmsrYkneCb/bg9XmYqzhTTyu/xSndKrt72bBwaMCyEop8rLeV6iMCjiKA86o0smekKNp76gc0QX5tQ1g/yPD8aKIlaXnHvBTAw7Rad4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/IpIe/1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/IpIe/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1ABAC19423;
	Thu,  2 Apr 2026 07:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775116078;
	bh=JVurSmLyeZMlXBj4E7l1+mJJMl9u3MQsQjPhcbMEW8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/IpIe/1NUMzbe/FMIJK5Sho1typolq/tuBRB9FzcJzOd7nyw57NtRIeICsjvmVC8
	 cNVKGVrv9OPjvKmslE13pO7QIS4ck6WkTkkx8i1T5nq/LJka2nASwA0sGLSvMjBN6b
	 Lidw8Y4KN2LOudyyrUX3HyuG4ldip2sNbDVIgqyrdn3G8T883nWySMZ6k5y/Y34XDS
	 RU1mnxCSBlN2L4TA0F83DPCuhzALyjwGs3yDZP0eBZZCAyn0+BXE51YgsyHY9/XPQD
	 IBTV671UAq5pO5fozxaF9eQV6dCNaghYUFOWFWjpqY0k/hAoRlXnSCFd9l2Rbwfxdj
	 uNQffbAOTpQUA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v12 01/15] tls: introduce struct tls_prot_ops
Date: Thu,  2 Apr 2026 15:47:36 +0800
Message-ID: <df6b799c6c79e9c7c69dd395790da7ec9d3aae2e.1775115102.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775115102.git.tanggeliang@kylinos.cn>
References: <cover.1775115102.git.tanggeliang@kylinos.cn>
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
 include/net/tls.h  | 20 +++++++++++
 net/tls/tls_main.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..cf85f7a0c931 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -220,6 +220,26 @@ struct tls_prot_info {
 	u16 tail_size;
 };
 
+struct tls_prot_ops {
+	int			protocol;
+	struct module		*owner;
+	struct list_head	list;
+
+	int (*inq)(struct sock *sk);
+	int (*sendmsg_locked)(struct sock *sk, struct msghdr *msg, size_t size);
+	struct sk_buff *(*recv_skb)(struct sock *sk, u32 *off);
+	bool (*lock_is_held)(struct sock *sk);
+	int (*read_sock)(struct sock *sk, read_descriptor_t *desc,
+			 sk_read_actor_t recv_actor);
+	void (*read_done)(struct sock *sk, size_t len);
+	u32 (*get_skb_off)(struct sk_buff *skb);
+	u32 (*get_skb_seq)(struct sk_buff *skb);
+	__poll_t (*poll)(struct file *file, struct socket *sock,
+			 struct poll_table_struct *wait);
+	bool (*epollin_ready)(const struct sock *sk);
+	void (*check_app_limited)(struct sock *sk);
+};
+
 struct tls_context {
 	/* read-only cache line */
 	struct tls_prot_info prot_info;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fd39acf41a61..5ee7c7d60942 100644
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
@@ -1236,6 +1254,75 @@ static struct tcp_ulp_ops tcp_tls_ulp_ops __read_mostly = {
 	.get_info_size		= tls_get_info_size,
 };
 
+static int tls_validate_prot_ops(const struct tls_prot_ops *ops)
+{
+	if (!ops->inq || !ops->sendmsg_locked ||
+	    !ops->recv_skb || !ops->lock_is_held ||
+	    !ops->read_sock || !ops->read_done ||
+	    !ops->get_skb_seq ||
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
+static struct sk_buff *tls_tcp_recv_skb(struct sock *sk, u32 *off)
+{
+	return tcp_recv_skb(sk, tcp_sk(sk)->copied_seq, off);
+}
+
+static bool tls_tcp_lock_is_held(struct sock *sk)
+{
+	return sock_owned_by_user_nocheck(sk);
+}
+
+static u32 tls_tcp_get_skb_seq(struct sk_buff *skb)
+{
+	return TCP_SKB_CB(skb)->seq;
+}
+
+static bool tls_tcp_epollin_ready(const struct sock *sk)
+{
+	return tcp_epollin_ready(sk, INT_MAX);
+}
+
+static struct tls_prot_ops tls_tcp_ops = {
+	.protocol		= IPPROTO_TCP,
+	.inq			= tcp_inq,
+	.sendmsg_locked		= tcp_sendmsg_locked,
+	.recv_skb		= tls_tcp_recv_skb,
+	.lock_is_held		= tls_tcp_lock_is_held,
+	.read_sock		= tcp_read_sock,
+	.read_done		= tcp_read_done,
+	.get_skb_seq		= tls_tcp_get_skb_seq,
+	.poll			= tcp_poll,
+	.epollin_ready		= tls_tcp_epollin_ready,
+	.check_app_limited	= tcp_rate_check_app_limited,
+};
+
 static int __init tls_register(void)
 {
 	int err;
@@ -1254,6 +1341,8 @@ static int __init tls_register(void)
 
 	tcp_register_ulp(&tcp_tls_ulp_ops);
 
+	tls_register_prot_ops(&tls_tcp_ops);
+
 	return 0;
 err_strp:
 	tls_strp_dev_exit();
-- 
2.51.0

