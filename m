Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D53F1DC9B5
	for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776926005; cv=none; b=QBa8iJqoyUomiLC8Cs1F4AE1vM5L6lKVNyQcRn3LlXMBUXArgKcclEtmAiMYafnIK08zlVAZwrjNDHmxxQ0ikybCLmsqptZJQZe32Wl//ET+l1ErcNy9hG1RvP7MkjEHys5TxEVGAKpxqRidIGwiZzRARkgSurEziVIbKRfjT24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776926005; c=relaxed/simple;
	bh=/O6QlbSkTSJjtvbkPwAGD3BhvPBlY68ni6Rluy7yOzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVrwOCaxESjnFkMySLxM2M35uHx2ueLEkSvfNWzo7wSNA7VRRbsGg3MyOFfDMifD9hafqvjqsKZoMf5AIyj10TTPnrU4zwFa9NNW0N7cBf0VojkpWADn+L8j1GPGC9aTYkpChLN8UDCKxzOrEIA44ivoYCmz8WgXAtQwQs4ksnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bp5yb73W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bp5yb73W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BE7C2BCB2;
	Thu, 23 Apr 2026 06:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776926004;
	bh=/O6QlbSkTSJjtvbkPwAGD3BhvPBlY68ni6Rluy7yOzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bp5yb73WhpPHQh7jhSj/rsOYWDxxRpyGMawyAAVou4t5nNi+H7/patS3XMvXDPRUc
	 tkAQDVa/3J65kPeyMkk+g46eyFFLzFIbsBFBIH5WYX5dZc886uHiI5q1a6j+FyiVrz
	 5qGahs4ClhZCzHeO+CYLyibgiyM9MspLkzeOmUq3HkC0tvuqWn9PS0tJk5vhrO38WS
	 AiKPMyCdGvEO5DmDLtdG1erF92roKEXgapfEZvWZadoGNlCaG5o3wfaCl8/BiT0oFu
	 WxkbIC0o9qv9Syr539jfRYz9fbdhyw266/73Ire4n9QovI4plMJDSerqnGp19hjUrM
	 FIOiU2RrHUIFg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v16 02/16] tls: introduce struct tls_prot_ops
Date: Thu, 23 Apr 2026 14:32:55 +0800
Message-ID: <e90a9f62d486f0ae39c247f524cf3c3f50f80f33.1776924681.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776924681.git.tanggeliang@kylinos.cn>
References: <cover.1776924681.git.tanggeliang@kylinos.cn>
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
 include/net/tls.h  |  19 +++++++++
 net/tls/tls_main.c | 102 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/include/net/tls.h b/include/net/tls.h
index 0551f294800b..0865932d8cc7 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -220,6 +220,25 @@ struct tls_prot_info {
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
+	u32 (*get_skb_seq)(struct sk_buff *skb);
+	__poll_t (*poll)(struct file *file, struct socket *sock,
+			 struct poll_table_struct *wait);
+	bool (*epollin_ready)(const struct sock *sk);
+	void (*check_app_limited)(struct sock *sk);
+};
+
 enum {
 	TLSV4,
 	TLSV6,
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index dad07f5e4541..1ee891405cde 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -115,6 +115,8 @@ CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_256, tls12_crypto_info_aria_gcm_256);
 
 static LIST_HEAD(tls_proto_list);
 static DEFINE_MUTEX(tls_proto_mutex);
+static LIST_HEAD(tls_prot_ops_list);
+static DEFINE_SPINLOCK(tls_prot_ops_lock);
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 			 const struct proto *base);
 
@@ -149,6 +151,18 @@ static void tls_proto_cleanup(void)
 	mutex_unlock(&tls_proto_mutex);
 }
 
+static struct tls_prot_ops *tls_prot_ops_find(int protocol)
+{
+	struct tls_prot_ops *ops;
+
+	list_for_each_entry_rcu(ops, &tls_prot_ops_list, list) {
+		if (ops->protocol == protocol)
+			return ops;
+	}
+
+	return NULL;
+}
+
 void update_sk_prot(struct sock *sk, struct tls_context *ctx)
 {
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
@@ -1275,6 +1289,87 @@ static struct tcp_ulp_ops tcp_tls_ulp_ops __read_mostly = {
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
+	rcu_read_lock();
+	if (tls_prot_ops_find(ops->protocol)) {
+		rcu_read_unlock();
+		spin_unlock(&tls_prot_ops_lock);
+		return -EEXIST;
+	}
+	rcu_read_unlock();
+	list_add_tail_rcu(&ops->list, &tls_prot_ops_list);
+	spin_unlock(&tls_prot_ops_lock);
+
+	pr_debug("tls_prot_ops %d registered\n", ops->protocol);
+	return 0;
+}
+
+static void tls_unregister_prot_ops(struct tls_prot_ops *ops)
+{
+	spin_lock(&tls_prot_ops_lock);
+	list_del_rcu(&ops->list);
+	synchronize_rcu();
+	spin_unlock(&tls_prot_ops_lock);
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
+	.owner			= THIS_MODULE,
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
@@ -1291,9 +1386,15 @@ static int __init tls_register(void)
 	if (err)
 		goto err_strp;
 
+	err = tls_register_prot_ops(&tls_tcp_ops);
+	if (err)
+		goto err_dev;
+
 	tcp_register_ulp(&tcp_tls_ulp_ops);
 
 	return 0;
+err_dev:
+	tls_device_cleanup();
 err_strp:
 	tls_strp_dev_exit();
 err_pernet:
@@ -1304,6 +1405,7 @@ static int __init tls_register(void)
 static void __exit tls_unregister(void)
 {
 	tls_proto_cleanup();
+	tls_unregister_prot_ops(&tls_tcp_ops);
 	tcp_unregister_ulp(&tcp_tls_ulp_ops);
 	tls_strp_dev_exit();
 	tls_device_cleanup();
-- 
2.51.0

