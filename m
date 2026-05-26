Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5A43D79FF
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788813; cv=none; b=nKO09RBfa2bMas9BNFVx94auyqKyXZkVz98boTxXkg9b4KP05uXgTizDCMaPlfM4Xq842oB5hyjpAswhdRlu/l76ee/GOAsSDjxj/XWzQO7/DSGxfTENwKmZ4REpJ8Xbj4cafrxtEEW/e0J14APoqRdR2JxnwSSyKxswY1yCyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788813; c=relaxed/simple;
	bh=mY1D0AKlg50i/zO9DrpfioSBwF7lFo9dBEs39JGx6oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1+hMHYD6JqSJ9JfIS00df8uU2TjFTh5VmJ9JuhW2PuOS/LJwxm3HH/6qeXb5+u4XWp8OVxRIBng6mvtRbX6TITsCn3H2wTwKLGlZwE3WdYtP6oFlL9RWl+dN1O/Qh7EZIa4P+Ux1otjVhvt+HN4p7QdZwO3MY7r7xAsdovqACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjFlhBlI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjFlhBlI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5A61F00A3D;
	Tue, 26 May 2026 09:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788810;
	bh=8qz0DBIyU7gYPAz1LsSz0liqb+db4FhDrV3jIKysBaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZjFlhBlIbo37rctwSxLj3t2qqVdOGhtNZRAdoOA2IcaBvMP0rxpjQBtNuzmVsrlkf
	 HSQOg7uvLeVUfriOi1R3Es7MdydsuMqg3P+2HW49UNpSPeK1eANXkl4/0+0GvJs+Hp
	 kJd9ZSYe+vlMuKQO7uYc8dx+/cafxxigJDrP1KoscD0QuI68RlxcwXGFxdWizF933E
	 dpj87rtoye2aA4gI4AhOVKWjFeauIGpBjHekVdYnddu74D9GLU6tpPBVJSRTy75gC5
	 xi7QL3rPmu/ENAhADiRO1IDlmTlue/qcONTybwux8NUyfJAAoWR9yr0IChzKqO9XeA
	 XsRumCg0MDl4g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v20 02/15] tls: introduce struct tls_prot_ops
Date: Tue, 26 May 2026 17:46:20 +0800
Message-ID: <6e2b050040cbee3597c3d994ddbc8f3ba24b1637.1779788090.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779788090.git.tanggeliang@kylinos.cn>
References: <cover.1779788090.git.tanggeliang@kylinos.cn>
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

Register TCP-specific structure tls_tcp_ops in tls_register().

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h  |  19 ++++++++
 net/tls/tls_main.c | 105 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 65c4c2c72e06..eab4e68642ad 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -220,6 +220,25 @@ struct tls_prot_info {
 	u16 tail_size;
 };
 
+struct tls_prot_ops {
+	struct module		*owner;
+	int			protocol;
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
 struct tls_proto {
 	struct rcu_head			rcu;
 	refcount_t			refcnt;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 30b50ea708ee..ca51f5159eda 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -120,6 +120,7 @@ CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_128, tls12_crypto_info_aria_gcm_128);
 CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_256, tls12_crypto_info_aria_gcm_256);
 
 static LIST_HEAD(tls_proto_list);
+static LIST_HEAD(tls_prot_ops_list);
 static DEFINE_SPINLOCK(tls_proto_lock);
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 			 const struct proto *base);
@@ -160,6 +161,22 @@ static void tls_proto_cleanup(void)
 	spin_unlock_bh(&tls_proto_lock);
 }
 
+static struct tls_prot_ops *tls_prot_ops_find(int protocol)
+{
+	struct tls_prot_ops *ops, *ret = NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ops, &tls_prot_ops_list, list) {
+		if (ops->protocol == protocol) {
+			ret = ops;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
 void update_sk_prot(struct sock *sk, struct tls_context *ctx)
 {
 	struct tls_proto *proto = ctx->proto;
@@ -1296,6 +1313,85 @@ static struct tcp_ulp_ops tcp_tls_ulp_ops __read_mostly = {
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
+	spin_lock_bh(&tls_proto_lock);
+	if (tls_prot_ops_find(ops->protocol)) {
+		spin_unlock_bh(&tls_proto_lock);
+		return -EEXIST;
+	}
+
+	list_add_tail_rcu(&ops->list, &tls_prot_ops_list);
+	spin_unlock_bh(&tls_proto_lock);
+
+	pr_debug("tls_prot_ops %d registered\n", ops->protocol);
+	return 0;
+}
+
+static void tls_unregister_prot_ops(struct tls_prot_ops *ops)
+{
+	spin_lock_bh(&tls_proto_lock);
+	list_del_rcu(&ops->list);
+	spin_unlock_bh(&tls_proto_lock);
+	synchronize_rcu();
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
+	.owner			= THIS_MODULE,
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
@@ -1308,13 +1404,19 @@ static int __init tls_register(void)
 	if (err)
 		goto err_pernet;
 
-	err = tls_device_init();
+	err = tls_register_prot_ops(&tls_tcp_ops);
 	if (err)
 		goto err_strp;
 
+	err = tls_device_init();
+	if (err)
+		goto err_ops;
+
 	tcp_register_ulp(&tcp_tls_ulp_ops);
 
 	return 0;
+err_ops:
+	tls_unregister_prot_ops(&tls_tcp_ops);
 err_strp:
 	tls_strp_dev_exit();
 err_pernet:
@@ -1325,6 +1427,7 @@ static int __init tls_register(void)
 static void __exit tls_unregister(void)
 {
 	tcp_unregister_ulp(&tcp_tls_ulp_ops);
+	tls_unregister_prot_ops(&tls_tcp_ops);
 	tls_proto_cleanup();
 	tls_strp_dev_exit();
 	tls_device_cleanup();
-- 
2.53.0

