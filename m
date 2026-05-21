Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47700376462
	for <mptcp@lists.linux.dev>; Thu, 21 May 2026 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355814; cv=none; b=dL8RG9lqFeR21ARUjTTcvYERz5fSoJuNpgIMOCvrJYtHS1aEurw6wjy5FxyanJDBvsqyErktUWN9vn+Mh4RbtwtJ1yHVx+Zr/EkTMJu7UfWJd6rNwEX90PgvBntzB7cjWgAoV1nNoJKiR9E/Q1sSQ6g25rQklGResHc5jx2Ioxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355814; c=relaxed/simple;
	bh=xZKQkXN/uQsI9B0V7nsk3uVnZebXJ7YR4xQ0BW4ijF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPK6eniS2qI8m7DQbvRjo02TlX5/ZfOTH+PmIdRgzNI5t2dFnUdoxhdohiwxsjxwWIYaJePaGGcoRYzHQHYXYMYaxKwd9sOapYJLiNrWEtepk6LCu8OpnGfUNK9O/YDMvgA17ab8B2xM1Os7SHtSPQe/taz80Wowi0m+o3g/Llc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ffb/eRGo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ffb/eRGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22AB1F000E9;
	Thu, 21 May 2026 09:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779355813;
	bh=E/l36cGMAx/PIN1/dhkMyEcP9K6BP5u2PM+/XbU15d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ffb/eRGo2D7WjVAmnWdaxJxXG9ZdHzPa8sy1kXlD2bUy3Iint2Z2e+kEUPkdhibfg
	 ZUk0wCsLku04+UdWHm2m04ahHy2KfB6ggFW4kKTimW92Qa4RGrzPV98WB2MB7g9ZsQ
	 MEBTCs9NOws7uw9TT2y31syak7ZH/2P3nWo7qv+XSfNFvMazr2ZZu8eCodKAVqdQbV
	 Ua8qSjoDFKCbuCoX2Hcuk8WdpHoqEPWHuOnDgJXmmbrERRBuvERINu0ctYojvv3x1E
	 Ff8P8J239RFfFDQTX4dGoMAOHSD/VcytaDgRsFgMx7hI65F5trTuwjuKyw9F3OZBOt
	 MAUhcmzJqxgFw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v19 02/15] tls: introduce struct tls_prot_ops
Date: Thu, 21 May 2026 17:29:40 +0800
Message-ID: <2dabeca91e31bd148049b46696ca0d37e234b22a.1779355169.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779355169.git.tanggeliang@kylinos.cn>
References: <cover.1779355169.git.tanggeliang@kylinos.cn>
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
 include/net/tls.h  |  19 +++++++++
 net/tls/tls_main.c | 102 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index d8a7fbda4fec..fa67ff40394d 100644
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
 	refcount_t			refcnt;
 	struct list_head		list;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 30dd95fff53e..63bde77317c3 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -120,6 +120,7 @@ CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_128, tls12_crypto_info_aria_gcm_128);
 CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_256, tls12_crypto_info_aria_gcm_256);
 
 static LIST_HEAD(tls_proto_list);
+static LIST_HEAD(tls_prot_ops_list);
 static DEFINE_SPINLOCK(tls_proto_lock);
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 			 const struct proto *base);
@@ -153,6 +154,22 @@ static void tls_proto_cleanup(void)
 	spin_unlock_bh(&tls_proto_lock);
 }
 
+static struct tls_prot_ops *tls_prot_ops_find(int protocol)
+{
+	struct tls_prot_ops *ops, *ret = NULL;
+
+	spin_lock_bh(&tls_proto_lock);
+	list_for_each_entry(ops, &tls_prot_ops_list, list) {
+		if (ops->protocol == protocol) {
+			ret = ops;
+			break;
+		}
+	}
+	spin_unlock_bh(&tls_proto_lock);
+
+	return ret;
+}
+
 void update_sk_prot(struct sock *sk, struct tls_context *ctx)
 {
 	struct tls_proto *proto = ctx->proto;
@@ -1291,6 +1308,82 @@ static struct tcp_ulp_ops tcp_tls_ulp_ops __read_mostly = {
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
+	if (tls_prot_ops_find(ops->protocol))
+		return -EEXIST;
+
+	spin_lock(&tls_proto_lock);
+	list_add_tail(&ops->list, &tls_prot_ops_list);
+	spin_unlock(&tls_proto_lock);
+
+	pr_debug("tls_prot_ops %d registered\n", ops->protocol);
+	return 0;
+}
+
+static void tls_unregister_prot_ops(struct tls_prot_ops *ops)
+{
+	spin_lock(&tls_proto_lock);
+	list_del(&ops->list);
+	spin_unlock(&tls_proto_lock);
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
@@ -1303,13 +1396,19 @@ static int __init tls_register(void)
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
@@ -1320,6 +1419,7 @@ static int __init tls_register(void)
 static void __exit tls_unregister(void)
 {
 	tcp_unregister_ulp(&tcp_tls_ulp_ops);
+	tls_unregister_prot_ops(&tls_tcp_ops);
 	tls_proto_cleanup();
 	tls_strp_dev_exit();
 	tls_device_cleanup();
-- 
2.53.0

