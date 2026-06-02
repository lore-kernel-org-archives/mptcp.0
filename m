Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BCD364047
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 02:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367591; cv=none; b=kQ8VYk3SMXjBY7ayE051m9NaAW0Ub25ZOf8B98ejkZzVgft7BqyQMNML4Gv5FYnLyzEuSY+Oqhn/2ESo/O7wc7k7OZ3w3gB/DVFdtSSzcyDOK/pO8m2XcdnYI11TDn15Ah5nQOdSOeSyCd6XeLGDQchVKAQxv2CT9RsgMk8qmiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367591; c=relaxed/simple;
	bh=NJlCxUoipiMwT1O1ydtV/uuW6N7EzKcAi/lfMtRGgq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKCq00QJHeYXK9wcH7yXLQ4RS4B6C/MclHFLXT1RvV1BWOK20VzEo2PpDpdCoeFcfmRdrXpK1+UlB3T0J6IwVQsCH1ITeYO66bbk3E57hUFz2EM15wDxBx2VcnlV/Vgoy/Ttq46mbdvyEsfOeJkGO7/xt4QpRGo9ZgCWbb6rFCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKSp/Ju0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKSp/Ju0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC641F00893;
	Tue,  2 Jun 2026 02:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367589;
	bh=v+wvuwJEEQWQpNhJD324Fh9ICKitTj+YV2r36JFozqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IKSp/Ju0sFof0j0TcIFlNTq8iY/j4Gy4FKXn/CjXpvAq6Img6R5lbxoEKtqu0l8cR
	 NaffxRzhX2jjyGIF20PAof5wQ7Vrp0Oot2l8bTf+Kc+u8xO+erWIYvEsLJdnKvWhl5
	 QeoUR68A+LMW7cV4+j0047rIyb0GxEBPdcpX3ZXcoC7AtgnWTZPATxupHCweDhOyug
	 UOJDgWc9e9jwwhZk/ruBJihYncJKstCrvEqxP/40lVf3yZEdwTvBw9wa+IA0QqGXU5
	 b5vQ7kkxpRvz7hdTv0RykHUA6Dbm1A4LIsRTLsQWHJk8ACPtSVYWrMZ+wLpkaVCItc
	 vweBQQAWhRnVw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v23 02/16] tls: introduce tls protocol ops structure
Date: Tue,  2 Jun 2026 10:32:43 +0800
Message-ID: <cb211e2076b08e44e1569c2cc5e141729a90715d.1780362942.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780362942.git.tanggeliang@kylinos.cn>
References: <cover.1780362942.git.tanggeliang@kylinos.cn>
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
 include/net/tls.h  |  22 ++++++++++
 net/tls/tls_main.c | 106 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 7ff4d4566d41..e13894c054ad 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -220,6 +220,28 @@ struct tls_prot_info {
 	u16 tail_size;
 };
 
+struct tls_prot_ops {
+	struct module		*owner;
+	int			protocol;
+	struct list_head	list;
+
+	int (*inq)(struct sock *sk);
+	int (*sendmsg_locked)(struct sock *sk, struct msghdr *msg,
+			      size_t size);
+	struct sk_buff *(*recv_skb)(struct sock *sk, u32 *off);
+	bool (*lock_is_held)(struct sock *sk);
+	int (*read_sock)(struct sock *sk, read_descriptor_t *desc,
+			 sk_read_actor_t recv_actor);
+	void (*read_done)(struct sock *sk, size_t len);
+	u32 (*get_skb_seq)(struct sk_buff *skb);
+	int (*skb_copy_bits)(const struct sk_buff *skb, int offset,
+			     void *to, int len);
+	__poll_t (*poll)(struct file *file, struct socket *sock,
+			 struct poll_table_struct *wait);
+	bool (*epollin_ready)(const struct sock *sk);
+	void (*check_app_limited)(struct sock *sk);
+};
+
 struct tls_prot {
 	struct rcu_head			rcu;
 	refcount_t			refcnt;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 62426f478ce0..8fe9529ba4e8 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -120,6 +120,7 @@ CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_128, tls12_crypto_info_aria_gcm_128);
 CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_256, tls12_crypto_info_aria_gcm_256);
 
 static LIST_HEAD(tls_prot_list);
+static LIST_HEAD(tls_prot_ops_list);
 static DEFINE_SPINLOCK(tls_prot_lock);
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 			 const struct proto *base);
@@ -161,6 +162,22 @@ static void tls_prot_cleanup(void)
 	rcu_barrier();
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
 	struct tls_prot *prot = ctx->prot;
@@ -1315,6 +1332,86 @@ static struct tcp_ulp_ops tcp_tls_ulp_ops __read_mostly = {
 	.get_info_size		= tls_get_info_size,
 };
 
+static int tls_validate_prot_ops(const struct tls_prot_ops *ops)
+{
+	if (!ops->inq || !ops->sendmsg_locked ||
+	    !ops->recv_skb || !ops->lock_is_held ||
+	    !ops->read_sock || !ops->read_done ||
+	    !ops->get_skb_seq || !ops->skb_copy_bits ||
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
+	spin_lock_bh(&tls_prot_lock);
+	if (tls_prot_ops_find(ops->protocol)) {
+		spin_unlock_bh(&tls_prot_lock);
+		return -EEXIST;
+	}
+
+	list_add_tail_rcu(&ops->list, &tls_prot_ops_list);
+	spin_unlock_bh(&tls_prot_lock);
+
+	pr_debug("tls_prot_ops %d registered\n", ops->protocol);
+	return 0;
+}
+
+static void tls_unregister_prot_ops(struct tls_prot_ops *ops)
+{
+	spin_lock_bh(&tls_prot_lock);
+	list_del_rcu(&ops->list);
+	spin_unlock_bh(&tls_prot_lock);
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
+	.skb_copy_bits		= skb_copy_bits,
+	.poll			= tcp_poll,
+	.epollin_ready		= tls_tcp_epollin_ready,
+	.check_app_limited	= tcp_rate_check_app_limited,
+};
+
 static int __init tls_register(void)
 {
 	int err;
@@ -1327,13 +1424,19 @@ static int __init tls_register(void)
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
@@ -1344,6 +1447,7 @@ static int __init tls_register(void)
 static void __exit tls_unregister(void)
 {
 	tcp_unregister_ulp(&tcp_tls_ulp_ops);
+	tls_unregister_prot_ops(&tls_tcp_ops);
 	tls_prot_cleanup();
 	tls_strp_dev_exit();
 	tls_device_cleanup();
-- 
2.53.0

